#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title CNYTransform
# @raycast.mode silent
# @raycast.packageName Conversions
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder"}

# Optional parameters:
# @raycast.icon 🇨🇳

cny=${1}

result=$(curl -s "http://api.tianapi.com/txapi/cnmoney/index?key=9779dac20a4237136b7694260b4cf537&money=$cny" | \
    jq '.newslist[0].cnresult' | LANG=en_US.UTF-8 pbcopy)

echo "复制到剪贴板"