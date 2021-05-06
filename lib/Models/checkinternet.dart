import 'dart:async';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:may6_mathtq/Models/signup.dart';
import '../main.dart';

StreamSubscription<DataConnectionStatus> internet;
//Check Internet Connection
internetAvailability() async {
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
              print(box.length);
            }
            Fluttertoast.showToast(
                //msg: "Connected to the internet\n Synching to Database",
                msg: "Internet is available,\n Updating database",
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
                backgroundColor: Colors.yellow,
                textColor: Colors.black,
                fontSize: 16.0);
          }
        }
        break;
      case DataConnectionStatus.disconnected:
        {
          print('There is no Internet Connection');
          Fluttertoast.showToast(
              msg:
                  "You have no internet connection. Data saved to local database.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          break;
        }
    }
  });
}
