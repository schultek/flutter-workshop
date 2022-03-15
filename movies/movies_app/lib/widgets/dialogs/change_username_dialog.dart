import 'package:flutter/material.dart';
import 'package:movies_shared/models/movie.dart';

import '../../services/user_service.dart';

class ChangeUsernameDialog extends StatefulWidget {
  const ChangeUsernameDialog({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChangeUsernameDialogState();

  static Future<Movie?> show(BuildContext context) {
    return showDialog<Movie>(
      context: context,
      builder: (context) => const ChangeUsernameDialog(),
    );
  }
}

class _ChangeUsernameDialogState extends State<ChangeUsernameDialog> {
  late String username;

  @override
  void initState() {
    super.initState();
    username = UserService.instance.username;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
      titlePadding: EdgeInsets.zero,
      title: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: const Text(
          'Set your username.',
          style: TextStyle(color: Colors.white),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      children: [
        TextFormField(
          initialValue: UserService.instance.username,
          decoration: InputDecoration(
            hintText: "Title",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          onChanged: (val) {
            setState(() {
              username = val;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                UserService.instance.setUsername(username);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ],
    );
  }
}
