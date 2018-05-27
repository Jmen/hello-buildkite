#!/bin/bash

# set script to stop on errors
set -euo pipefail

Project=$1
VersionNumber=1.0.$2

PackageFile=$Project.$VersionNumber.zip

echo ------------------------
echo Creating Octopus Package
echo ------------------------

zip $PackageFile CloudFormation.yml

echo ---------------------------------
echo Upload to Octopus Package Library
echo ---------------------------------

curl --request POST https://moonpig.octopus.com/api/packages/raw --header "X-Octopus-ApiKey: $OctopusApiKey" -F "data=@$PackageFile"

echo -------------------------------
echo Create a Release of the Project
echo -------------------------------

ProjectId="$(curl https://moonpig.octopus.com/api/projects/$Project --header "X-Octopus-ApiKey: ${OctopusApiKey}" | jq -r '.Id')"
ChannelId="$(curl https://moonpig.octopus.com/api/projects/$ProjectId/channels --header "X-Octopus-ApiKey: ${OctopusApiKey}" | jq -r '.Items[0].Id')"

curl --request POST https://moonpig.octopus.com/api/releases --header "X-Octopus-ApiKey: ${OctopusApiKey}" --data '{ "Version" : "'"$VersionNumber"'", "ProjectId" : "'"$ProjectId"'", "ChannelId" : "'"$ChannelId"'", "SelectedPackages" : [{ "StepName" : "Deploy", "Version" : "'"$VersionNumber"'" }] }' 

