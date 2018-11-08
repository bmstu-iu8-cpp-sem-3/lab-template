#!/bin/bash
export CTEST_OUTPUT_ON_FAILURE=true
./tools/polly/bin/polly --reconfig --toolchain gcc-7-cxx17-pic --test --config-all Debug --fwd CMAKE_EXE_LINKER="-fuse-ld=gold" BUILD_COVERAGE=ON
./tools/polly/bin/polly --reconfig --toolchain gcc-7-cxx17-pic --target gcov --config-all Debug --fwd CMAKE_EXE_LINKER="-fuse-ld=gold" BUILD_COVERAGE=ON
./tools/polly/bin/polly --reconfig --toolchain gcc-7-cxx17-pic --target lcov --config-all Debug --fwd CMAKE_EXE_LINKER="-fuse-ld=gold" BUILD_COVERAGE=ON
gcovr -r  .

REPORT_DATA=$(gcovr -r  . | base64)
SLUG=$TRAVIS_REPO_SLUG
PR=$TRAVIS_PULL_REQUEST
HEAD_BRANCH=$TRAVIS_BRANCH
HEAD_SHA=$TRAVIS_COMMIT
POST_DATA="{\"report\": \"$REPORT_DATA\", \"slug\": \"$SLUG\", \"pull_request\": \"$PR\", \"head_branch\": \"$HEAD_BRANCH\", \"head_sha\": \"$HEAD_SHA\", \"need_comment\": false}"
if [[ $TRAVIS_PULL_REQUEST != 'false' ]]; then
curl -x POST http://borodin.dev.bmstu.cloud -d $POST_DATA;
fi
echo $POST_DATA
