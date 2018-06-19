import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:cyber_discovery/widgets/event_card.dart';
import 'package:cyber_discovery/event_data.dart';

class EventPage extends StatelessWidget {
  final FirebaseDatabase _db;
  EventPage(this._db);
  
  Future<List<EventData>> getEventData(FirebaseDatabase db, BuildContext context) async {
    DataSnapshot snapshot = await db.reference().child("Events").once();
    dynamic data = snapshot.value;
    int count = data["count"];
    var configuration = createLocalImageConfiguration(context);
    
    List<EventData> eventData = [];
    for (int i = 0; i<count; i++) {
      dynamic rawEventData = data[i.toString()];
      EventData event = new EventData(
        rawEventData["name"],
        rawEventData["description"],
        rawEventData["timestamp"],
        new CachedNetworkImageProvider(rawEventData["image"])..resolve(configuration)
      );
      eventData.add(event);
    }
    eventData.sort((a, b) => a.timestamp.compareTo(b.timestamp));
    return eventData;
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: getEventData(_db, context),
      builder: (BuildContext context, AsyncSnapshot<List<EventData>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: new CircularProgressIndicator(),
            );
          case (ConnectionState.done):
            //Got Data
            List<Widget> events = [];
            for(EventData data in snapshot.data) {
              if (new DateTime.fromMillisecondsSinceEpoch(data.timestamp).isAfter(new DateTime.now())) {
                events.add(
                  new EventCard(data)
                );
              }
            }
            return new ListView(
              children: events,
            );
          default:
            //TODO
            //Image should  be here
            return new Text("ERROR");
        }
      },
    );
  }
}