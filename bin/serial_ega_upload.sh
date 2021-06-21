#!/bin/sh -x
# Terribly inefficient submission script given a list of S3 files to submit.
# Since EBI's EGA is known for dropping out connections when there is too much traffic, this could be useful in some cases (as slow, serial, upload method).
#
# NOTE: Modify $EGA_BOX and $PASSWORD to suit your needs

for sample in `cat ega-files.txt`
do
        sample_name=`basename $sample`
        time aws s3 cp $sample data/
        time ./bin/submit.sh data/$sample $EGA_BOX $EGA_PASSWORD
        rm -f data/$sample_name
        sudo rm -rf data/enc/$sample_name
done
