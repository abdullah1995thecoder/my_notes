import 'package:flutter/material.dart';
import 'package:my_notes/Screens/AddNote.dart';
import 'package:my_notes/Screens/EditNote.dart';
import 'package:my_notes/Screens/mynote.dart';

import 'Screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: 'ATF',
      home: mynote(),
      routes: {
        'addnote': (context) => AddNote(),
        'mynote': (context) => mynote(),
        'editnote': (context) => EditNote(),
      },
    );
  }
}
