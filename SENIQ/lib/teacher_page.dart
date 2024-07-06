import 'package:flutter/material.dart';
import 'student_grid_page.dart'; // Ensure you have the student grid page defined

class TeacherPage extends StatefulWidget {
  @override
  _TeacherPageState createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> {
  int _selectedStudents = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                // Code to upload a PDF
              },
              child: Text('Upload PDF'),
            ),
            SizedBox(height: 20),
            DropdownButton<int>(
              value: _selectedStudents,
              items: <int>[25, 50, 75, 100].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value Students'),
                );
              }).toList(),
              onChanged: (int? newValue) {
                setState(() {
                  _selectedStudents = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StudentGridPage(
                      numberOfStudents: _selectedStudents,
                    ),
                  ),
                );
              },
              child: Text('Proceed '),
            ),
          ],
        ),
      ),
    );
  }
}
