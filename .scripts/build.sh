#!/bin/bash

# set script to stop on errors
set -euo pipefail

Project=$1
VersionNumber=1.0.$2

PackageFile=${Project}.${VersionNumber}.zip

# Create Octopus Package

zip ${PackageFile} CloudFormation.yml

# Upload to Octopus Package Library

curl --request POST https://moonpig.octopus.com/api/packages/raw --header "X-Octopus-ApiKey: ${OctopusApiKey}" -F "data=@${PackageFile}" --fail

# Create a Release of the Project

data=\'{ "Version" : "'"${VersionNumber}"'", "ProjectId" : "'"{$Project}"'", "ChannelId" : "Default" }\'

curl --request POST https://moonpig.octopus.com/api/releases --header "X-Octopus-ApiKey: ${OctopusApiKey}" --data ${data}