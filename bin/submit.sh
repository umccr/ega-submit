#!/bin/bash -x
#SBATCH --output %J.out
#SBATCH --error %J.err
#SBATCH --time=00:50:00

HOSTNAME="fasp.ega.ebi.ac.uk"
SAMPLE=$1
SAMPLE_NAME="$(basename $SAMPLE)"

USERNAME=$2
PASSWORD=$3

# Encrypt
docker run -v $PWD/data:/data egacrypt -f -i /data/$SAMPLE_NAME -o /data/enc/$SAMPLE_NAME

# Submit
docker run --env ASPERA_SCP_PASS=$PASSWORD aspera -P33001 -O33001 -QT -L- $SAMPLE $USERNAME@$HOSTNAME:/. 
