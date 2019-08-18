#!/bin/bash

# store the current dir
CUR_DIR=$(pwd)

# Let the person running the script know what's going on.
echo  -e "Pulling in latest changes for all repositories..."

# Find all git repositories and update it to the master latest revision
for i in $(find . -name ".git" | cut -c 3-); do
    echo "";
    echo -e "Pulling: $i \n";

    # We have to go to the .git parent directory to call the pull command
    cd "$i";
    cd ..;

    # finally pull
    git pull origin master;
	
	# pull submodule updates
	git submodule foreach "(git checkout master; git pull)&"

    # lets get back to the CUR_DIR
    cd $CUR_DIR
done

echo "Complete!"

read -p "Press any key to continue." x