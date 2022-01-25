# protoc-dart

Docker image with [protoc](https://github.com/protocolbuffers/protobuf) and the [dart-protoc-plugin](https://pub.dev/packages/protoc_plugin).

> **INFO** This image is updated automatically. A nightly build job checks for new versions of dart, protoc and the dart-protoc-plugin every day.

## Usage

Consider you have a project structure like this:

```
my-project
 |- lib
 |   |- src
 |   |   |- generated <- the generated protobuf libraries will be here
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

We want to compile the `protos/api_spec.proto` and write the output files to the `lib/src/generated` directory.
This can be done using the following command:

```bash
docker run --rm -v=${PWD}:/project robojones/protoc-dart:latest protoc -I=protos --dart_out=lib/src/generated protos/api_spec.proto
```

That's a really long command – Let's break this down!
1. First, we make our project accessible inside the docker container.
   We mount it to /project, which is the default working directory inside the container.
   ```bash
   docker run --rm -v=${PWD}:/project
   ```
2. Next, we specify what version of the image we want to use. We use the latest version.
   ```bash
   robojones/protoc-dart:latest
   ```
3. Finally, we run protoc inside the container.
   `-I=protos` tells protoc that `protos/` is the root directory for our *.proto files.
   `--dart_out=lib/src/generated` means that we want our output files to be in the Dart language
   and that it should write those files into `lib/src/generated`.
   The last parameter, `protos/api_spec.proto`, tells protoc that we want to compile that specific file.  
   ```bash
   protoc -I=protos --dart_out=lib/src/generated protos/api_spec.proto
   ```

## License

This repository (build script, Dockerfile, etc.) is published unter the [MIT license](/LICENSE). This project is not affiliated with the owners and publishers of protoc, the dart docker image or the protoc-plugin-dart plugin. Please inform yourself regarding the license terms of protoc, the dart docker image and the protoc-plugin-dart plugin. Their sources can be found here:

- Base image: [dart](https://hub.docker.com/_/dart)
- protoc is downloaded from the Github release [github.com/protocolbuffers/protobuf](https://github.com/protocolbuffers/protobuf)
- protoc-plugin-dart is installed from [pub.dev/packages/protoc_plugin](https://pub.dev/packages/protoc_plugin)
