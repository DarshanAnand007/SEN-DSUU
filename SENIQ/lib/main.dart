import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sen_app/questionspage.dart';
import 'package:sen_app/teacher_page.dart';  // Ensure you have the teacher page defined
import 'package:sen_app/student_grid_page.dart';  // Ensure you have the student grid page defined
import 'package:sen_app/student_page.dart';  // Ensure you have the student page defined

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Topics'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> sendGetRequest() async {
    final Uri url = Uri.parse(
        'https://api.unsplash.com/photos/random/?client_id=keYInDDK6q6ETrQE0vS2aFvzyA5H-VayHyuJ0xZtMe8');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          urll = jsonDecode(response.body)['urls']['regular'];
        });
        final data = jsonDecode(response.body);
        debugPrint('Response data: $data');
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error occurred: $e');
    }
  }

  Future<void> sendGet() async {
    List<Widget> temptopics = [];
    final Uri url = Uri.parse('http://192.168.245.71:5000/get_document');
    try {
      final response = await http.get(url).timeout(const Duration(seconds: 24));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        for (var name in data['names']) {
          temptopics.add(buildTopics(name, data[name]));
        }
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
      }
      setState(() {
        topics.addAll(temptopics);
      });
    } catch (e) {
      debugPrint('Error occurred: $e');
    }
  }

  Widget buildTopics(String name, Map data) {
    return ListTile(
      leading: const Icon(
        Icons.batch_prediction,
        color: Colors.amber,
      ),
      title: Center(
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionsPage(
              data: data,
              name: name,
            ),
          ),
        );
      },
      shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 2),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25))),
      trailing: GestureDetector(
        child: Icon(
          Icons.arrow_forward,
          color: Colors.red.shade600,
        ),
        onTap: () async {
          debugPrint("gay");
        },
      ),
    );
  }

  String urll = "";
  List<Widget> topics = [];
  Map masterTopicDict = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, // Background color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TeacherPage()),
                );
              },
              child: Text('Teacher'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple, // Background color
                foregroundColor: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentPage(title: 'Student Page')),
                );
              },
              child: Text('Student'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: topics.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: topics[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: sendGet,
        tooltip: 'Fetch Topics',
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}
