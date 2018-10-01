import 'package:flutter/material.dart';

class DrawerHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Theme.of(context).primaryColor,
      child: new Column(
        children: <Widget>[
          new Image.asset("assets/images/drawer_head.png"),
          new Divider(),
          new Text("Cyber Discovery App", style: Theme.of(context).textTheme.headline.apply(color: Colors.white)),
          new Padding(
            padding: new EdgeInsets.only(top: 5.0),
            child: new Text("The UNOFFICIAL Cyber Discovery App", style: Theme.of(context).textTheme.caption.apply(color: Colors.white))
          ),
          new Divider()
        ],
      )
    );
  }
}