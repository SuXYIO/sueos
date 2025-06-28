#!/bin/bash
# run bochs emulation for the image

if [ "$#" -eq 0 ]; then
	echo 'No args spec, using default.'
	echo '(Executing bochs -f ./bochsrc.bxrc.)'
	bochs -f bochsrc.bxrc
elif [ "$#" -gt 0 ]; then
	bochs -f bochsrc.bxrc "$*"
fi
