import 'package:flutter/material.dart';
import 'package:my_notes/Screens/AddNote.dart';
import 'package:my_notes/Screens/EditNote.dart';
import 'package:my_notes/Screens/mynote.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      title: 'ATF',
      home: const mynote(),
      routes: {
        'addnote': (context) => const AddNote(),
        'mynote': (context) => const mynote(),
        'editnote': (context) => const EditNote(),
      },
    );
  }
}
