import 'package:flutter/material.dart';
import 'package:movies_app/pages/movies_page.dart';
import 'package:movies_app/services/user_service.dart';

import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _username = '', _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Username'),
              onChanged: (text) => _username = text,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              onChanged: (text) => _password = text,
            ),
            ElevatedButton(
              onPressed: () async {
                var didLogin =
                    await AuthService.instance.login(_username, _password);
                if (didLogin) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const MoviesPage()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to login.')));
                }
              },
              child: const Text('Login'),
            ),
            OutlinedButton(
              onPressed: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const RegisterPage()));
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
