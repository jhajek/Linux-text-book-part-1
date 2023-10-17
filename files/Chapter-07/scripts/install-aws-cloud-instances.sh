#!/bin/bash
# https://stackoverflow.com/questions/38578528/base64-encoding-new-line
# base64 will line wrap after 76 characters -- causing the aws ec2 create-launch-template to break
# the -w 0 options will stop the line break from happening in the base64 output 
#!/bin/bash

BASECONVERT=$(base64 -w 0 < ${6})

# This is the JSON object that is passed to the create template in a more readable form
# We will save it to a variable here named JSON
# Then write it out to a file -- and then attach it to the --launch-template-data option
# Otherwise we are running into issues with the dynamic bash variables

aws ec2 create-launch-template --launch-template-name ${12} --version-description AutoScalingVersion1 --launch-template-data file://config.json --region us-east-2

# Launch Template Id 
LAUNCHTEMPID=$(aws ec2 describe-launch-templates --output=json | jq -r '.LaunchTemplates[].LaunchTemplateId')  
