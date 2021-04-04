#!/bin/dash

# creates temporary directory where test is ran
temporary_directory=$(mktemp -d /tmp/testgirt.XXXXXXXXXX)
trap 'rm -rf "$temporary_directory; exit"' INT TERM EXIT
cd "$temporary_directory" || exit 1
export PATH="$PATH:/import/kamen/1/z5293467/Comp/Comp2041/ass1"

# test checkout without committing changes 

girt-init >/dev/null
echo "hello" >a
echo "hello:]" >b
girt-add a b >/dev/null
girt-commit -m a0 >/dev/null
girt-branch a >/dev/null
girt-checkout a >/dev/null
echo "!" >>a
echo "!" >>b
girt-add a b >/dev/null
girt-commit -m a1 >/dev/null
echo "hey" >>a
echo "hi" >>b
girt-add b >/dev/null
rm b
if (girt-checkout master | grep -q "girt-checkout: error: Your changes to the following files would be overwritten by checkout:
a
b")
then
    echo "Successfully outputs correct error message when girt-checkout is called without committing the files"
else
    echo "Failed to output correct error message when girt-checkout is called without committing the files"
fi