import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';

import 'package:cyber_discovery/widgets/prevention_message.dart';
import 'package:cyber_discovery/widgets/schedule_header.dart';
import 'package:cyber_discovery/widgets/activity.dart';
import 'package:cyber_discovery/activity_data.dart';

class ScheduleTab extends StatelessWidget {
  final FirebaseDatabase _db;
  final String _tabName;

  ScheduleTab(this._db, this._tabName);

  Future<DataSnapshot> getScheduleData() {
    return _db.reference().child("Schedule").child("Schedules").child(_tabName).once();
  }

  bool isAcive(data) {
    int startTime = new DateTime.fromMillisecondsSinceEpoch(data["startTimestamp"], isUtc: true).millisecondsSinceEpoch;
    int endTime = new DateTime.fromMillisecondsSinceEpoch(data["endTimestamp"], isUtc: true).millisecondsSinceEpoch;
    int now = new DateTime.now().millisecondsSinceEpoch + 3600000;
    return (startTime < now && now < endTime);
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<DataSnapshot>(
      future: getScheduleData(),
      builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot){
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: new CircularProgressIndicator(),
            );
          case ConnectionState.done:
            var data = snapshot.data.value;
            bool active = isAcive(data);
            
            DateTime now = new DateTime.now();
            DateTime startTime = new DateTime.fromMillisecondsSinceEpoch(data["startTimestamp"], isUtc: true).toLocal();
            DateTime endTime = new DateTime.fromMillisecondsSinceEpoch(data["endTimestamp"], isUtc: true).toLocal();
            double progress = (now.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch)/(endTime.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch);
            progress = max(progress, 0.0);
            progress = min(progress, 1.0);

            //Activities
            int count = data["activities"]["count"];
            int i = 0;
            List<Widget> activities = [
              new ScheduleHeader(_tabName, active, progress)
            ];

            for(i; i<count; i++) {
              activities.add(new Activity(
                new ActivityData(
                  data["activities"][i.toString()]["name"],
                  data["activities"][i.toString()]["startTimestamp"],
                  data["activities"][i.toString()]["endTimestamp"]
                ))
              );
            }

            return data["released"]? 
              new Padding(
                padding: new EdgeInsets.all(10.0),
                child: new ListView(
                  children: activities,
                )
              ):
              new PreventionMessage("The schedule for this event hasn't been released");
          default:
            return new Text("ERROR");
        }
      },
    );
  }
}