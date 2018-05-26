
Project=$1
VersionNumber=1.0.$2

PackageFile=${Project}.${VersionNumber}.zip

# Install dependencies

apt-get update
apt-get install zip -y

# Create Octopus Package

zip ${PackageFile} CloudFormation.yml

# Upload to Octopus Package Library

curl --request POST https://moonpig.octopus.com/api/packages/raw --header "X-Octopus-ApiKey: ${OctopusApiKey}" -F "data=@${PackageFile}"

# Create a Release of the Project

curl --request POST https://moonpig.octopus.com/api/releases --header "X-Octopus-ApiKey: ${OctopusApiKey}" --data '{ "Version":"${VersionNumber}", "ProjectId":"${Project}" }'