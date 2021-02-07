import 'package:app/src/app.dart';
import 'package:app/src/utils/app_state_notifier.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'dart:async';
// import 'dart:io';

// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void main() {
//     Future<void> main() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await FirebaseApp.();
//     runApp(App());
// }
// runApp(

//   ChangeNotifierProvider<AppStateNotifier>(
//     create: (_) => AppStateNotifier(),
//     child: App(),
//   ),
// );

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<AppStateNotifier>(
    create: (_) => AppStateNotifier(),
    child: App(),
  ));
// );?
}
