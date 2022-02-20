import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {

  //When creating please recheck 'context' if there is an error!

  final Color color = Color.fromARGB(220, 117, 218 ,255);

  final String title;
  final String content;
  final String yes;
  final String no;
  final Function yesOnPressed;
  final Function noOnPressed;
   BaseAlertDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.yes,
    required this.no,
    required this.yesOnPressed,
    required this.noOnPressed,
  }) : super(key: key);
  
 

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(this.title),
      content: new Text(this.content),
      backgroundColor: this.color,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new FlatButton(
          child: new Text(this.yes),
          textColor: Colors.greenAccent,
          onPressed: () {
            this.yesOnPressed();
          },
        ),
        new FlatButton(
          child: Text(this.no),
          textColor: Colors.redAccent,
          onPressed: () {
            this.noOnPressed();
          },
        ),
      ],
    );
  }
}