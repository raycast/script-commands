import json
import urllib.request
import ssl
import certifi
import gitlabconfig as config

class GitLab:
    def __init__(self):
        self.instance = config.instance
        self.pat = config.pat

    def get_call(self, url):
        url = f"{self.instance}/api/v4/{url}"
        request = urllib.request.Request(url)
        request.add_header("PRIVATE-TOKEN", self.pat)

        try:
            response = urllib.request.urlopen(request, context=ssl.create_default_context(cafile=certifi.where())) # context= avoids local ssl errors
        except urllib.error.HTTPError as e:
            print("Error code: ", e.code)
            print(f"Failed to get todos from {self.instance}")
            exit(1)
        except urllib.error.URLError as e:
            print("Error reason: ", e.reason)
            print("Failed to reach {instance}")
            exit(1)
        else:
            data_text = response.read().decode("utf-8")
            return json.loads(data_text)
