$SemVer = "1.0." + $env:BUILDKITE_BUILD_NUMBER
$Id = $env:BUILDKITE_PIPELINE_SLUG
$OctopusApiKey = $env:OctopusApiKey
$Tenant = $env:Tenant
$Environment = $env:Environment

octo deploy-release --project $Id --server https://moonpig.octopus.com --ApiKey $OctopusApiKey --version $SemVer --tenant $Tenant --deployto $Environment --progress --logLevel verbose