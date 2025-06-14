# EGA submission

# Quickstart

Get it done on the spot with an AWS instance (a.k.a: to be automated with AWS Batch):

```
$ sudo yum install docker && gpasswd -a ec2-user docker # Note: Only needed if your AWS instance doesn't have docker yet (docker ps -a works?)
                                                        # Note2: Logout and login for the docker group add to be successful
$ git clone https://github.com/umccr/ega-submit && cd ega-submit
$ vim ega-files.txt <--- the input file list, consisting of a full s3:// url to the object, one per line
$ export EGA_BOX=ega-box-1578
$ export EGA_PASSWORD=<PASSWORD_HERE>
$ ./bin/serial_ega_upload.sh
```

The serial script will (very slowly and screaming to be parallelized) download each file in `ega-files` from S3, encrypt and upload to the `EGA_BOX`.

Please note that the serial script downloads, encrypts and **deletes** files. This is by design, so that a small AWS SPOT box with almost no disk space
can be used on the span of days, without risk of saturating the (majorly unknown) ingress limit specifications for EGA, therefore avoiding timeouts.

Also, EGA cryptor's threading granularity is at a file level, meaning that a file cannot be encrypted by many threads at once. Instead, only one thread 
per file can be used to encrypt.

# Running

By using [EGA cryptor][ega-cryptor] and Aspera Connect:

1. Input data goes under `data` folder (i.e: `mkdir -p data/enc` first).
2. Run, for instance: `$ ./bin/submit.sh data/htsnexus_test_NA12878.bam ega-box-NNNN pass`.
3. `data/enc` contains encrypted data that have been sent to EBI's EGA server.

# Similar third party solutions

* https://github.com/DKFZ-ODCF/ega-cluster-cryptor

[ega-cryptor]: https://ega-archive.org/submission/tools/egacryptor
