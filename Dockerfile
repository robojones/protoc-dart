ARG DART_VERSION
ARG PROTOC_VERSION
ARG PROTOC_PLUGIN_VERSION

FROM dart:$DART_VERSION AS protobuf
# protoc version without the v prefix
ARG PROTOC_VERSION

RUN bash -c 'curl -L -o protoc.zip https://github.com/protocolbuffers/protobuf/releases/download/v$PROTOC_VERSION/protoc-$PROTOC_VERSION-linux-x86_64.zip'
RUN unzip protoc.zip -d /protoc

FROM dart:$DART_VERSION

ARG PROTOC_PLUGIN_VERSION

COPY --from=protobuf /protoc/bin/protoc /bin/
COPY --from=protobuf /protoc/include /usr/local/include
COPY --from=protobuf /protoc/readme.txt /protoc-readme.txt

ENV PUB_CACHE=/pub-cache
ENV PATH="/pub-cache/bin:$PATH"
RUN dart pub global activate protoc_plugin $PROTOC_PLUGIN_VERSION

COPY README.md /README.md
WORKDIR /project

CMD echo For a usage example see: https://github.com/robojones/protoc-dart#readme
