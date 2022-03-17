import 'package:flutter/material.dart';
import 'package:movies_app/pages/login_page.dart';
import 'package:movies_app/pages/movies_page.dart';
import 'package:movies_app/services/user_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                    await AuthService.instance.register(_username, _password);
                if (didLogin) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const MoviesPage()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to register.')));
                }
              },
              child: const Text('Register'),
            ),
            OutlinedButton(
              onPressed: () async {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const LoginPage()));
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
