#!/bin/bash

# set script to stop on errors
set -euo pipefail

Project=$1
VersionNumber=1.0.$2

PackageFile=$Project.$VersionNumber.zip

# Create Octopus Package

zip $PackageFile CloudFormation.yml

# Upload to Octopus Package Library

curl --request POST https://moonpig.octopus.com/api/packages/raw --header "X-Octopus-ApiKey: $OctopusApiKey" -F "data=@$PackageFile"

# Create a Release of the Project

ProjectId="$(curl https://moonpig.octopus.com/api/projects/$Project --header "X-Octopus-ApiKey: ${OctopusApiKey}" | jq -r '.Id')"
ChannelId="$(curl https://moonpig.octopus.com/api/projects/$ProjectId/channels --header "X-Octopus-ApiKey: ${OctopusApiKey}" | jq -r '.Items[0].Id')"

curl --request POST https://moonpig.octopus.com/api/releases --header "X-Octopus-ApiKey: ${OctopusApiKey}" --data '{ "Version" : "'"$VersionNumber"'", "ProjectId" : "'"$ProjectId"'", "ChannelId" : "'"$ProjectId"'" }'

