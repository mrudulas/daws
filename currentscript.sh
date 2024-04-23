#!/ bin/bash

COURSE="my course"

echo "Before the calling $COURSE"

echo "curent process id $$"

./otherscript.sh
# otherscript should has exec permision
#variable values will not change after calling otherscript variables
# process ids will be different
echo "after callling processid $COURSE"

#changes in otherscript will not affect the current script


