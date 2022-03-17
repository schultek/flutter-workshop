import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'services/user_service.dart';

final userService = UserService();

Handler get authHandler {
  var router = Router();

  router.post('/login', (Request request) async {
    var data = jsonDecode(await request.readAsString());
    var username = data['username'], password = data['password'];

    if (userService.matchesPassword(username, password)) {
      return Response.ok(userService.createJWT(username));
    } else {
      return Response.forbidden('');
    }
  });

  router.post('/register', (Request request) async {
    var data = jsonDecode(await request.readAsString());

    if (userService.userExists(data['username'])) {
      return Response.forbidden('User exists');
    } else {
      userService.registerUser(data['username'], data['password']);
      return Response.ok(userService.createJWT(data['username']));
    }
  });

  return router;
}
