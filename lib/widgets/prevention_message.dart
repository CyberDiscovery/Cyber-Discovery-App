import 'package:flutter/material.dart';

class PreventionMessage extends StatelessWidget {
  final String _message;

  PreventionMessage(this._message);
  
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset("assets/images/unreleased.png"),
          new Padding(
            padding: new EdgeInsets.only(top: 15.0, bottom: 70.0),
            child: new Text(_message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title.apply(color: Colors.white),
            ),
          )
        ],
      )
    );
  }
}