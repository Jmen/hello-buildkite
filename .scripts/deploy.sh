#!/bin/bash

# set script to stop on errors
set -euo pipefail

Project=$1
VersionNumber=1.0.$2
Environment=$3

echo ---------------------------------
echo Get Release Parameters
echo ---------------------------------

ProjectId="$(curl https://moonpig.octopus.com/api/projects/$Project --header "X-Octopus-ApiKey: ${OctopusApiKey}" | jq -r '.Id')"

ReleaseId="$(curl https://moonpig.octopus.com/api/projects/$ProjectId/releases/$VersionNumber --header "X-Octopus-ApiKey: $OctopusApiKey" | jq -r '.Id')"

EnvironmentId="$(curl https://moonpig.octopus.com/api/environments/all --header "X-Octopus-ApiKey: $OctopusApiKey" | jq -r --arg name $Environment '.[] | select(.Name == $name).Id')"

TenantIds="$(curl https://moonpig.octopus.com/api/releases/$ReleaseId/deployments/template --header "X-Octopus-ApiKey: $OctopusApiKey" | jq -r '.TenantPromotions[].Id')"

echo --------------------------------------
echo Deploy Release To Tenants i.e. Regions
echo --------------------------------------

for TenantId in ${TenantIds[@]}; do
    curl --request POST https://moonpig.octopus.com/api/deployments --header "X-Octopus-ApiKey: ${OctopusApiKey}" --data '{ "ReleaseID" : "'"$ReleaseId"'", "EnvironmentID" : "'"$EnvironmentId"'", "TenantID" : "'"$TenantId"'" }'
done

