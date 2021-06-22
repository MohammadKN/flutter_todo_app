library globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'my-globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';


main()  {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent,));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarBrightness: Brightness.light));
  runApp(MyApp());
}
// ignore: must_be_immutable

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Widget myListView() {
    return new ListView.builder (
        physics: BouncingScrollPhysics(),
        itemCount: globals.tasks.length,
        itemBuilder: (BuildContext context,index) {
          final item = globals.tasks[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction){
                    setState(() {
                      globals.tasks.removeAt(index);
                      Fluttertoast.showToast(
                          msg: "Deleted",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 2,
                          backgroundColor: Colors.white70,
                          textColor: Colors.black54, fontSize: 18.0);
                    });
                  },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10,horizontal: 15),
              decoration : BoxDecoration(
                    color: NeumorphicTheme.baseColor(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
              child: Neumorphic(
                    child: ListTile(
                    onTap: (){
                      HapticFeedback.vibrate();
                      globals.myIndex=index;
                      globals.titleEditorcont.text=globals.tasks[index].title;
                      globals.subtitleEditorcont.text=globals.tasks[index].subtitle;
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>taskManager()));
                    },
                    enableFeedback: true,
                    title: Text(item.title),
                    subtitle: Text(item.subtitle),
                    trailing: CheckButton(),
                  ),
                  ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    if (globals.tasks.length==0){
      globals.validatorColor=Colors.black54;
    }
    else if(globals.tasks.length>0){
      globals.validatorColor=Colors.transparent;
    }
    return Sizer(
      // ignore: non_constant_identifier_names
      builder: (context, orientation,DeviceType) {
        return NeumorphicApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              backgroundColor: Colors.white,
              appBar: null,
              body: NeumorphicBackground(
                backendColor: Colors.blue,
                child: Container(
                  alignment: Alignment.center,
                  width: 100.w,
                  height: 100.h,
                  child: Stack(
                      children: [
                          Neumorphic(child: myListView()),
                          addButton(),
                  ]
                ),
              ),
            )
          ),
        );
      }
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
    return Neumorphic(
      style: NeumorphicStyle(
        border: NeumorphicBorder.none(),
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
    return Scaffold(
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
                    Neumorphic(
                      margin: const EdgeInsets.symmetric(
                          vertical: 28.0, horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                        controller: globals.titlecont,
                      ),
                    ),
                    Neumorphic(
                      margin: const EdgeInsets.symmetric(
                          vertical: 28.0, horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                        Neumorphic(
                          margin: EdgeInsets.all(18),
                          style: NeumorphicStyle(
                            depth: 5.0,
                          ),
                          child: Container(
                            width: 95,
                            height: 65,
                            child: TextButton(
                              onPressed: () {
                                if (globals.titlecont.text.isNotEmpty &&
                                    globals.subtitlecont.text.isNotEmpty) {
                                  globals.tasks.add(globals.Task(globals.titlecont.text, globals.subtitlecont.text, globals.myIndex));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                  );
                                  globals.titlecont.text = CreateTaskPage().empty;
                                  globals.subtitlecont.text = CreateTaskPage().empty;
                                } else {
                                  HapticFeedback.heavyImpact();
                                  Fluttertoast.showToast(
                                      msg:
                                          "You have to fill all fields to make a new Task",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: Colors.white70,
                                      textColor: Colors.black54, fontSize: 18.0);
                                }

                              },
                              child:DefaultTextStyle(
                                child: Text('Add'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.blueAccent),
                              ),
                            ),
                          ),
                        ),

                      ],
                    )),
                Positioned(
                    bottom: 10,
                    left: 25,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Neumorphic(
                          margin: EdgeInsets.all(18),
                          style: NeumorphicStyle(
                          depth: 5.0,
                        ),
                          child: Container(
                            width: 95,
                            height: 65,
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyApp()),
                                );
                              },
                              child:DefaultTextStyle(
                                child: Text('Cancel'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black54),
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
        child:Row(
            children: [
              Text('Press here to add Tasks  ',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: globals.validatorColor),
                ),
              Icon(Icons.arrow_right_alt_sharp,color: globals.validatorColor,size: 40,),
              Neumorphic(
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(8)),
                ),
                margin: EdgeInsets.all(18),
                child: IconButton(
                  onPressed: () {
                    HapticFeedback.vibrate();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateTaskPage()),
                    );
                  },
                  icon: NeumorphicIcon(
                    Icons.add,
                    size: 35,
                    style: NeumorphicStyle(color: Colors.black54),
                  ),
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
    return Sizer(
      builder: (context, orientation, deviceType) {
        return NeumorphicApp(
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
                          Neumorphic(
                            margin: const EdgeInsets.only(
                                left: 28.0,right: 28.0, top: 60.0,bottom: 28,),
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                          Neumorphic(
                            margin: const EdgeInsets.symmetric(
                                vertical: 28.0, horizontal: 30),
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                        bottom: 4.h,
                        child: Container(
                          width: 100.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Neumorphic(
                                    style: NeumorphicStyle(
                                      depth: 5.0,
                                    ),
                                    child: Container(
                                      width: 23.w,
                                      height: 8.h,
                                      child: TextButton(
                                        onPressed: () {
                                          globals.titlecont.text =
                                              CreateTaskPage().empty;
                                          globals.subtitlecont.text =
                                              CreateTaskPage().empty;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MyApp()),
                                          );
                                        }, child: DefaultTextStyle(
                                        child: Text('Cancel'),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black54),
                                      ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Neumorphic(
                                    style: NeumorphicStyle(
                                      depth: 5.0,
                                    ),
                                    child: Container(
                                      width: 23.w,
                                      height: 8.h,
                                      child: TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  AlertDialog(
                                                    backgroundColor: Color(0xffefefef),
                                                    title: Text('This cant be undone'),
                                                    content: Text('Press Confirm to Delete'),
                                                    actions: <Widget>[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: [
                                                          Neumorphic(
                                                            child: TextButton(
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
                                                                    textColor: Colors.black54, fontSize: 18.0);
                                                              },
                                                              child: Text(
                                                                'Confirm',
                                                                style: TextStyle(
                                                                  color: Colors.blueAccent,
                                                                ),),
                                                            ),
                                                          ),
                                                          Neumorphic(
                                                              child:TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(_);
                                                                  Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => taskManager()),
                                                                  );
                                                                }, child: Text('Cancel',style: TextStyle(color: Colors.black54),),)
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                          );
                                        },
                                        child: DefaultTextStyle(
                                          child: Text('Delete'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.redAccent),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Neumorphic(
                                    style: NeumorphicStyle(
                                      depth: 5.0,
                                    ),
                                    child: Container(
                                      width: 23.w,
                                      height: 8.h,
                                      child: TextButton(
                                        onPressed: () {
                                          if (globals.titleEditorcont.text
                                              .isNotEmpty &&
                                              globals.subtitleEditorcont.text
                                                  .isNotEmpty) {
                                            globals.tasks[globals.myIndex].title= globals.titleEditorcont.text;
                                            globals.tasks[globals.myIndex].subtitle= globals.subtitleEditorcont.text;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyApp()),
                                            );
                                            globals.titlecont.text =
                                                CreateTaskPage().empty;
                                            globals.subtitlecont.text =
                                                CreateTaskPage().empty;
                                          } else {
                                            HapticFeedback.lightImpact();
                                            Fluttertoast.showToast(
                                                msg:
                                                "You have to fill all fields to edit this Task",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 2,
                                                backgroundColor: Colors.white70,
                                                textColor: Colors.black54, fontSize: 18.0);
                                          }
                                        },
                                        child: DefaultTextStyle(
                                          child: Text('Done'),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: Colors.blueAccent),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
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
    );
  }
}