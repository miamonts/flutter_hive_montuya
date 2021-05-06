import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:may6_mathtq/user1.dart';
//import 'package:http/http.dart' as http;
import 'Models/checkinternet.dart';
import 'Models/getsample.dart';
import 'Models/signup.dart';
import 'main.dart';
import 'quizpage.dart';

MathQuiz quiz = MathQuiz();

class TotalScore extends StatefulWidget {
  final String username;
  final int score;
  final String password;
  TotalScore({Key key, @required this.score, this.username, this.password})
      : super(key: key);

  @override
  _TotalScoreState createState() => _TotalScoreState(username, score, password);
}

class _TotalScoreState extends State<TotalScore> {
  get totalScore => quiz.questions.length;
  String password;
  String username;
  int score;
  String conscore;
  StreamSubscription<DataConnectionStatus> internet;
  _TotalScoreState(this.username, this.score, this.password);

  @override
  void initState() {
    //checkInternet();
    checkInternetConnectivity();

    super.initState();
  }

  void dispose() {
    internet.cancel();
    super.dispose();
  }

  checkInternetConnectivity() async {
    box = await Hive.openBox('users');
    bool result = await DataConnectionChecker().hasConnection;
    if (result == true) {
      conscore = score.toString();
      signup(username, password, conscore);
    } else {
      saveUser();
    }
  }

  saveUser() async {
    box.add(Uscores(username, score, password));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.all(30),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Colors.orange[300],
              Colors.orange[200],
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Total Score of $username: $finalScore out of $totalScore",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(padding: EdgeInsets.all(30.0)),
              //retake quiz
              GestureDetector(
                onTap: () {
                  questionNumber = 0;
                  finalScore = 0;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Math(
                                username: username,
                              )));
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange,
                  ),
                  child: Text(
                    "Retake Quiz",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () async {
                  bool result = await DataConnectionChecker().hasConnection;
                  if (result == true) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Users()));
                  } else {
                    internetAvailability();
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                              'No Internet Available. Unable to view scores.'),
                          backgroundColor: Colors.red,
                          action: SnackBarAction(
                            label: 'Back',
                            textColor: Colors.white,
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .removeCurrentSnackBar();
                            },
                          ),
                        ),
                      );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange,
                  ),
                  child: Text(
                    "View Scores",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  questionNumber = 0;
                  finalScore = 0;
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyApp()));
                },
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.orange,
                  ),
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
