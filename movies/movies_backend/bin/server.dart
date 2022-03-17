import 'dart:io';

import 'package:movies_backend/api.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';

void main(List<String> args) async {
  return withHotreload(init);
}

Future<HttpServer> init() async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final _handler = Pipeline() //
      .addMiddleware(logRequests())
      .addHandler(apiHandler);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(_handler, ip, port);

  print('Server listening on port ${server.port}');

  return server;
}
