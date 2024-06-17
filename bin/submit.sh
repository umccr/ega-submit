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
docker run -v $PWD/data:/data ghcr.io/umccr/egacrypt -f -i /data/$SAMPLE_NAME -o /data/enc/$SAMPLE_NAME

# Submit
docker run -v $PWD/data/enc:/data --env ASPERA_SCP_PASS=$PASSWORD ghcr.io/umccr/aspera -k1 -P33001 -O33001 -QT -L- /data/$SAMPLE_NAME $USERNAME@$HOSTNAME:/.
