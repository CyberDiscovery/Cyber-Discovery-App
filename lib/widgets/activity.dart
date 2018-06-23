import 'package:flutter/material.dart';
import 'dart:math';

import 'package:cyber_discovery/activity_data.dart';

class Activity extends StatefulWidget {
  final ActivityData _activityData;

  Activity(this._activityData);
  
  @override
  _ActivityState createState() => _ActivityState(_activityData);
}

class _ActivityState extends State<Activity> {
  final ActivityData activityData;
  
  _ActivityState(this.activityData);

  String getHumanTime(DateTime time) {
    DateTime local = time.toLocal();
    return local.hour.toString().padLeft(2, "0") + ":" + local.minute.toString().padLeft(2, "0");
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    DateTime startTime = new DateTime.fromMillisecondsSinceEpoch(activityData.startTimestamp, isUtc: true).toLocal();
    DateTime endTime = new DateTime.fromMillisecondsSinceEpoch(activityData.endTimestamp, isUtc: true).toLocal();
    bool finished = endTime.isAfter(now);
    double progress = (now.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch)/(endTime.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch);
    progress = max(progress, 0.0);
    progress = min(progress, 1.0);

    return new Card(
      child: new Padding(
        padding: new EdgeInsets.all(5.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Flexible(
                  fit: FlexFit.loose,
                  child: new Icon(Icons.check_circle_outline, color: finished? Colors.black:Colors.green),
                ),
                new Flexible(
                  fit: FlexFit.tight,
                  child: new Text(activityData.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.title,        
                  ),
                ),
                new Flexible(
                  fit: FlexFit.tight,
                  child: new Text("Start: " + getHumanTime(startTime)),
                ),
                new Flexible(
                  fit: FlexFit.tight,
                  child: new Text("End: " + getHumanTime(endTime)),
                ),
              ],
            ),
            new Text(activityData.description,
              style: Theme.of(context).textTheme.caption,
            ),
            new Padding(
              padding: new EdgeInsets.only(top: 5.0),
              child: new LinearProgressIndicator(
                value: progress,
                valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                backgroundColor: new Color.fromRGBO(13, 35, 50, 1.0),
              ),
            )
          ],
        ),
      )
    );
  }
}