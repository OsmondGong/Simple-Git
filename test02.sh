#!/bin/dash

# creates temporary directory where test is ran
temporary_directory=$(mktemp -d /tmp/testgirt.XXXXXXXXXX)
trap 'rm -rf "$temporary_directory; exit"' INT TERM EXIT
cd "$temporary_directory" || exit 1
export PATH="$PATH:/import/kamen/1/z5293467/Comp/Comp2041/ass1"

# test if correct error is outputed when an "unordinary" file is added
girt-init >/dev/null
echo "i am unordinary! >:D" >_grrrr
if (girt-add _grrrr | grep -q "girt-add: error: invalid filename '_grrrr'")
then
    echo "Successful error output when adding a file with invalid file name."
else
    echo "Wrong error output when adding a file with invalid file name."
fi