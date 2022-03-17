import 'package:flutter/material.dart';
import 'package:movies_app/services/user_service.dart';

import 'pages/login_page.dart';
import 'pages/movies_page.dart';

void main() {
  runApp(const MoviesApp());
}

/// The main app widget.
class MoviesApp extends StatelessWidget {
  const MoviesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (AuthService.instance.token != null) {
      child = const MoviesPage();
    } else {
      child = const LoginPage();
    }

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: child,
    );
  }
}
