import 'package:flutter/material.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key, required this.name, required this.data});
  final String name;
  final Map data;
  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  int questionCount = 0;
  int currentQuestion = 1;
  bool lastQuestion = false;
  bool checkAnswer = false;
  Map answered = {
    "1": {"answered": false, "answer": 0},
    "2": {"answered": false, "answer": 0},
    "3": {"answered": false, "answer": 0},
    "4": {"answered": false, "answer": 0},
  };

  @override
  void initState() {
    super.initState();
    widget.data.forEach((key, value) {
      questionCount++;
    });
  }

  void showResultDialog() {
    int correctAnswers = calcCorrect();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Quiz Result'),
          content: Text(
              'You answered $correctAnswers out of $questionCount questions correctly!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pop(); // To go back to the previous screen
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  int calcCorrect() {
    int correctAnswers = 0;
    try {
      for (int i = 1; i <= questionCount; i++) {
        int selectedOptionIndex = answered["$i"]["answer"];
        String selectedOption =
            widget.data["$i"]["options"][selectedOptionIndex];
        if (selectedOption == widget.data["$i"]["answer"]) {
          correctAnswers++;
        }
      }
      debugPrint("Correct Answers: $correctAnswers");
      return correctAnswers;
    } catch (e) {
      debugPrint("$e");
      return correctAnswers;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Row(children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 20,
                child: Text(
                  "$currentQuestion. ${widget.data["$currentQuestion"]["question"]}",
                  style: const TextStyle(fontSize: 30),
                  maxLines:
                      null, // Allows text to expand as many lines as needed
                  overflow: TextOverflow.visible,
                ),
              ),
            ),
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text("Diffculty level : "),
                Text(
                  "${widget.data["$currentQuestion"]["difficultylevels"]}",
                  style: TextStyle(
                      color: widget.data["$currentQuestion"]
                                  ["difficultylevels"] ==
                              "hard"
                          ? Colors.red
                          : Colors.green),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              minLeadingWidth: 20,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade600, width: 1),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.elliptical(16, 16),
                      topRight: Radius.elliptical(16, 16),
                      bottomRight: Radius.elliptical(16, 16),
                      bottomLeft: Radius.elliptical(16, 16))),
              tileColor: answered["$currentQuestion"]["answered"] == true &&
                      answered["$currentQuestion"]["answer"] == 0
                  ? Colors.amber
                  : Colors.grey.shade200,
              onTap: () {
                // debugPrint(widget.data["a"]);
                setState(() {
                  answered["$currentQuestion"]["answered"] = true;
                  answered["$currentQuestion"]["answer"] = 0;
                });
              },
              leading: Container(
                  width: 25,
                  height: 25,
                  // alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black87),
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Center(
                      child: Text(
                        "A",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              title: Text(widget.data["$currentQuestion"]["options"][0]),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              minLeadingWidth: 20,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade600, width: 1),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.elliptical(16, 16),
                      topRight: Radius.elliptical(16, 16),
                      bottomRight: Radius.elliptical(16, 16),
                      bottomLeft: Radius.elliptical(16, 16))),
              tileColor: answered["$currentQuestion"]["answered"] == true &&
                      answered["$currentQuestion"]["answer"] == 1
                  ? Colors.amber
                  : Colors.grey.shade200,
              onTap: () {
                // debugPrint(widget.data["a"]);
                setState(() {
                  answered["$currentQuestion"]["answered"] = true;
                  answered["$currentQuestion"]["answer"] = 1;
                });
              },
              leading: Container(
                  width: 25,
                  height: 25,
                  // alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black87),
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Center(
                      child: Text(
                        "B",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              title: Text(widget.data["$currentQuestion"]["options"][1]),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              minLeadingWidth: 20,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade600, width: 1),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.elliptical(16, 16),
                      topRight: Radius.elliptical(16, 16),
                      bottomRight: Radius.elliptical(16, 16),
                      bottomLeft: Radius.elliptical(16, 16))),
              tileColor: answered["$currentQuestion"]["answered"] == true &&
                      answered["$currentQuestion"]["answer"] == 2
                  ? Colors.amber
                  : Colors.grey.shade200,
              onTap: () {
                // debugPrint(widget.data["a"]);
                setState(() {
                  answered["$currentQuestion"]["answered"] = true;
                  answered["$currentQuestion"]["answer"] = 2;
                });
              },
              leading: Container(
                  width: 25,
                  height: 25,
                  // alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black87),
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Center(
                      child: Text(
                        "C",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              title: Text(widget.data["$currentQuestion"]["options"][2]),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              minLeadingWidth: 20,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade600, width: 1),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.elliptical(16, 16),
                      topRight: Radius.elliptical(16, 16),
                      bottomRight: Radius.elliptical(16, 16),
                      bottomLeft: Radius.elliptical(16, 16))),
              tileColor: answered["$currentQuestion"]["answered"] == true &&
                      answered["$currentQuestion"]["answer"] == 3
                  ? Colors.amber
                  : Colors.grey.shade200,
              onTap: () {
                // debugPrint(widget.data["a"]);
                setState(() {
                  answered["$currentQuestion"]["answered"] = true;
                  answered["$currentQuestion"]["answer"] = 3;
                });
              },
              leading: Container(
                  width: 25,
                  height: 25,
                  // alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black87),
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Center(
                      child: Text(
                        "D",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )),
              title: Text(widget.data["$currentQuestion"]["options"][3]),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: checkAnswer
                ? const Text(
                    'Choose an option first!',
                    style: TextStyle(color: Colors.red),
                  )
                : const Text(''),
          ),

          //
          const Expanded(child: SizedBox()),

          //
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87),
                    onPressed: () {
                      if (currentQuestion > 1) {
                        setState(() {
                          currentQuestion--;
                        });
                      }
                    },
                    child: const Text('Prev question')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87),
                    onPressed: () {
                      setState(() {
                        checkAnswer = false;
                      });
                      if (answered["$currentQuestion"]["answered"]) {
                        if (currentQuestion < questionCount) {
                          setState(() {
                            currentQuestion++;
                            if (currentQuestion == questionCount) {
                              lastQuestion = true;
                            }
                          });
                        } else if (lastQuestion) {
                          showResultDialog();
                        }
                      } else {
                        setState(() {
                          checkAnswer = true;
                        });
                      }
                    },
                    child: Text(lastQuestion ? 'Submit' : 'Next question')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
