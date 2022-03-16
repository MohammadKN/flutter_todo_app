import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'components.dart';
import 'edit_task.dart';
import 'functions.dart';
import 'main.dart';



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var transtitionAnimCont;
  @override
  void initState()  {
    transtitionAnimCont = AnimationController(
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300),
      vsync: this,
    )..forward();
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      transtitionAnimCont.reverse();
    });
  }

  Widget myListView() {
    return new ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, index) {
          final item = tasks[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                tasks.removeAt(index);
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
              child: AnimatedBuilder(
                animation: transtitionAnimCont,
                builder: (BuildContext context, Widget? child) {
                  return Transform.translate(
                    offset: Offset(0.0, transtitionAnimCont.value*225),
                    child: child,);
                },
                child: NeumorphicButton(
                  onPressed: (){
                    HapticFeedback.vibrate();
                    myIndex = index;
                    titleEditorcont.text = tasks[index].title;
                    subtitleEditorcont.text = tasks[index].subtitle;
                    NavTo((context), TaskEditPage());
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
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (tasks.length == 0) {
      setState(() {
        validatorColor = Colors.black54;
      });
    } else if (tasks.length > 0) {
      setState(() {
        validatorColor = Colors.transparent;
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