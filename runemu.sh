#!/bin/bash
# run bochs emulation for the image

if [ "$#" -eq 0 ]; then
	echo 'No args spec, using default.'
	echo '(Executing with ./bochsrc.bxrc.)'
	bochs -f bochsrc.bxrc
elif [ "$#" -gt 0 ]; then
	if [ "$#" -gt 1 ]; then
		echo 'More than one arg given, ignoring the rest.'
		echo "(Executing with $1)"
	fi
	bochs -f "$1"
fi
