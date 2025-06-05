#!/bin/bash -x
#SBATCH --output %J.out
#SBATCH --error %J.err
#SBATCH --time=00:50:00

#PREFIX="/data/"
PREFIX=""
HOSTNAME="fasp.ega.ebi.ac.uk"
SAMPLE=$1
SAMPLE_NAME="$(basename $SAMPLE)"

USERNAME=$2
PASSWORD=$3

if pgrep -x "dockerd" > /dev/null; then
# Encrypt
docker run -v ${PWD}${PREFIX}:${PREFIX} ghcr.io/umccr/egacrypt -f -i ${PREFIX}${SAMPLE_NAME} -o $PREFIX/enc/$SAMPLE_NAME

# Submit
docker run -v ${PWD}${PREFIX}/enc:${PREFIX} --env ASPERA_SCP_PASS=$PASSWORD ghcr.io/umccr/aspera -k1 -P33001 -O33001 -QT -L- ${PREFIX}$SAMPLE_NAME $USERNAME@$HOSTNAME:/.
else
# Assumes the following alias in .bash_profile:
# alias ega-cryptor='java -jar .local/ega-cryptor-2.0.0.jar'
#
        ./bin/ega-cryptor.sh -t$(nproc) -i ${PREFIX}${SAMPLE} -o ${PREFIX}/data/enc
        ./bin/ega-cryptor.sh -t$(nproc) -i ${PREFIX}${SAMPLE}.bai -o ${PREFIX}/data/enc
        aspera -k1 -P33001 -O33001 -QT -L- ${PREFIX}/data/enc/${SAMPLE_NAME}.gpg $USERNAME@$HOSTNAME:/.
        aspera -k1 -P33001 -O33001 -QT -L- ${PREFIX}/data/enc/${SAMPLE_NAME}.md5 $USERNAME@$HOSTNAME:/.
        aspera -k1 -P33001 -O33001 -QT -L- ${PREFIX}/data/enc/${SAMPLE_NAME}.bai.gpg $USERNAME@$HOSTNAME:/.
        aspera -k1 -P33001 -O33001 -QT -L- ${PREFIX}/data/enc/${SAMPLE_NAME}.bai.md5 $USERNAME@$HOSTNAME:/.
fi
