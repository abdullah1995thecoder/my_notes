import 'package:flutter/material.dart';
import 'package:my_notes/db/SqlDb.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Note'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  Container(height: 10),
                  TextFormField(
                    controller: title,
                    decoration: const InputDecoration(
                      hintText: "title",
                      border: OutlineInputBorder(),
                      labelText: 'title ',
                    ),
                  ),
                  Container(height: 30),
                  TextFormField(
                    maxLines: 4,
                    controller: note,
                    decoration: const InputDecoration(
                      hintText: "note",
                      labelText: 'Note ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Container(height: 30),
                  MaterialButton(
                    textColor: Colors.black,
                    color: Colors.amber,
                    onPressed: () async {
                      int response = await sqlDb.insertData('''
                        INSERT INTO notes ( 'title','note' )
                        VALUES ("${title.text}","${note.text}")
                        ''');
                      if (response > 0) {
                        Navigator.of(context).pop();
                      }
                      print(response);
                    },
                    child: const Text(
                      'Add Note',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
