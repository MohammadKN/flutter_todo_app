import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'homepage.dart';

int myIndex = 0;
final titlecont = TextEditingController(),
    subtitlecont = TextEditingController(),
    titleEditorcont = TextEditingController(),
    subtitleEditorcont = TextEditingController();
Color validatorColor = Colors.black54;
List tasks = [], days = [];


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
        debugShowCheckedModeBanner: false,
        home: HomePage()
    );
  }
}





