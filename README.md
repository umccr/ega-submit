# EGA submission docker in a :chestnut: :shell:

By using [EGA cryptor][ega-cryptor] and Aspera Connect:

```shell
docker run -v $PWD:/mnt amazoncorretto:8u262-alpine-jre java -jar /mnt/ega-cryptor-2.0.0.jar -i /mnt/test -o /mnt/test
docker run --rm  -it ibmcom/aspera-cli ascp
```

The arguments for the aspera cli are [passed as env vars on the official container docs][ibmcom/aspera-cli] :facepalm::

```shell
docker run --rm \
-e ACLI_SUBCOMMAND="node" \
-e ACLI_DIRECTION=download \
-e ACLI_USERNAME="my-access-key" \
-e ACLI_PASSWORD="my-password" \
-e ACLI_HOST="mynode.com" \
-e ACLI_OPTS="-i" \
-e ACLI_REMOTE_PATH="/download_me.txt" \
-e ACLI_LOCAL_PATH="/volume" \
-e ACLI_PORT=443 \
-v `pwd`/volume:/volume:rw \
ibmcom/aspera-cli
```

[ibmcom/aspera-cli]: https://hub.docker.com/r/ibmcom/aspera-cli/
[ega-cryptor]: https://ega-archive.org/submission/tools/egacryptor/
