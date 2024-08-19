import 'package:flutter/material.dart';
import 'package:flutter_application_notes/Controller/sqflite.dart';
import 'package:flutter_application_notes/home.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  SqfLite sqflite = SqfLite();

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Notes'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView(children: [
          Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(hintText: "title"),
                  ),
                  TextFormField(
                    controller: noteController,
                    decoration: const InputDecoration(hintText: "note"),
                  ),
                  Container(
                    height: 20,
                  ),
                  MaterialButton(
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {
                      // int result = await sqflite.insertData('''
                      //   INSERT INTO notes (Title , Note)
                      //   VALUES ("${titleController.text}" , "${noteController.text}")

                      //   ''');
                      int result = await sqflite.InsertData("notes", {
                        "Title": "${titleController.text}",
                        "Note": "${noteController.text}",
                      });
                      if (result > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false);
                      }
                    },
                    child: const Text('Add Note'),
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}
