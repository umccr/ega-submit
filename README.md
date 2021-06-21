# EGA submission

# Quickstart

Get it done on the spot with an AWS instance (a.k.a: to be automated with AWS Batch):

```
$ sudo yum install docker && gpasswd -a ec2-user docker # Note: Only needed if your AWS instance doesn't have docker yet (docker ps -a works?)
							# Note2: Logout and login for the docker group add to be successful
$ git clone https://github.com/umccr/ega-submit && cd ega-submit
$ docker build . -f docker/Dockerfile.aspera -t aspera
$ docker build . -f docker/Dockerfile.egacrypt -t egacrypt
$ vim ega-files.txt <--- the input file list
$ export EGA_BOX=ega-box-1578
$ export EGA_PASSWORD=<PASSWORD_HERE>
$ ./bin/serial_ega_upload.sh
```

# Building

1. docker build . -f docker/Dockerfile.aspera -t aspera
2. docker build . -f docker/Dockerfile.egacrypt -t egacrypt

# Running

By using [EGA cryptor][ega-cryptor] and Aspera Connect:

1. Input data goes under `data` folder (i.e: `mkdir -p data/enc` first).
2. Run, for instance: `$ ./bin/submit.sh data/htsnexus_test_NA12878.bam ega-box-NNNN pass`.
3. `data/enc` contains encrypted data that have been sent to EBI's EGA server.

[ega-cryptor]: https://ega-archive.org/submission/tools/egacryptor
