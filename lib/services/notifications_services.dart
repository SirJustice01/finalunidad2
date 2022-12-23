import 'package:flutter/material.dart';

class NotificationServices {
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey();

  static showSnackBar(String message) {
    var textStyle = const TextStyle(color: Colors.white, fontSize: 16);
    final snackBar = SnackBar(
      content: Text(
        'Email o Contraseña Invalida',
        style: textStyle,
      ),
    );
    messengerKey.currentState!.showSnackBar(snackBar);
  }
}
