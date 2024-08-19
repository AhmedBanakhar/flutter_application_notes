import 'package:flutter/material.dart';
import 'package:flutter_application_notes/addnotes.dart';
import 'package:flutter_application_notes/home.dart';


import 'package:flutter_application_notes/readdata.dart';
import 'package:flutter_application_notes/edit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SqfLite',
      home: HomePage(),
      routes: {
        'addnotes': (context) => const AddNotes(),
        'read': (context) => const Readdata(),
        'edit': (context) => EditData(),
      },
    );
  }
}
