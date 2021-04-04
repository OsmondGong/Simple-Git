#!/bin/dash

# creates temporary directory where test is ran
temporary_directory=$(mktemp -d /tmp/testgirt.XXXXXXXXXX)
trap 'rm -rf "$temporary_directory; exit"' INT TERM EXIT
cd "$temporary_directory" || exit 1
export PATH="$PATH:/import/kamen/1/z5293467/Comp/Comp2041/ass1"

# test deleting branches that is a commit behind
girt-init >/dev/null
echo hello >a
girt-add a >/dev/null
girt-commit -m commit-A >/dev/null
girt-branch branchA >/dev/null
echo world >b
girt-add b >/dev/null
girt-commit -m commit-B >/dev/null
if (girt-branch -d branchA | grep -q "Deleted branch 'branchA'")
then
    if (! girt-branch | grep -q "branchA")
    then
        echo "Successfully deletes branch"
    else
        "Produced correct message but failed to delete branch"
    fi
else
    echo "Failed to delete branch"
fi