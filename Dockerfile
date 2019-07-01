FROM centos:7

RUN yum update -y \
    && yum install -y java-1.8.0-openjdk unzip wget tar which expect perl \
    && yum clean all -y \
    && rm -rf /var/cache/yum

ARG PROJ_VERS
ARG IMG_NAME

RUN mkdir -p /home/docker_build_home
ADD target/emissary-${PROJ_VERS}-dist.tar.gz /home/docker_build_home

RUN ln -s /home/docker_build_home/emissary-${PROJ_VERS} /home/docker_build_home/emissary

WORKDIR /home/docker_build_home/emissary

RUN mkdir /home/docker_build_home/emissary/test_input
COPY src/test/resources/test_input /home/docker_build_home/emissary/test_input
RUN chmod -R 777 /home/docker_build_home/emissary/test_input
RUN chmod -R 777 /home/docker_build_home/emissary

EXPOSE 8001


ENTRYPOINT ["./emissary"]

CMD ["server", "-a", "2", "-p", "8001"]

LABEL version=${PROJ_VERS} \
      run="docker run -it --rm -v /local/data:/home/docker_build_home/emissary/target/data --name emissary ${IMG_NAME}"
