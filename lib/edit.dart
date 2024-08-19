import 'package:flutter/material.dart';
import 'package:flutter_application_notes/Controller/sqflite.dart';
import 'package:flutter_application_notes/home.dart';

class EditData extends StatefulWidget {
  final title;
  final note;
  final id;
  EditData({super.key, this.title, this.note, this.id});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  SqfLite sqflite = SqfLite();

  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  @override
  void initState() {
    titleController.text = widget.title;
    noteController.text = widget.note;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditData'),
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
                      // int result = await sqflite.updataDate('''
                      //   UPDATE 'notes' SET
                      //     Title ="${titleController.text}",
                      //     Note="${noteController.text}"
                      //     WHERE id = "${widget.id}"

                      //   ''');

                      int result = await sqflite.UpdataData(
                          "notes",
                          {
                            "Title": "${titleController.text}",
                            "Note": "${noteController.text}",
                          },
                          "id=${widget.id}");
                      if (result > 0) {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false);
                      }
                    },
                    child: const Text('Edit Note'),
                  ),
                ],
              ))
        ]),
      ),
    );
  }
}
