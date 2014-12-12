#!/bin/bash

export PATH="/bin:/usr/bin"
STATUS=0

#get the plugin installed
vagrant plugin install vagrant-registration

#do we have any now?
exec 5>&1 && OUTPUT=$(vagrant plugin list | tee >(cat - >&5))
if [ $? -ne 0 ]; then
    STATUS=$?
    echo "No plugins at all:  Vagrant plugin test FAILED"
    exit $STATUS
fi

#do we have the reg plugin?
TEST=$(echo "$OUTPUT" | grep vagrant-registration)
STATUS=$?
if [ -z "$TEST" ]; then
    echo "Plugin vagrant-registration did not get installed:  Vagrant plugin test FAILED"
    echo "Output of vagrant plugin list:\n$OUTPUT\n"
    echo "Result of \"echo \$OUTPUT | grep vagrant-registration\":\n$TEST\n"
    exit $STATUS
fi

#lets pull over the files to test
cp -R ./../components/rhel-with-docker ./
cd rhel-with-docker/dev/

echo "incomplete test"
exit

#lets try and bring the machine up
OUTPUT=$(vagrant up | tee >(cat - >&5))
STATUS=$?
if [ $? -ne 0 ]; then
    echo "Failed to bring up the machine: Launch FAILED"
    exit $STATUS
fi

#lets test that we can connect
OUTPUT=$(vagrant ssh -c 'echo \"connected!\"' | tee >(cat - >&5))
STATUS=$?
TEST=$(echo "$OUTPUT" | grep connected)
if [ -z "$TEST" ]; then
    echo "Failed to connect to the machine: connect FAILED"
    exit $STATUS
fi

#lets test that we are subscribed
OUTPUT=$(vagrant ssh -c 'sudo subscription-manager status' | tee >(cat - >&5))
STATUS=$?
TEST=$(echo "$OUTPUT" | grep Current)
if [ -z "$TEST" ]; then
    echo "We are not subscribed: subscribe FAILED"
    exit $STATUS
fi

#time to clean up
vagrant destroy -f
rm -rf .vagrant.d Vagrantfile

echo "Test(s) complete!"
