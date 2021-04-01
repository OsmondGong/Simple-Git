#!/bin/dash

# creates temporary directory where test is ran
temporary_directory=$(mktemp -d /tmp/testgirt.XXXXXXXXXX)
trap 'rm -rf "$temporary_directory; exit"' INT TERM EXIT
cd "$temporary_directory" || exit 1
export PATH="$PATH:/import/kamen/1/z5293467/Comp/Comp2041/ass1"

# test if girt-init outputs correct error if .girt directory exists
girt-init >/dev/null
if (girt-init | grep -q "girt-init: error: .girt already exists")
then
    echo "Successful error output when girt-init is ran and .girt directory had already been created."
else
    echo "Wrong error output when girt-init is ran and .girt directory had already been created."
fi