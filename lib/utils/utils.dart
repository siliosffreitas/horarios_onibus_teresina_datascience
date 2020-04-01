import 'package:flutter/material.dart';

void dialogAlert(context,
    {String message = "Mensagem",
    String title = "Atenção",
    bool dismissible = true,
    VoidCallback onTapOk}) {
  if (onTapOk == null) {
    onTapOk = () => Navigator.pop(context);
  }

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: onTapOk,
              )
            ],
          ),
      barrierDismissible: dismissible);
}
