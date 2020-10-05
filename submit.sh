#!/bin/bash
#SBATCH --output %J.out
#SBATCH --error %J.err
#SBATCH --time=00:50:00

docker run -v $PWD:/mnt amazoncorretto:8u262-alpine-jre java -jar /mnt/ega-cryptor-2.0.0.jar -i /mnt/test -o /mnt/test

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
