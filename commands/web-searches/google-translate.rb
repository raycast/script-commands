#!/usr/bin/ruby

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Google Translate
# @raycast.mode compact
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon 🌍
# @raycast.argument1 { "type": "text", "placeholder": "Query" }
# @raycast.argument2 { "type": "text", "placeholder": "From", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "To", "optional": true }

# Documentation:
# @raycast.description Translates via Google Translate
# @raycast.author Roland Leth
# @raycast.authorURL https://runtimesharks.com

# Usually translations are short enough, which is why this uses a `compact` mode,
# but if you'll be using it for longer translations, change line 6 to `fullOutput`.
# If you do change to `fullOutput`, you might also want to change the last line
# of the script to `.join("\n\n")`, so each result appears on its own line.

require 'net/http'
require 'json'
require 'open-uri'

q = ARGV[0]
sl = ARGV[1].nil? || ARGV[1].empty? ? "en" : ARGV[1] # Source language
tl = ARGV[2].nil? || ARGV[2].empty? ? "ro" : ARGV[2] # Target language

# If the length of the query is less than 2, it won't return anything valid.
if q.length < 2
    exit 1
end

uri = URI('https://translate.googleapis.com/translate_a/single')
uri.query = URI::encode_www_form(
  'client' => 'gtx',
  'sl' => sl,
  'tl' => tl,
  'dt' => 't',
  'q' => q
)

http = Net::HTTP.new(uri.host, 80)
request = Net::HTTP::Get.new(uri, initheader = {'Content-Type' => 'application/json', 'Accept' => 'application/json'})
results = http.request(request).read_body.force_encoding('UTF-8')

puts JSON.parse(results)[0][0]
    .filter { |r| r.is_a? String and r != q }
    .uniq
    .join(", ")
