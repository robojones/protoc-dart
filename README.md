# protoc-dart

Docker image containing protoc and the dart-protoc-plugin.

> **INFO** This image is updated automatically. A nightly build job checks for new versions of dart, protoc and the dart-protoc-plugin every day.

## Usage

Consider you have a project structure like this:

```
my-project
 |- lib
 |   |- src
 |   |   |-generated <- the generated protobuf libraries will be here
 |   |   |...
 |   |
 |   |- my-project.dart
 |
 |- protos
 |   |- api_spec.proto <- we want to compile this
 |
 |- pubspec.yaml
 |...
```

We want to compile the `protos/api_spec.proto` and the output should be in the `lib/src/generated` directory.
The correct command for this would be:

```bash
docker run --rm -v=${PWD}:/project robojones/protoc-dart:latest protoc -I=protos --dart_out=lib/src/generated protos/api_spec.proto
```

Let's break this down!
1. ```bash
   docker run --rm -v=${PWD}:/project
   ```
   This part mounts the current directory into the container.
   We mount it to /project, which is the default working directory.
2. ```bash
   robojones/protoc-dart:latest
   ```
   Here we specify what version of the image we want to run. We use the latest version.
3. ```bash
   protoc -I=protos --dart_out=lib/src/generated protos/api_spec.proto
   ```
   Finally, we run protoc inside the container.
   `-I=protos` tells protoc that `protos/` is the root directory for our *.proto files.
   `--dart_out=lib/src/generated` means that we want our output to be in the dart language
   and that it should write those files into `lib/src/generated`.
   The last parameter, `protos/api_spec.proto`, tells protoc that we want to compile that specific file.  

## Information

- Base image: [dart](https://hub.docker.com/_/dart)
- protoc is downloaded from the Github release [github.com/protocolbuffers/protobuf](https://github.com/protocolbuffers/protobuf)
- protoc-plugin-dart is installed from [pub.dev/packages/protoc_plugin](https://pub.dev/packages/protoc_plugin)
