import 'package:flutter/material.dart';
import 'package:letstrip/utils/lets_trip_app.dart';

void moveTo({required Widget screenName, BuildContext? context}) {
  Navigator.push(context ?? navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => screenName));
}

void moveAndKillAll({required Widget screenName, BuildContext? context}) {
  Navigator.pushAndRemoveUntil(context ?? navigatorKey.currentContext!,
      MaterialPageRoute(builder: (context) => screenName), (route) => false);
}

void moveAndKillThis({required Widget screenName, BuildContext? context}) {
  var c = context ?? navigatorKey.currentContext!;
  Navigator.push(
    c,
    MaterialPageRoute(builder: (context) => screenName),
  ).then((_) {
    Navigator.of(c).pop();
    // Removing Screen B after navigating to Screen C
    // Navigator.of(c).removeRoute(
    // ModalRoute.of(c)!,
    // );
  });
}

///back to last screen
void backToPrevious({BuildContext? context}) {
  Navigator.pop(context ?? navigatorKey.currentContext!);
}

void backWithData<T>({required T data, BuildContext? context}) {
  Navigator.pop(context ?? navigatorKey.currentContext!, data);
}

///back to custom screen
void backUntil({required int noOfScreen, BuildContext? context}) {
  int count = 0;
  Navigator.of(context ?? navigatorKey.currentContext!)
      .popUntil((_) => count++ >= noOfScreen);
}
