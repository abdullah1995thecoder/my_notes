import 'package:flutter/material.dart';
import 'package:my_notes/db/SqlDb.dart';

class EditNote extends StatefulWidget {
  final note;
  final title;
  final id;
  const EditNote({Key? key, this.note, this.title, this.id}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();

  TextEditingController note = TextEditingController();
  TextEditingController title = TextEditingController();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Note'),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    controller: title,
                    decoration: const InputDecoration(hintText: "title"),
                  ),
                  TextFormField(
                    maxLines: 3,
                    controller: note,
                    decoration: const InputDecoration(hintText: "note"),
                  ),
                  Container(
                    height: 20,
                  ),
                  MaterialButton(
                    textColor: Colors.black,
                    color: Colors.amber,
                    onPressed: () async {
                      int response = await sqlDb.updateData('''
                        UPDATE notes SET
                        note  = "${note.text}",
                        title = "${title.text}"
                        WHERE id = ${widget.id}
                        ''');
                      if (response > 0) {
                        Navigator.of(context).pushNamed('mynote');
                      }
                      print(response);
                    },
                    child: const Text(
                      'Edit Note',
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
