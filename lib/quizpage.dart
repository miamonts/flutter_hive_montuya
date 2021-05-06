import 'package:flutter/material.dart';
import 'main.dart';
import 'scorepage.dart';

var finalScore = 0;
var questionNumber = 0;
MathQuiz quiz = MathQuiz();

class MathQuiz {
  var questions = [
    "1. What is 20 multiplied by 1?",
    "2. How many millimeters are in 2 centimeters?",
    "3. Which number expression represents 10 more than 5?",
    "4. Find the product of 23 and 125. ",
    "5. Which unit would you use to measure the water used to take a shower? ",
    "6. If you multiply 0 by any other number, the answer will always be?",
    "7. What is the sum of 30 and 45?",
    "8. What is 50% of 500?",
    "9. What is the square root of 9?",
    "10. If Ana bought a necklace for 5php and a bracelet for 10php, how much did she spent all in all?"
  ];

  var choices = [
    ["a. 20", "b. 25", "c. 30", "d. 40"],
    ["a. 0.2", "b. 20", "c. 200", "d. 2,000"],
    ["a. 10>5", "b. 10=5", "c. 5-10", "d. 5>10"],
    ["a. 2,785", "b. 2,758", "c. 2,671", "d. 2,875"],
    ["a. Spoon", "b. Cup", "c. Gallon", "d. Pint"],
    ["a. Zero", "b. One", "c. Two", "d. Three"],
    ["a. 50", "b. 60", "c. 75", "d. 80"],
    ["a. 50", "b. 100", "c. 200", "d. 250"],
    ["a. 5", "b. 3", "c. 2", "d. 1"],
    ["a. 15", "b. 12", "c. 10", "d. 14"],
  ];

  var correctAnswers = [
    "a. 20",
    "b. 20",
    "a. 10>5",
    "d. 2,875",
    "c. Gallon",
    "a. Zero",
    "c. 75",
    "d. 250",
    "b. 3",
    "a. 15"
  ];
}

class Math extends StatefulWidget {
  final String username;
  final int finalscore;
  final String password;

  Math({this.username, this.finalscore, this.password});

  @override
  _MathState createState() => _MathState(username, finalscore, password);
}

class _MathState extends State<Math> {
  final String username;
  final int score;
  final String password;
  _MathState(this.username, this.score, this.password);

  @override
  void initState() {
    print(username);
    super.initState();
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Text(
                  'Welcome $username!',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Question ${questionNumber + 1} of ${quiz.questions.length}",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            backgroundColor: Colors.orange[200],
          ),
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: const EdgeInsets.only(left: 0, top: 20),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [
                Colors.orange[300],
                Colors.orange[200],
              ],
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(10.0)),
                Flexible(
                  child: Text(
                    quiz.questions[questionNumber],
                    overflow: TextOverflow.visible,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(5)),
                      //button 1
                      MaterialButton(
                        minWidth: 120.0,
                        color: Colors.white,
                        onPressed: () {
                          if (quiz.choices[questionNumber][0] ==
                              quiz.correctAnswers[questionNumber]) {
                            debugPrint("Correct");
                            finalScore++;
                          } else {
                            debugPrint("Wrong");
                          }
                          nextQuestion();
                        },
                        child: Text(
                          quiz.choices[questionNumber][0],
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      //button 2
                      MaterialButton(
                        minWidth: 120.0,
                        color: Colors.white,
                        onPressed: () {
                          if (quiz.choices[questionNumber][1] ==
                              quiz.correctAnswers[questionNumber]) {
                            debugPrint("Correct");
                            finalScore++;
                          } else {
                            debugPrint("Wrong");
                          }
                          nextQuestion();
                        },
                        child: Text(
                          quiz.choices[questionNumber][1],
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      MaterialButton(
                        minWidth: 120.0,
                        color: Colors.white,
                        onPressed: () {
                          if (quiz.choices[questionNumber][2] ==
                              quiz.correctAnswers[questionNumber]) {
                            debugPrint("Correct");
                            finalScore++;
                          } else {
                            debugPrint("Wrong");
                          }
                          nextQuestion();
                        },
                        child: Text(
                          quiz.choices[questionNumber][2],
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(5.0)),
                      //button 4
                      MaterialButton(
                        minWidth: 120.0,
                        color: Colors.white,
                        onPressed: () {
                          if (quiz.choices[questionNumber][3] ==
                              quiz.correctAnswers[questionNumber]) {
                            debugPrint("Correct");
                            finalScore++;
                          } else {
                            debugPrint("Wrong");
                          }
                          nextQuestion();
                        },
                        child: Text(
                          quiz.choices[questionNumber][3],
                          style: TextStyle(fontSize: 20.0, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.orange,
                  ),
                  child: Text(
                    "Partial Score: $finalScore",
                    style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  // height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange,
                  ),
                  child: TextButton(
                    onPressed: resetQuiz,
                    child: Text(
                      'Reset Quiz',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(5),
                  // height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange,
                  ),
                  child: TextButton(
                    onPressed: quit,
                    child: Text(
                      'Quit',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void resetQuiz() {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Math()));
      finalScore = 0;
      questionNumber = 0;
    });
  }

  void nextQuestion() {
    setState(() {
      if (questionNumber == quiz.questions.length - 1) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TotalScore(
                      username: username,
                      score: finalScore,
                      password: password,
                    )));
      } else {
        questionNumber++;
      }
    });
  }

  void quit() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
  }
}
