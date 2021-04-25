import 'package:flutter/material.dart';

Future<bool> showErrorDialog(
  BuildContext context, {
  String title = "",
  String message = "",
}) {
  Widget cancelButton = FlatButton(
    child: Text("Continuar"),
    onPressed: () => Navigator.pop(context, false),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(
      message,
      textAlign: TextAlign.left,
      style: TextStyle(),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    actions: [
      cancelButton,
    ],
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) => alert,
  );
}

Future<bool> showSuccessDialog(
  BuildContext context, {
  String title = "",
  String message = "",
}) {
  Widget cancelButton = FlatButton(
    child: Text("Continuar"),
    onPressed: () => Navigator.pop(context, false),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(
      message,
      textAlign: TextAlign.left,
      style: TextStyle(),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    actions: [
      cancelButton,
    ],
  );

  return showDialog(
    context: context,
    builder: (BuildContext context) => alert,
  );
}