import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:cyber_discovery/schedule_state.dart';

import 'package:cyber_discovery/widgets/prevention_message.dart';
import 'package:cyber_discovery/widgets/schedule_header.dart';
import 'package:cyber_discovery/widgets/activity.dart';
import 'package:cyber_discovery/activity_data.dart';
import 'package:cyber_discovery/widgets/error_message.dart';

class ScheduleTab extends StatelessWidget {
  final FirebaseDatabase _db;
  final String _tabName;

  ScheduleTab(this._db, this._tabName);

  Future<DataSnapshot> getScheduleData() {
    return _db.reference().child("Schedule").child("Schedules").child(_tabName).once();
  }

  ScheduleState getState(DateTime startTime, DateTime endTime, DateTime now) {
    String state;
    bool active;
    
    if (now.millisecondsSinceEpoch < startTime.millisecondsSinceEpoch) {
      state = "Not Started";
      active = false;
      return new ScheduleState(state, active);
    }else if (now.millisecondsSinceEpoch > startTime.millisecondsSinceEpoch && now.millisecondsSinceEpoch < endTime.millisecondsSinceEpoch) {
      state = "On Going";
      active = true;
      return new ScheduleState(state, active);
    }else {
      state = "Finished";
      active = false;
      return new ScheduleState(state, active);
    }
  }

  double getProgress(DateTime startTime, DateTime endTime, DateTime now) {
    double progress = (now.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch)/(endTime.millisecondsSinceEpoch - startTime.millisecondsSinceEpoch);
    progress = max(progress, 0.0);
    progress = min(progress, 1.0);
    return progress;
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
            DateTime now = new DateTime.now();
            DateTime startTime = new DateTime.fromMillisecondsSinceEpoch(data["startTimestamp"], isUtc: true).toLocal();
            DateTime endTime = new DateTime.fromMillisecondsSinceEpoch(data["endTimestamp"], isUtc: true).toLocal();
            ScheduleState state = getState(startTime, endTime, now);

            //Activities
            int count = data["activities"]["count"];
            int i = 0;
            List<Widget> activities = [
              new ScheduleHeader(_tabName, startTime, state)
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
            return new ErrorMessage("Failed to Connect", "Check your connection to the internet");
        }
      },
    );
  }
}