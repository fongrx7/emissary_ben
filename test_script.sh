#!/bin/bash

sudo systemctl start docker
sudo docker build -t emissary:latest --build-arg PROJ_VERS=$(./emissary version | grep Version: | awk {'print $3 " " '}) --build-arg IMG_NAME=latest .

sudo timeout -s SIGINT 120s sudo /usr/local/bin/docker-compose up --force-recreate > test_results

TEST_RESULTS=0

TEST_VAL="$(more test_results | grep "filename: emissary-knight.png" | echo $?)"
TEST_RESULTS=$(( $TEST_RESULT + $TEST_VAL))

if [ "$TEST_RESULTS" -ne 0 ]
then
   echo 'Failed to process emissary-knight.png'
   exit 1
fi

TEST_VAL="$(more test_results | grep "filetype: PNG" | echo $?)"
TEST_RESULTS=$(( $TEST_RESULT + $TEST_VAL))

if [ "$TEST_RESULTS" -ne 0 ]
then
   echo 'Failed to determine that emissary-knight.png was a PNG file'
   exit 1
fi

echo 'All tests passed!'
exit 0