
project=$1
versionNumber=$2

echo zip ${project}.1.0.${versionNumber}.zip CloudFormation.yml

# curl -X POST -H "X-Octopus-ApiKey: $OctopusApiKey" \
# -F "file=@\"${project}.1.0.0.zip\";filename=\"${YourApp}.1.0.0.zip\";type=application/zip" \
# https://moonpig.octopus.com/api/packages/raw?replace=true

# curl -X POST https://moonpig.octopus.com/api/packages/raw -H "X-Octopus-ApiKey: API-YOURAPIKEY" -F "data=@Demo.1.0.0.zip"