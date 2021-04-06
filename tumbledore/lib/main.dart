import 'dart:convert';
import 'dart:io';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const OPENAI_KEY = "YOUR API KEY HERE";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orange.shade300,
        scaffoldBackgroundColor: Colors.grey.shade800,
      ),
      home: MyHomePage(title: 'AIbus TUMbledore'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

  static _MyHomePageState of(BuildContext context) {
    return context.findAncestorStateOfType();
  }
}

class Message {
  String text;
  bool byMe;

  Message(this.text, this.byMe);
}

class _MyHomePageState extends State<MyHomePage> {
  var textEditingController = TextEditingController();

  String prompt =
      "The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly.\n"
      "Human: Hello, who are you?\n"
      "AI: I am an AI created by OpenAI. How can I help you today?";

  List<Message> messages = [];

  void sendMessage(String message) async {
    if (message == "") {
      return;
    }

    setState(() {
      messages.add(Message(message, true));
    });

    textEditingController.text = "";

    prompt += "\n"
        "Human: $message\n"
        "AI:";

    // api parameters: https://beta.openai.com/docs/api-reference/completions/create
    var result = await http.post(
      Uri.parse("https://api.openai.com/v1/engines/davinci/completions"),
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $OPENAI_KEY",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.contentTypeHeader: "application/json",
      },
      body: jsonEncode({
        "prompt": prompt,
        "max_tokens": 100,
        "temperature": 0,
        "top_p": 1,
        "stop": "\n",
      }),
    );

    var body = jsonDecode(result.body);
    var text = body["choices"][0]["text"];

    prompt += text;

    setState(() {
      messages.add(Message(text.trim(), false));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20.0),
              reverse: true,
              children: messages.reversed.map((message) {
                return Bubble(
                  child: Text(message.text),
                  color: message.byMe ? Colors.orange.shade300 : Colors.grey.shade300,
                  nip: message.byMe ? BubbleNip.rightBottom : BubbleNip.leftBottom,
                  alignment: message.byMe ? Alignment.topRight : Alignment.topLeft,
                  margin: BubbleEdges.symmetric(vertical: 5),
                );
              }).toList(),
            ),
          ),
          Container(
            color: Colors.grey.shade700,
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: "Message",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                    onSubmitted: (text) {
                      sendMessage(text);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send, 
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    sendMessage(textEditingController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
