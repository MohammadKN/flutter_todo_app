import 'package:flutter/material.dart';


Route cTransitions (var target) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 0),
    pageBuilder: (context, animation, secondaryAnimation) => target,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = 0.0;
      const end = 1.0;
      const curve = Curves.easeInQuint;


      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return FadeTransition(
        opacity: animation.drive(tween),
        child: child,
      );
    },
  );
}


void NavTo (BuildContext context, dynamic destination) {
  Navigator.push(context, cTransitions(destination));
}