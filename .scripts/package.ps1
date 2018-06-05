param (
	[string]$VersionNumber = $(throw "VersionNumber parameter is required."),
	[string]$Id = $(throw "Id parameter is required."),
	[string]$OctopusApiKey = $(throw "OctopusApiKey parameter is required.")
)

buildkite-agent artifact download "*" .

$SemVer = "1.0." + $versionNumber

octo pack --version=$SemVer --format=zip --id=$Id --basePath ./deployment

octo push --package=$Id.$SemVer.zip --apiKey=$OctopusApiKey --server=https://moonpig.octopus.com