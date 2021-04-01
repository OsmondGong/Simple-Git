#!/bin/dash

# creates temporary directory where test is ran
temporary_directory=$(mktemp -d /tmp/testgirt.XXXXXXXXXX)
trap 'rm -rf "$temporary_directory; exit"' INT TERM EXIT
cd "$temporary_directory" || exit 1
export PATH="$PATH:/import/kamen/1/z5293467/Comp/Comp2041/ass1"

# test if adding a non-existant file outputs error correctly
girt-init >/dev/null
if (girt-add random.txt | grep -q "girt-add: error: can not open 'random.txt'")
then
    echo "Successful error output when adding a non-existant file."
else
    echo "Wrong error output when adding a non-existant file."
fi