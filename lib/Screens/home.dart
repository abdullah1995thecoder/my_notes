import 'package:flutter/material.dart';
import 'package:my_notes/db/SqlDb.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async {
                  int response = await sqlDb.insertData(
                      "INSERT INTO 'notes' ('note') VALUES ('Note One')");
                  print(response);
                },
                child: Text("Insert Data"),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async {
                  List<Map> response =
                      await sqlDb.readData("SELECT * FROM 'notes'");
                  print(response);
                },
                child: Text("Read Data"),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async {
                  int response =
                      await sqlDb.deleteData("DElETE FROM 'notes' WHERE id =3");
                  print('$response');
                },
                child: Text("Delete Data"),
              ),
            ),
            Center(
              child: MaterialButton(
                color: Colors.red,
                textColor: Colors.white,
                onPressed: () async {
                  int response = await sqlDb.updateData(
                      "UPDATE 'notes' SET 'note' = 'note three' WHERE id = 3");
                  print('$response');
                },
                child: Text("Update Data"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
