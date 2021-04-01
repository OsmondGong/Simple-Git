#!/bin/dash

# creates temporary directory where test is ran
temporary_directory=$(mktemp -d /tmp/testgirt.XXXXXXXXXX)
trap 'rm -rf "$temporary_directory; exit"' INT TERM EXIT
cd "$temporary_directory" || exit 1
export PATH="$PATH:/import/kamen/1/z5293467/Comp/Comp2041/ass1"

# test error output for girt-rm 
# if the file is not in the girt repository
girt-init >/dev/null
echo "a" >a
if (girt-rm a | grep -E -q "girt-rm: error: 'a' is not in the girt repository" && \
    girt-rm --cached a | grep -E -q "girt-rm: error: 'a' is not in the girt repository" && \
    girt-rm --force a | grep -E -q "girt-rm: error: 'a' is not in the girt repository" && \
    girt-rm --force --cached a | grep -E -q "girt-rm: error: 'a' is not in the girt repository")
then
    echo "Successful error message provided when girt-rm is ran on a file that has not been girt-added and is \
not in repository."
else
    echo "Wrong error output provided when girt-rm is ran on a file that has not been girt-added and is not in \
repository."
    exit 1
fi
