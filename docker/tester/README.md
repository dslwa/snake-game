# A container for running application tests in an isolated environment.
# It is based on the dslwa525/dependencies:1.0 image, so it has:
* Go and all the tools for building test
* Access to the application code via the volume

# Local build
`docker build -t dslwa525/snake-tester:1.0 .`

# Tests execution
`docker run --rm -v $(pwd)/../..:/workspace dslwa525/snake-tester:1.0`
