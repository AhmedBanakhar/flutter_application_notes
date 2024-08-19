import 'package:flutter/material.dart';
import 'package:flutter_application_notes/Controller/sqflite.dart';
import 'package:flutter_application_notes/edit.dart';

class Readdata extends StatefulWidget {
  const Readdata({super.key});

  @override
  State<Readdata> createState() => _ReaddataState();
}

class _ReaddataState extends State<Readdata> {
  SqfLite sqflite = SqfLite();
  List notes = [];
  bool isloading = true;

  Future readData() async {
    List<Map> result = await sqflite.ReadData("SELECT * FROM notes");
    notes.addAll(result);
    isloading = false;
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
      appBar: AppBar(
        title: const Text('ReadData'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      body: isloading == true
          ? Center(child: Text('Loading...'))
          : ListView(
              children: [
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: notes.length,
                    itemBuilder: ((context, i) {
                      return Card(
                        child: ListTile(
                          title: Text(notes[i]['Title']),
                          subtitle: Text(notes[i]['Note']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  int result = await sqflite.deleteData(
                                      "DELETE FROM notes WHERE id =${notes[i]['id']}");
                                  if (result > 0) {
                                    notes.removeWhere((element) =>
                                        element['id'] == notes[i]['id']);
                                  }
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => EditData(
                                            title: notes[i]['Title'],
                                            note: notes[i]['Note'],
                                            id: notes[i]['id'],
                                          )));
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }))

                // MaterialButton(
                //   onPressed: () async {
                //     await sqflite.myDeleteData();
                //   },
                //   child: Text('Delete'),
                //   color: Colors.blue,
                // ),
              ],
            ),
    );
  }
}
