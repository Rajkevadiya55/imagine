import 'package:flutter/material.dart';

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

bool themeMode = false;
String? userId;
String? id;
String?
fullName;
String? userName;
String? token;
String? userRole;
bool deleteTasks = true;
bool createTasks = true;
bool viewTasks = true;
bool editTasks = true;
bool viewAllTasks = true;
List<num> currentAssign = [];
List<String> assignName = [];
