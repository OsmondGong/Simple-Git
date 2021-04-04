#!/bin/dash

# creates temporary directory where test is ran
temporary_directory=$(mktemp -d /tmp/testgirt.XXXXXXXXXX)
trap 'rm -rf "$temporary_directory; exit"' INT TERM EXIT
cd "$temporary_directory" || exit 1
export PATH="$PATH:/import/kamen/1/z5293467/Comp/Comp2041/ass1"

girt-init >/dev/null
echo "hi" >a
girt-add a >/dev/null
girt-commit -m a >/dev/null
girt-branch a >/dev/null
girt-branch b >/dev/null
girt-checkout a >/dev/null
echo "hello" >a
girt-add a >/dev/null
girt-commit -m a1 >/dev/null
girt-checkout b >/dev/null
echo "hey" >a
girt-add a >/dev/null
girt-commit -m b >/dev/null
if (girt-merge a -m "conflict" | grep -q "girt-merge: error: can not merge")
then
    echo "Successfully outputs error message upon merge conflict."
else
    echo "Failed to output error message upon merge conflict."
fi