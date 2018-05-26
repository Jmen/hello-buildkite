
Project=$1
VersionNumber=1.0.$2
OctopusApiKey=$3

PackageFile=${Project}.${VersionNumber}.zip

# Install dependencies - move to docker image creation

apt-get update
apt-get install zip -y

# Create Octopus Package

zip ${PackageFile} CloudFormation.yml

# Upload to Octopus Package Library

curl -X POST https://moonpig.octopus.com/api/packages/raw -H "X-Octopus-ApiKey: ${OctopusApiKey}" -F "data=@${PackageFile}"