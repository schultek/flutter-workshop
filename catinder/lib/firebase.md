## Setup

firebase login

dart pub global activate flutterfire_cli

flutterfire configure

flutter pub add firebase_core

flutterfire configure

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);




## Firestore

flutter pub add cloud_firestore

FirebaseFirestore.instance.collection('favs').add(image);


FirebaseFirestore.instance.collection('favs').get().then((snapshot) {
  var favs = snapshot.docs.map((d) => d.data()).toList();
  setState(() {
    favorites = favs;
  });
});

.snapshots().listen(

## Riverpod

flutter pub add flutter_riverpod
flutter pub add riverpod_context

ProviderScope(child: InheritedConsumer(child: MyApp()))


