FROM centos:7

RUN yum update -y \
    && yum install -y java-1.8.0-openjdk unzip wget tar which expect perl \
    && yum clean all -y \
    && rm -rf /var/cache/yum

ARG PROJ_VERS
ARG IMG_NAME


ADD target/emissary-${PROJ_VERS}-dist.tar.gz /tmp/

RUN ln -s /tmp/emissary-${PROJ_VERS} /tmp/emissary

WORKDIR /tmp/emissary

RUN mkdir /tmp/emissary/test_input
COPY src/test/resources/test_input /tmp/emissary/test_input
RUN chmod -R 777 /tmp/emissary/test_input
RUN chmod -R 777 /tmp/emissary

EXPOSE 8001


ENTRYPOINT ["./emissary"]

CMD ["server", "-a", "2", "-p", "8001"]

LABEL version=${PROJ_VERS} \
      run="docker run -it --rm -v /local/data:/tmp/emissary/target/data --name emissary ${IMG_NAME}"
