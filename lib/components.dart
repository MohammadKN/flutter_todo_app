import 'package:flutter/services.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'create_task.dart';
import 'main.dart';

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
            glowColor: validatorColor,
            blurRadius: 300,
            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: validatorColor),
          ),
          Icon(
            Icons.arrow_right_alt_rounded,
            color: validatorColor,
            size: 40,
          ),
          Hero(
            tag: "addButton",
            child: Container(
              height: 115,
              width: 115,
              child: NeumorphicButton(
                onPressed: () {
                  HapticFeedback.vibrate();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskPage()),);
                },
                margin: EdgeInsets.all(24),
                child: Container(
                    height: 40,
                    width: 26,
                    alignment: Alignment.center,
                    child: GlowIcon(Icons.add, color: Colors.black54,size: 28.0,glowColor: Colors.black26,)
                ),
              ),
            ),
          ),
        ]
        )
    );
  }
}