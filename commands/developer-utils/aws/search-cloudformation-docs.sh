#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search AWS CloudFormation
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/aws-cloudformation.png
# @raycast.argument1 { "type": "text", "placeholder": "AWS::Events::Rule", "percentEncoded": true }

# Documentation:
# @raycast.description Search AWS CloudFormation Documentation For Types
# @raycast.author Luke Hendrick
# @raycast.authorURL https://www.linkedin.com/in/luke-hendrick/

open "https://docs.aws.amazon.com/search/doc-search.html?searchPath=documentation-guide&searchQuery=$1&this_doc_product=AWS%20CloudFormation&this_doc_guide=User%20Guide&facet_doc_product=AWS%20CloudFormation&facet_doc_guide=User%20Guide"
