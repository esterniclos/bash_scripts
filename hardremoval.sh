#!/bin/bash
#
#
# Ester Niclós Ferreras


# This script deletes all previously deleted but still existing files from disk.
# Allocates all space with random files, preventing deleted files to be recovered.
#

#
# In windows, can be used with cygwin.
# MYDISK="/cygdrive/d"
# OUTSAMPLE="$MYDISK/rand.uua"


MYDISK="/mnt/sdb1"
OUTSAMPLE="$MYDISK/rand.uua"

function create_rand {

	echo "Creating initial random block"
	dd if=/dev/urandom of=$OUTSAMPLE bs=64M count=16

}


function poblateDisk {

	
	i=0
	echo "poblate_disk $MYDISK"

	while [[  $(df | grep $MYDISK | grep '100%' | wc -l) -ne 1 ]]; do
		new=$(printf "%s%04d.uua"  "$OUTSAMPLE" "$i")
		echo "Creating $new"
        cp -fp $OUTSAMPLE $new
		let i=i+1		
	done

	rm -f "$OUTSAMPLE*"
	
}

create_rand
poblateDisk 
