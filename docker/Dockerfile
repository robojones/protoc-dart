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
RUN pub global activate protoc_plugin $PROTOC_PLUGIN_VERSION

ENV PATH="/root/.pub-cache/bin:$PATH"

CMD protoc -I=/protos --dart_out=lib/src/protos protocol/protos/*.proto
