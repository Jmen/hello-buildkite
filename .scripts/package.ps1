$SemVer = "1.0." + $env:BUILDKITE_BUILD_NUMBER
$Id = $env:BUILDKITE_PIPELINE_SLUG
$OctopusApiKey = $env:OctopusApiKey

buildkite-agent artifact download "*" .

octo pack --version=$SemVer --format=zip --id=$Id --basePath ./deployment

octo push --package=$Id.$SemVer.zip --apiKey=$OctopusApiKey --server=https://moonpig.octopus.com