import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'classes.dart';
import 'main.dart';



class CreateTaskPage extends StatefulWidget {
  final String empty = '';

  @override
  _CreateTaskPageState createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  @override
  Widget build(BuildContext context) {
    var titleFocusNode = FocusNode();
    var subtitleFocusNode = FocusNode();
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: null,
        backgroundColor: Colors.grey[200],
        body: NeumorphicBackground(
          child: Hero(
            tag: "addButton",
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Color(0xeeeeee),
              child: Padding(
                padding: const EdgeInsets.only(top: 58.0),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        NeumorphicButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            FocusScope.of(context).requestFocus(titleFocusNode);
                          },
                          margin: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 30),
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                          child: TextField(
                            //focusNode: titleFocusNode,
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Task Title',
                                hintStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                            controller: titlecont,
                          ),
                        ),
                        NeumorphicButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            FocusScope.of(context).requestFocus(subtitleFocusNode);
                          },
                          margin: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 30),
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                          child: TextField(
                            focusNode: subtitleFocusNode,
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Task subtitle',
                                hintStyle: TextStyle(
                                  color: Colors.black38,
                                )),
                            controller: subtitlecont,
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                        bottom: 10,
                        right: 10,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            NeumorphicButton(
                              margin: EdgeInsets.all(18),
                              style: NeumorphicStyle(
                                depth: 5.0,
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                width: 75,
                                height: 50,
                                child: DefaultTextStyle(
                                  child: GlowText('Add',
                                    glowColor: Colors.blue,
                                    blurRadius: 10,
                                  ),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueAccent),
                                ),

                              ),
                              onPressed: (){
                                if (titlecont.text.isNotEmpty && subtitlecont.text.isNotEmpty) {
                                  tasks.add(Task(
                                      titlecont.text, subtitlecont.text, myIndex));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyApp()),
                                  );
                                  titlecont.text = CreateTaskPage().empty;
                                  subtitlecont.text = CreateTaskPage().empty;
                                } else {
                                  HapticFeedback.heavyImpact();
                                  Fluttertoast.showToast(
                                      msg: "You have to fill all fields to make a new Task",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.white70,
                                      textColor: Colors.black54,
                                      fontSize: 18.0);
                                }
                              },
                            ),
                          ],
                        )
                    ),
                    Positioned(
                        bottom: 10,
                        left: 25,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            NeumorphicButton(
                              margin: EdgeInsets.all(18),
                              style: NeumorphicStyle(
                                depth: 5.0,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyApp()),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 75,
                                height: 50,
                                child: GlowText('Cancel',
                                  glowColor: Colors.black38,
                                  blurRadius: 10,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}