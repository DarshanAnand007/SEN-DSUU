import 'package:flutter/material.dart';

class StudentPage extends StatelessWidget {
  final String title;

  StudentPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text('Student Page Content'),
      ),
    );
  }
}
