#!/bin/bash

timeout -s SIGINT 120s sudo docker-compose up --force-recreate | tee test_results

TEST_RESULTS=0

more test_results | grep "filename: emissary-knight.png" > /dev/null
TEST_VAL="$(echo $?)"
TEST_RESULTS=$(( $TEST_RESULT + $TEST_VAL))

if [ "$TEST_RESULTS" -ne 0 ]
then
   echo 'Failed to process emissary-knight.png'
   exit 1
fi

more test_results | grep "filetype: PNG" > /dev/null
TEST_VAL="$(echo $?)"
TEST_RESULTS=$(( $TEST_RESULT + $TEST_VAL))

if [ "$TEST_RESULTS" -ne 0 ]
then
   echo 'Failed to determine that emissary-knight.png was a PNG file'
   exit 1
fi

echo 'All tests passed!'
exit 0
