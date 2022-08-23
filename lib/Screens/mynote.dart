import 'package:flutter/material.dart';
import 'package:my_notes/Screens/EditNote.dart';
import 'package:my_notes/db/SqlDb.dart';

class mynote extends StatefulWidget {
  const mynote({Key? key}) : super(key: key);

  @override
  State<mynote> createState() => _mynoteState();
}

class _mynoteState extends State<mynote> {
  SqlDb sqlDb = SqlDb();
  bool islodaing = true;
  List notes = [];
  List notes2 = [];

  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");

    notes.addAll(response);
    islodaing = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // await sqlDb.deletemydatabase();
          Navigator.of(context).pushNamed('addnote').then((value) {
            setState(() {
              notes.clear();
            });
            readData();
          });
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Note App'),
      ),
      body: islodaing == true
          ? const Center(child: Text('Loading...'))
          : Container(
              child: notes.isEmpty
                  ? Center(
                      child: Image.asset(
                        'assets/empty.png',
                      ),
                    )
                  : ListView(
                      children: [
                        ListView.builder(
                            itemCount: notes.length,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, right: 5, left: 5),
                                child: Card(
                                  elevation: 10,
                                  child: ListTile(
                                      title: Text(
                                        "${notes[i]['title']}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      subtitle: Text(
                                        "${notes[i]['note']}",
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          //delete
                                          IconButton(
                                            onPressed: () async {
                                              int response = await sqlDb.deleteData(
                                                  "DELETE FROM notes WHERE id =${notes[i]['id']}");
                                              if (response > 0) {
                                                setState(() {
                                                  notes.removeWhere((element) =>
                                                      element['id'] ==
                                                      notes[i]['id']);
                                                });
                                              }
                                              print(response);
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: Colors.red,
                                          ),
                                          //Update
                                          IconButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditNote(
                                                    title: notes[i]['title'],
                                                    note: notes[i]['note'],
                                                    id: notes[i]['id'],
                                                  ),
                                                ),
                                              )
                                                  .then((value) {
                                                setState(() {
                                                  notes.clear();
                                                  readData();
                                                });
                                              });
                                            },
                                            icon: const Icon(Icons.edit),
                                            color: Colors.green,
                                          ),
                                        ],
                                      )),
                                ),
                              );
                            })
                      ],
                    ),
            ),
    );
  }
}
