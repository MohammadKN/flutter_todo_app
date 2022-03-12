library globals;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'my-globals.dart' as globals;

main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false, home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget myListView() {
    return new ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: globals.tasks.length,
        itemBuilder: (BuildContext context, index) {
          final item = globals.tasks[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                globals.tasks.removeAt(index);
                Fluttertoast.showToast(
                  msg: "Deleted",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.white70,
                  textColor: Colors.black54,
                  fontSize: 18.0);
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                color: NeumorphicTheme.baseColor(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: NeumorphicButton(
                onPressed: (){
                  HapticFeedback.vibrate();
                  globals.myIndex = index;
                  globals.titleEditorcont.text = globals.tasks[index].title;
                  globals.subtitleEditorcont.text = globals.tasks[index].subtitle;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => taskManager()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    enableFeedback: true,
                    title: GlowText(
                      item.title,
                      glowColor: Colors.black12,
                      blurRadius: 10,
                    ),
                    subtitle: GlowText(
                      item.subtitle,
                      glowColor: Colors.black12,
                      blurRadius: 10,
                    ),
                    trailing: CheckButton(),
                  ),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (globals.tasks.length == 0) {
      setState(() {
        globals.validatorColor = Colors.black54;
      });
    } else if (globals.tasks.length > 0) {
      setState(() {
        globals.validatorColor = Colors.transparent;
      });
    }
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return NeumorphicApp(
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: null,
            body: NeumorphicBackground(
              backendColor: Colors.blue,
              child: Container(
                alignment: Alignment.center,
                width: 100*screenWidth,
                height: 100*screenHeight,
                child: Stack(children: [
                  Neumorphic(child: myListView()),
                  addButton(),
                ]),
              ),
            )
          ),
        );
  }
}

class CheckButton extends StatefulWidget {
  @override
  _CheckButtonState createState() => _CheckButtonState();
}

class _CheckButtonState extends State<CheckButton> {
  bool done = false;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      style: NeumorphicStyle(
        //border: NeumorphicBorder.none(),
      ),
      child: NeumorphicCheckbox(
        value: done,
        onChanged: (value) {
          setState(() {
            done = value;
          });
        },
      ),
    );
  }
}

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
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: null,
        backgroundColor: Colors.grey[200],
        body: NeumorphicBackground(
          child: Container(
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
                          controller: globals.titlecont,
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
                          controller: globals.subtitlecont,
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                      bottom: 10,
                      right: 25,
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
                              if (globals.titlecont.text.isNotEmpty &&
                                  globals.subtitlecont.text.isNotEmpty) {
                                globals.tasks.add(globals.Task(
                                    globals.titlecont.text, globals.subtitlecont.text, globals.myIndex));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => MyApp()),
                                );
                                globals.titlecont.text = CreateTaskPage().empty;
                                globals.subtitlecont.text = CreateTaskPage().empty;
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
    );
  }
}

// ignore: camel_case_types
class addButton extends StatefulWidget {
  @override
  _addButtonState createState() => _addButtonState();
}

// ignore: camel_case_types
class _addButtonState extends State<addButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0.0,
        right: 0.0,
        child: Row(children: [
          GlowText(
            'Press here to add Tasks  ',
            glowColor: globals.validatorColor,
            blurRadius: 300,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: globals.validatorColor),
          ),
          Icon(
            Icons.arrow_right_alt_rounded,
            color: globals.validatorColor,
            size: 40,
          ),
          NeumorphicButton(
            onPressed: () {
              HapticFeedback.vibrate();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateTaskPage()),
              );
            },
            margin: EdgeInsets.all(24),
            child: Container(
              height: 40,
              width: 26,
              alignment: Alignment.center,
              child: GlowIcon(Icons.add, color: Colors.black54,size: 28.0,glowColor: Colors.black26,)
            ),
          ),
        ]
      )
    );
  }
}

// ignore: camel_case_types
class taskManager extends StatefulWidget {
  @override
  _taskManagerState createState() => _taskManagerState();
}

// ignore: camel_case_types
class _taskManagerState extends State<taskManager> {
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
                            controller: globals.titleEditorcont,
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
                            controller: globals.subtitleEditorcont,
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
                                globals.titlecont.text = CreateTaskPage().empty;
                                globals.subtitlecont.text = CreateTaskPage().empty;
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
                                                            builder: (context) => taskManager()),
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
                                                    print(globals.myIndex);
                                                    globals.tasks.removeAt(globals.myIndex);
                                                    print(globals.tasks);
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
                                if (globals.titleEditorcont.text.isNotEmpty &&
                                    globals.subtitleEditorcont.text.isNotEmpty) {
                                  globals.tasks[globals.myIndex].title = globals.titleEditorcont.text;
                                  globals.tasks[globals.myIndex].subtitle =
                                      globals.subtitleEditorcont.text;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyApp()),
                                  );
                                  globals.titlecont.text = CreateTaskPage().empty;
                                  globals.subtitlecont.text = CreateTaskPage().empty;
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