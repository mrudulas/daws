#using source command 

#!/ bin/bash

COURSE="my course"

echo "Before the calling $COURSE"

echo "curent process id $$"

source ./otherscript.sh

#variable values changes after calling otherscript variables
# process ids will not be change
echo "after callling processid $COURSE"

#changes in othersctipt will be refelceted in current script. 