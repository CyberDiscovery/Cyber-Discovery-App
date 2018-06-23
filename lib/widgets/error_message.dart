import 'package:flutter/material.dart';

class ErrorMessage extends StatelessWidget {
  final String _message;
  final String _subMessage;

  ErrorMessage(this._message, this._subMessage);
  
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset("assets/images/error_image.png"),
          new Padding(
            padding: new EdgeInsets.only(top: 15.0),
            child: new Text(_message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.title.apply(color: Colors.red),
            ),
          ),
          new Padding(
            padding: new EdgeInsets.only(top: 5.0, bottom: 70.0),
            child: new Text(_subMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.subhead.apply(color: Colors.redAccent),      
            ),
          )
        ],
      )
    );
  }
}