import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'create_task.dart';
import 'main.dart';


class TaskEditPage extends StatefulWidget {
  @override
  _TaskEditPageState createState() => _TaskEditPageState();
}

// ignore: camel_case_types
class _TaskEditPageState extends State<TaskEditPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return NeumorphicApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: null,
        backgroundColor: Colors.grey[200],
        body: NeumorphicBackground(
          child: Center(
            child: Container(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      NeumorphicButton(
                        onPressed: (){},
                        margin: const EdgeInsets.only(
                          left: 28.0,
                          right: 28.0,
                          top: 60.0,
                          bottom: 28,
                        ),
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Task Title',
                              hintStyle: TextStyle(
                                color: Colors.black38,
                              )),
                          controller: titleEditorcont,
                        ),
                      ),
                      NeumorphicButton(
                        onPressed: (){},
                        margin: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 30),
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                        child: TextField(
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Task subtitle',
                              hintStyle: TextStyle(
                                color: Colors.black38,
                              )),
                          controller: subtitleEditorcont,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0.04*screenHeight,
                    child: Container(
                      width: screenWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          NeumorphicButton(
                            onPressed: () {
                              titlecont.text = CreateTaskPage().empty;
                              subtitlecont.text = CreateTaskPage().empty;
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyApp()),
                              );
                            },
                            style: NeumorphicStyle(
                              depth: 5.0,
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              width: 75,
                              height: 50,
                              child: DefaultTextStyle(
                                child: GlowText('Cancel',
                                  glowColor: Colors.black38,
                                  blurRadius: 10,
                                ),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black54),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              depth: 5.0,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    backgroundColor: Color(0xeeefefef),
                                    actions: <Widget>[
                                      Container(
                                        height: screenHeight*0.3,
                                        width: screenWidth*0.9,
                                        padding: EdgeInsets.symmetric(horizontal: 20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            GlowIcon(
                                              CupertinoIcons.delete_simple,
                                              size: 45,
                                              color: Colors.redAccent,
                                              glowColor: Color(0xFFF95e5e),
                                              blurRadius: 25,
                                            ),
                                            GlowText('Are you sure?',
                                              glowColor: Colors.black38,
                                              blurRadius: 10,
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            GlowText("You can't recover this note.",
                                              glowColor: Colors.black38,
                                              blurRadius: 18,
                                              style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 20,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                NeumorphicButton(
                                                  onPressed: () {
                                                    Navigator.pop(_);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => TaskEditPage()),
                                                    );
                                                  },

                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 2,vertical: 7),
                                                    alignment: Alignment.center,
                                                    child: GlowText(
                                                      'Cancel',
                                                      glowColor: Colors.black38,
                                                      blurRadius: 10,
                                                      style: TextStyle(
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                NeumorphicButton(
                                                  onPressed: () {
                                                    print(myIndex);
                                                    tasks.removeAt(myIndex);
                                                    print(tasks);
                                                    Navigator.pop(_);
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) => MyApp()),
                                                    );
                                                    Fluttertoast.showToast(
                                                        msg: "Deleted",
                                                        toastLength: Toast.LENGTH_LONG,
                                                        gravity: ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 2,
                                                        backgroundColor: Colors.white70,
                                                        textColor: Colors.black54,
                                                        fontSize: 18.0);
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.symmetric(horizontal: 2,vertical: 7),
                                                    alignment: Alignment.center,
                                                    child: GlowText(
                                                      'Confirm',
                                                      glowColor: Colors.red,
                                                      blurRadius: 10,
                                                      style: TextStyle(
                                                        color: Colors.redAccent,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                              );
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 75,
                              height: 50,
                              child: GlowText('Delete',
                                glowColor: Colors.redAccent,
                                blurRadius: 15,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.redAccent),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            onPressed: () {
                              if (titleEditorcont.text.isNotEmpty &&
                                  subtitleEditorcont.text.isNotEmpty) {
                                tasks[myIndex].title = titleEditorcont.text;
                                tasks[myIndex].subtitle =
                                    subtitleEditorcont.text;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyApp()),
                                );
                                titlecont.text = CreateTaskPage().empty;
                                subtitlecont.text = CreateTaskPage().empty;
                              } else {
                                HapticFeedback.lightImpact();
                                Fluttertoast.showToast(
                                    msg: "You have to fill all fields to edit this Task",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.white70,
                                    textColor: Colors.black54,
                                    fontSize: 18.0);
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: 75,
                              height: 50,
                              child: DefaultTextStyle(
                                child: GlowText('Done',
                                  glowColor: Colors.blue,
                                  blurRadius: 10,
                                ),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blueAccent
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}