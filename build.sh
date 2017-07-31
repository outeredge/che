#!/bin/bash -e

IMAGE_NAME=outeredge/che-server:latest

echo "=> Building the binary"

docker run --rm \
  -v "$HOME/.m2:/home/user/.m2" \
  -v $(pwd):/home/user/che-build \
  -w /home/user/che-build \
  eclipse/che-dev \
  bash -c "mvn clean install -f plugins/plugin-docker/pom.xml -Pfast && \
  mvn clean install -f assembly/assembly-wsmaster-war/pom.xml -Pfast && \
  mvn clean install -f assembly/assembly-main/pom.xml -Pfast"

mv assembly/assembly-main/target/eclipse-che-*.tar.gz dockerfiles/che/eclipse-che.tar.gz

cd dockerfiles/che && docker build -f Dockerfile -t $IMAGE_NAME . && rm eclipse-che.tar.gz

echo "=> Built Docker image $IMAGE_NAME"

docker push $IMAGE_NAME
