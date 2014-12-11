#!/bin/bash

export PATH="/bin:/usr/bin"
STATUS=0

echo "get the plugin installed"
vagrant plugin install vagrant-registration

echo "do we have any plugins now?"
exec 5>&1 && OUTPUT=$(vagrant plugin list | tee >(cat - >&5))
if [ $? -ne 0 ]; then
    STATUS=$?
    echo "No plugins at all:  Vagrant plugin test FAILED"
    exit $STATUS
fi

echo "do we have the vagrant-registration plugin?"
TEST=$(echo "$OUTPUT" | grep vagrant-registration)
STATUS=$?
if [ -z "$TEST" ]; then
    echo "Plugin vagrant-registration did not get installed:  Vagrant plugin test FAILED"
    echo "Output of vagrant plugin list:\n$OUTPUT\n"
    echo "Result of \"echo \$OUTPUT | grep vagrant-registration\":\n$TEST\n"
    exit $STATUS
fi

echo "let\'s pull over the vagrantfile to test"
rm ./Vagrantfile
ln -s ../../components/standalone-rhel/Vagrantfile ./

echo "let\'s try and bring the machine up \(but without provisioning to work around https://github.com/whitel/vagrant-registration/issues/8\)"
exec 5>&1 && OUTPUT=$(vagrant up --no-provision | tee >(cat - >&5))
STATUS=$?
if [ $? -ne 0 ]; then
    echo "Failed to bring up the machine: Launch FAILED"
    exit $STATUS
fi

echo "let\'s test that we can connect"
OUTPUT=$(vagrant ssh -c 'echo \"connected!\"' | tee >(cat - >&5))
STATUS=$?
TEST=$(echo "$OUTPUT" | grep connected)
if [ -z "$TEST" ]; then
    echo "Failed to connect to the machine: connect FAILED"
    exit $STATUS
fi

echo "let\'s test that we are subscribed"
OUTPUT=$(vagrant ssh -c 'sudo subscription-manager status' | tee >(cat - >&5))
STATUS=$?
TEST=$(echo "$OUTPUT" | grep Current)
if [ -z "$TEST" ]; then
    echo "We are not subscribed: subscribe FAILED"
    exit $STATUS
fi

echo "let\'s try and do the provisioning"
OUTPUT=$(vagrant up --provision | tee >(cat - >&5))
STATUS=$?
if [ $? -ne 0 ]; then
    echo "Failed to provision the machine: Launch FAILED"
    exit $STATUS
fi

echo "time to clean up"
vagrant destroy -f
rm -rf .vagrant.d Vagrantfile

echo "tests complete!"
