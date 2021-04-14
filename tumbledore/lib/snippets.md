
# Preparation

Android Studio: Disable Format on Save

# Screens:

1. Presentation, FullScreen
2. Vysor, Android Studio, Terminal
3. Chrome, pub.dev

(2nd Screen: Finder, VisualStudio Code)

# Terminal:

flutter --version
flutter create myapp

# Android Studio:

Open myapp folder

Run app

Enable KeyCastr (Option, CMD, K)

# Vysor

Switch to myapp

# Android Studio

Open Project Explorer

Explain Directories
- lib
- android/ios/web
- pubspec.yaml

# Slides

What is a Widget?

# Android Studio

Go over generated code

- void main() -> Entrypoint into App
- MyApp Widget
- Theme
- MyHomePage -> Stateful Widget

Show Widget Inspector

# Coding

=> MaterialApp
debugShowCheckedModeBanner: false,

=> ThemeData
primaryColor: Colors.orange.shade300,
scaffoldBackgroundColor: Colors.grey.shade800,

=> MaterialApp
home: MyHomePage(title: 'AIbus TUMbledore'),

=> HomePage.Scaffold
body: Placeholder(),

# Slides

Basic Widgets

# Android Studio

=> HomePage.Scaffold
body: Container(

),

padding: EdgeInsets.all(15),

child: TextField(
  
),

style: TextStyle(color: Colors.white),
decoration: InputDecoration(
  hintText: "Message",
  hintStyle: TextStyle(color: Colors.white),
),

onSubmitted: (text) {
  sendMessage(text);
},

void sendMessage(String message) async {
  // TODO send api request to openai
}

# package.yml

http: ^0.13.1

# Api Call

import 'package:http/http.dart' as http;

const OPENAI_KEY = "YOUR API KEY HERE";

String.fromEnvironment("OPENAI_KEY");

[RUN ARGS] --dart-define=OPENAI_KEY=
${OPENAI_KEY}

flutter run --dart-define=OPENAI_KEY=MY_KEY

[Rerun Application]

String prompt =
    "The following is a conversation with an AI assistant. The assistant is helpful, creative, clever, and very friendly.\n"
    "Human: Hello, who are you?\n"
    "AI: I am an AI created by OpenAI. How can I help you today?";

prompt += "\n"
    "Human: $message\n"
    "AI:";

// api documentation: https://beta.openai.com/docs/api-reference/completions/create
var result = await http.post(
  
);

Uri.parse("https://api.openai.com/v1/engines/davinci/completions"),

headers: {
  "Authorization": "Bearer $OPENAI_KEY",
  "Accept": "application/json",
  "Content-Type": "application/json",
},

body: jsonEncode({
  "prompt": prompt,
  "max_tokens": 100,
  "temperature": 0,
  "top_p": 1,
  "stop": "\n",
}),

print(result.body);

# Result parsing

var body = jsonDecode(result.body);
var text = body["choices"][0]["text"];

prompt += text;

print(text);

# Text Editing Controller

var textEditingController = TextEditingController();

controller: textEditingController,

if (message == "") {
  return;
}

textEditingController.text = "";

# package.yml

bubble: ^1.2.1

# main.dart


class Message {
  String text;
  bool byMe;
}

[CMD-N] Generate Constructor

List<Message> messages = [];

setState(() {
  messages.add(Message(message, true));
});

setState(() {
  messages.add(Message(text.trim(), false));
});

=> Container
[Alt-Esc] Wrap with Column

color: Colors.grey.shade700,

ListView(
  padding: const EdgeInsets.all(20.0),
  children: []
),

=> ListView
[Alt-Esc] Wrap with Widget -> Expanded

messages.map((message) {

}).toList(),

return Bubble(
  child: Text(message.text),
);

color: message.byMe ? Colors.orange.shade300 : Colors.grey.shade300,

nip: message.byMe ? BubbleNip.rightBottom : BubbleNip.leftBottom,

alignment: message.byMe ? Alignment.topRight : Alignment.topLeft,

margin: BubbleEdges.symmetric(vertical: 5),

# Send Button

=> TextField
[Alt-Esc] Wrap with Row

=> TextField
[Alt-Esc] Wrap with Widget -> Expanded

IconButton(
  
),

icon: Icon(
  Icons.send, 
  color: Theme.of(context).primaryColor,
),

onPressed: () {
  
},

sendMessage(textEditingController.text);

# Scroll To Bottom

reverse: true,

messages.reversed

# END

flutter build apk --dart-define=OPENAI_KEY=MY_KEY