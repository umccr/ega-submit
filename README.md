# EGA submission

# Building

1. docker build . -f docker/Dockerfile.aspera -t aspera
2. docker build . -f docker/Dockerfile.egacrypt -t egacrypt

# Running

By using [EGA cryptor][ega-cryptor] and Aspera Connect:

1. Input data goes under `data` folder (`mkdir -p data/enc` first).
2. Run, for instance: `$ ./bin/submit.sh data/htsnexus_test_NA12878.bam ega-box-NNNN pass`.
3. `data/enc` contains encrypted data that have been sent to EBI's EGA server.

TODO: Integrate https://github.com/aws-samples/aws-cdk-examples/tree/master/python/lambda-from-container
