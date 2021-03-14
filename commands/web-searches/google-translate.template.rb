#!/usr/bin/ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Google Translate
# @raycast.mode compact
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon 🌍
# @raycast.argument1 { "type": "text", "placeholder": "Query" }

# Documentation:
# @raycast.description Translates via Google Translate
# @raycast.author Roland Leth
# @raycast.authorURL https://runtimesharks.com

require 'net/http'
require 'json'
require 'open-uri'

query = ARGV[0]

# You need to fill in the source language and the target language.
# By default, if you search for some text, it will perform a `sl>tl` translation.
# There are three ways of using the command; let's say `sl = en` and `tl = de`:
# - if you want to translate from `en` to `de`, just write your query;
# - if you want a different `sl` and `tl`, prefix your query with `!sl>tl`,
# so from `jp` to `fr` you'd write `!jp>fr query`;
# - if you want a different source languages, prefix your query with `!sl`,
# so from `jp` to `de`, you'd write `!jp query`.

# Usually translations are short enough, which is why this uses a `compact` mode,
# but if you'll be using it for longer translations, change line 6 to `fullOutput`.

is_custom = query[0] == "!"
s = query.split(' ')
q = s.join(" ")
sl = "" # Source language
tl = "" # Target language

# Require a ! at the start for anything else than the default sl>tl,
# so it doesn't perform useless and invalid calls.
if is_custom and s.count > 1
    q = s[1..].join(" ")

    # Ignore the "!".
    langs = s.first[1..-1].split('>')

    if langs.first.length >= 2
        sl = langs.first
    end

    if langs.count == 2 and langs[1].length >= 2
        tl = langs[1]
    end
end

# If the length of the query is less than 2, it won't return anything valid.
# If it starts with !, then the split has to be 2, otherwise we haven't entered a query yet.
if (is_custom and s.count <= 1) or q.length < 2
    exit 1
end

uri = URI("https://translate.googleapis.com/translate_a/single?client=gtx&sl=#{sl}&tl=#{tl}&dt=t&q=#{q}")

http = Net::HTTP.new(uri.host, 80)
request = Net::HTTP::Get.new(uri, initheader = {'Content-Type' => 'application/json', 'Accept' => 'application/json'})
results = http.request(request).read_body.force_encoding('UTF-8')

puts JSON.parse(results)[0][0]
    .filter { |r| r.is_a? String and r != q }
    .uniq
    .join("\n\n")
