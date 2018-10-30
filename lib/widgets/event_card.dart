import 'package:flutter/material.dart';
import 'dart:core';

import 'package:cyber_discovery/event_data.dart';

import 'package:cyber_discovery/widgets/countdown.dart';

class EventCard extends StatelessWidget {
  final EventData _eventData;
  EventCard(this._eventData);
  
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
        child: new Card(
        margin: new EdgeInsets.all(0.0),
        child: new Column(
          children: <Widget>[
            new Container(
              color: new Color.fromRGBO(9, 24, 35, 1.0),
              child: new Image(image: _eventData.imageProvider),
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 15.0),
              child: new Text(_eventData.name, style: Theme.of(context).textTheme.title),
            ),
            new Padding(
              padding: new EdgeInsets.symmetric(vertical: 5.0),
              child: new Text(_eventData.description, style: Theme.of(context).textTheme.caption),
            ),
            new Countdown(_eventData.timestamp),
          ],
        ),
      ),
    );
  }
}