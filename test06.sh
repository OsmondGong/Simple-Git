#!/bin/dash

# creates temporary directory where test is ran
temporary_directory=$(mktemp -d /tmp/testgirt.XXXXXXXXXX)
trap 'rm -rf "$temporary_directory; exit"' INT TERM EXIT
cd "$temporary_directory" || exit 1
export PATH="$PATH:/import/kamen/1/z5293467/Comp/Comp2041/ass1"

# test error output for girt-rm 
# if the file in the repository is different to the working file
girt-init >/dev/null
echo "a" >a
girt-add a
echo "b" >a
if (girt-rm a | grep -E -q "girt-rm: error: 'a' in index is different to both to the working file and the repository")
then
    echo "Successful error message provided when girt-rm is ran on a file that had been changed since the last girt-add."
else
    echo "Wrong error output provided when girt-rm is ran on a file that had been changed since the last girt-add."
    exit 1
fi