import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final IconData _icon;
  final String _text;
  final VoidCallback _action;
  ListItem(this._icon, this._text, this._action);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Card(
          color: Theme.of(context).primaryColor,
          elevation: 0.0,
          margin: new EdgeInsets.all(0.0),
          child: new InkWell(
            onTap: _action,
            child: new Padding(
              padding: new EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
              child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Icon(_icon, color: Colors.white, size: 40.0,),
                new Text(_text, style: Theme.of(context).textTheme.title.apply(color: Colors.white),)
              ]),
            ),
          ),
        ),
        new Divider()
      ],
    );
  }
}