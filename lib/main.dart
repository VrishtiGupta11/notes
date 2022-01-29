import 'package:flutter/material.dart';
import 'package:notes/notes_editor.dart';
import 'package:notes/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => NotesEditor(title: "", content: "",),
        // '/': (context) => SplashPage(),
        '/editor': (context) => NotesEditor(title: "", content: "",),
      },
    );
  }
}
