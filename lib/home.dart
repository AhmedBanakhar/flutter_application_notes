import 'package:flutter/material.dart';
import 'package:flutter_application_notes/Controller/sqflite.dart';
import 'package:flutter_application_notes/edit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SqfLite sqflite = SqfLite();
  
  // Future<List<Map>> ReadData() async {
  //   List<Map> result = await sqflite.ReadData("SELECT * FROM notes");

  //   return result;
  // }
  //the second way
  Future<List<Map>> readData() async {
    List<Map> result = await sqflite.readData("notes");

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: Icon(Icons.add),
      ),
      body: ListView(
        children: [
          FutureBuilder(
              future: readData(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child:Text('Loading...'));
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('error'),
                    );
                  }
                  if (snapshot.data!.isEmpty) {
                    return Center(
                      child: Text('there is no data'),
                    );
                  }

                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: ((context, i) {
                        return Card(
                          child: ListTile(
                            title: Text(snapshot.data![i]['Title']),
                            subtitle: Text(snapshot.data![i]['Note']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    // int result = await sqflite.deleteData(
                                    //     "DELETE FROM notes WHERE id =${snapshot.data![i]['id']}");

                                    int result=await sqflite.DeleteData(
                                      "notes","id=${snapshot.data![i]['id']}"
                                    );

                                    if (result > 0) {
                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder: (context) => HomePage()));
                                      ;
                                    }
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                 IconButton(
                                  onPressed: ()  {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditData(
                                      title: snapshot.data![i]['Title'],
                                      note: snapshot.data![i]['Note'],
                                      id: snapshot.data![i]['id'],
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
                      }));
                }
                return Center(child: CircularProgressIndicator());
              }),
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
