import 'package:flutter/material.dart';
import 'dart:core';

class Countdown extends StatefulWidget {
  final int timestamp;
  Countdown(this.timestamp);

  @override
  _CountdownState createState() => _CountdownState(timestamp);
}

Map durationToHumanTime(DateTime target) {
  DateTime now = new DateTime.now();
  Duration duration = target.difference(now);

  int days = duration.inDays;
  int hours = duration.inHours - (days*24);
  int minutes = duration.inMinutes - (duration.inHours * 60);
  int seconds = duration.inSeconds - (duration.inMinutes * 60);
  var times = {"days": days, "hours": hours, "minutes":minutes, "seconds": seconds};
  return times;
}

class _CountdownState extends State<Countdown> with TickerProviderStateMixin {
  final int _timestamp;
  _CountdownState(this._timestamp);

  AnimationController controller;
  Duration duration;
  DateTime event;

  @override
  void initState() {
    super.initState();

    DateTime now = new DateTime.now();
    event = new DateTime.fromMillisecondsSinceEpoch(_timestamp, isUtc: true);  
    duration = event.difference(now);

    controller = new AnimationController(
      vsync: this,
      duration: duration
    );
    controller.forward();
  }

  @override
    void dispose() {
      controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.symmetric(vertical: 15.0),
      child: new AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          var times = durationToHumanTime(event);
          return new Padding(
            padding: new EdgeInsets.symmetric(horizontal: 20.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Flexible(
                  fit: FlexFit.tight,
                  child: new Text(
                    times["days"].toString(),
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                ),
                new Flexible(
                  fit: FlexFit.loose,
                  child: new Text(
                    "days",
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                new Flexible(
                  fit: FlexFit.tight,
                  child: new Text(
                    times["hours"].toString(),
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                ),
                new Flexible(
                  fit: FlexFit.loose,
                  child: new Text(
                    "hours",
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                new Flexible(
                  fit: FlexFit.tight,
                  child: new Text(
                    times["minutes"].toString(),
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                ),
                new Flexible(
                  fit: FlexFit.loose,
                  child: new Text(
                    "minutes",
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
                new Flexible(
                  fit: FlexFit.tight,
                  child: new Text(
                    times["seconds"].toString(),
                    style: Theme.of(context).textTheme.headline,
                    textAlign: TextAlign.center,
                  ),
                ),
                new Flexible(
                  fit: FlexFit.loose,
                  child: new Text(
                    "seconds",
                    style: Theme.of(context).textTheme.body1,
                  ),
                ),
              ],
            ),
          );
        },
      )
    );
  }
}