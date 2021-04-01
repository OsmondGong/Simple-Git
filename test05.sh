#!/bin/dash

# creates temporary directory where test is ran
temporary_directory=$(mktemp -d /tmp/testgirt.XXXXXXXXXX)
trap 'rm -rf "$temporary_directory; exit"' INT TERM EXIT
cd "$temporary_directory" || exit 1
export PATH="$PATH:/import/kamen/1/z5293467/Comp/Comp2041/ass1"

# test error output for girt-rm 
# if the file has staged changes in index
girt-init >/dev/null
echo "a" >a
girt-add a
if (girt-rm a | grep -E -q "girt-rm: error: 'a' has staged changes in the index")
then
    echo "Successful error message provided when girt-rm is ran on a file that has been changed since the last commit \
and has been girt-added."
else
    echo "Wrong error output provided when girt-rm is ran on a file that has been changed since the last commit and \
has been girt-added."
    exit 1
fi
