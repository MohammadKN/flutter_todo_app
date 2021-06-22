library globals;
import 'my-globals.dart' as globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';
import 'main.dart';

int myIndex =0;
final titlecont = TextEditingController(), subtitlecont = TextEditingController(),
titleEditorcont = TextEditingController(), subtitleEditorcont = TextEditingController();
Color validatorColor = Colors.black54;
List tasks = [], days = [];

class Task {
  String title;
  String subtitle;
  int theIndex;
  Task(this.title, this.subtitle, this.theIndex);
}

class Days{
  bool saturday;
  bool sunday;
  bool monday;
  bool tuesday;
  bool wednesday;
  bool thursday;
  bool friday;
  Days(this.saturday, this.sunday, this.monday, this.tuesday, this.wednesday, this.thursday, this.friday);
}


//ListView