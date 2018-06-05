$SemVer = "1.0." + $env:BUILDKITE_BUILD_NUMBER
$Id = $env:BUILDKITE_PIPELINE_SLUG
$OctopusApiKey = $env:OctopusApiKey

buildkite-agent artifact download "*" .

octo pack --version=$SemVer --format=zip --id=$Id --basePath ./deployment

octo push --package=$Id.$SemVer.zip --server=https://moonpig.octopus.com --apiKey=$OctopusApiKey

octo create-release --project $Id --version $SemVer --packageversion $SemVer --server https://moonpig.octopus.com --ApiKey $env:OctopusApiKey