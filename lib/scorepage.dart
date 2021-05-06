import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:may6_mathtq/user1.dart';
//import 'package:http/http.dart' as http;
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
    checkInternet();
    checkInternetConnectivity();
    print(box.length);

    super.initState();
  }

  void dispose() {
    internet.cancel();
    super.dispose();
  }

  checkInternetConnectivity() async {
    box = await Hive.openBox('players');
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

  //Check Internet Connection
  checkInternet() async {
    internet = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('Internet Availability');
          {
            if (box.length > 0) {
              for (int i = 0; i < box.length; i++) {
                var users = box.getAt(i);
                signup(users.username, users.password, users.score);
                box.deleteAt(i);
              }
              Fluttertoast.showToast(
                  //msg: "Connected to the internet\nSynching to Database",
                  msg: "Internet is available,\nUpdating database",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              Fluttertoast.showToast(
                  //msg: "Connected to the internet\nDatabase is up to date",
                  msg: "Internet is available,\n database updated",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
          break;
        case DataConnectionStatus.disconnected:
          {
            print('You are disconnected from the internet');
            print('There is no Internet Connection');
            Fluttertoast.showToast(
                msg:
                    //"Disconnected from the internet\nYou are using Local Database",
                    "You have no internet connection.\n Local Database Accessed",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            break;
          }
      }
    });
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
                      context, MaterialPageRoute(builder: (context) => Math()));
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
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text('No Internet Available'),
                          backgroundColor: Colors.red,
                          action: SnackBarAction(
                            label: 'Ok',
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
                    "View User Score List",
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
