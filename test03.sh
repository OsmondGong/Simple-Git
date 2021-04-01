#!/bin/dash

# creates temporary directory where test is ran
temporary_directory=$(mktemp -d /tmp/testgirt.XXXXXXXXXX)
trap 'rm -rf "$temporary_directory; exit"' INT TERM EXIT
cd "$temporary_directory" || exit 1
export PATH="$PATH:/import/kamen/1/z5293467/Comp/Comp2041/ass1"

# test if girt-commit returns correct error message when invalid arguments are provided.
girt-init >/dev/null
echo "a" >a
if (girt-commit "forgot -m" | grep -E -q "usage: girt-commit \[-a\] -m commit-message")
then
    echo "Successful error message provided when commit is provided with only one argument"
else
    echo "Wrong error output provided when commit is provided with only one argument."
    exit 1
fi

if (girt-commit -m | grep -q "usage: girt-commit \[-a\] -m commit-message")
then
    echo "Successful error message provided when commit message is forgotten"
else
    echo "Wrong error output provided when commit message is forgotten."
    exit 1
fi