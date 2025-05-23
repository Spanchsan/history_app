import 'package:flutter/material.dart';

class Utils {
  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }

  static AppBar getStandardAppBar(String titleText,
      [bool backButton = true, backFunc = ()]) {
    return AppBar(
      title: Text(titleText),
      automaticallyImplyLeading: backButton,
      leading: backButton
          ? InkWell(
              onTap: backFunc,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            )
          : const SizedBox.shrink(),
      centerTitle: true,
    );
  }

  static ButtonStyle getStandardButtonStyle(
      [Size minSize = const Size(220, 100)]) {
    return TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.elliptical(5, 10))),
        minimumSize: minSize);
  }

  static void showSnackBar(BuildContext context, String barText,
      [Duration duration = const Duration(milliseconds: 600)]) {
    SnackBar snackBar = SnackBar(duration: duration, content: Text(barText));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class Question {
  String question;
  List<String> answers;
  int corAnsId;
  Question(this.question, this.answers, this.corAnsId);
}

class Message {
  // Indicates whether the message was sent by the user (true) or received (false).
  final bool isSender;

  // The content of the message as a string.
  final String msg;

  // Constructor to initialize the Message object with the sender status and message content.
  Message(this.isSender, this.msg);
}
