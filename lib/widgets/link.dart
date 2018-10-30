import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Link extends StatelessWidget {
  final String _displayText;
  final String _linkUrl;
  Link(this._displayText, this._linkUrl);
  
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Padding(
        padding: new EdgeInsets.symmetric(vertical: 5.0),
        child: new Text(_displayText, style: new TextStyle(color: Colors.lightBlue)),
      ),
      onTap: (){
        launch(_linkUrl);
      },
    );
  }
}