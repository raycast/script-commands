#
# fill in your values of this config!
#

# GitLab instance like https://gitlab.com
instance = "https://gitlab.com"

# Personal access token, see https://docs.gitlab.com/ee/user/profile/personal_access_tokens.html#creating-a-personal-access-token
pat = ""

if not instance:
  print("no GitLab instance provided")
  exit(1)

if not pat:
  print("no personal access token provided")
  exit(1)