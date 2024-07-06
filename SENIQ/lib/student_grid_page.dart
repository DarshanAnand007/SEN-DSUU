import 'package:flutter/material.dart';

class StudentGridPage extends StatelessWidget {
  final int numberOfStudents;

  StudentGridPage({required this.numberOfStudents});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Grid Page'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3 columns
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: numberOfStudents,
        itemBuilder: (context, index) {
          bool isTestStarted =
              false; // This should be replaced with actual test status
          bool isTestCompleted =
              false; // This should be replaced with actual test status
          int score = 0; // Replace with actual score

          return GestureDetector(
            onTap: () {
              // Code to handle tapping on the card, such as starting or stopping the test
              isTestStarted = !isTestStarted;
              isTestCompleted = !isTestCompleted;
              // Update the score here as needed
            },
            child: Card(
              color: isTestCompleted
                  ? Colors.green.shade50
                  : Colors.deepPurple.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
                side: BorderSide(color: Colors.deepPurple, width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Center(
                      child: Text(
                        'USN ${index + 1}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      width: 90,
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.deepPurple, width: 1),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Score: $score',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.deepPurple,
                              ),
                            ),
                            SizedBox(width: 7),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                color:
                                    isTestStarted ? Colors.green : Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
