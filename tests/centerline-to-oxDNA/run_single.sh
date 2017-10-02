#!/bin/bash

CORRECT_OUTPUT_CONF="correct_single_output.oxdna"
CORRECT_OUTPUT_TOP="correct_single_output.top"
OUTPUT_CONF="centerline.dat.oxdna"
OUTPUT_TOP="centerline.dat.top"

if [ ! -s centerline.dat ]
then
	echo "Can't find input files. Are you sure you are in the right folder?"
	exit 1
fi

python ../../src/centerline-to-oxDNA.py centerline.dat -p 0.1 -q sequence.dat --ssDNA --open
diff_lines=$(diff $CORRECT_OUTPUT_CONF $OUTPUT_CONF)
ret_conf=$?

diff_lines=$(diff $CORRECT_OUTPUT_TOP $OUTPUT_TOP)
ret_top=$?

if [ $ret_conf -ne 0 ] || [ $ret_top -ne 0 ]
then
	echo "TEST FAILED";
	exit 1
else
	echo "TEST PASSED";
	rm $OUTPUT_CONF $OUTPUT_TOP
	exit 0
fi 
