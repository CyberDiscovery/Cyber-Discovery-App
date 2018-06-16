import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:audioplayer/audioplayer.dart';

import 'package:cyber_discovery/sound.dart';

class SoundTab extends StatelessWidget {
  final FirebaseDatabase _db;
  final FirebaseAnalytics _analytics;
  final AudioPlayer _audioPlayer;
  final String _tabName;
  SoundTab(this._db, this._analytics, this._audioPlayer, this._tabName);

  Future<DataSnapshot> getSounds() {
    return _db.reference().child("Soundboard").child("Sounds").child(_tabName).once();
  }

  Future<Null> _sendAnalyticsEvent(String name) async {
    await _analytics.logEvent(
      name: 'sound_play',
      parameters: <String, dynamic>{
        'sound_name': name,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: getSounds(),
      builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: new CircularProgressIndicator(),
            );
          case ConnectionState.done:
            DataSnapshot data = snapshot.data;
            List<Sound> sounds = [];
            for(int i = 0; i<data.value["count"]; i++) {
              sounds.add(
                new Sound(
                  data.value[i.toString()]["name"],
                  data.value[i.toString()]["link"]
                )
              );
            }

            List<Widget> children = sounds.map((Sound sound) {
              return new GridTile(
                child: new Padding(
                  padding: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                  child: new Card(
                    color: new Color.fromARGB(100, 106, 130, 154),
                    child: new InkWell(
                      onTap: (){
                        //Play
                        _audioPlayer.stop();
                        _audioPlayer.play(sound.url);
                        //Log Listen
                        _sendAnalyticsEvent(sound.name);
                      },
                      child: new Padding(
                        padding: new EdgeInsets.all(1.0),
                        child: new Center(
                          child: new Text(sound.name, style: Theme.of(context).textTheme.body1.apply(color: Colors.white), textAlign: TextAlign.center),
                        ),
                      )
                    ),
                  ),
                ),
              );
            }).toList();

            return new GridView.count(
              primary: false,
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 0.75,
              children: children,
            );
          default:
            //Pretty Picture Here
            //TODO
            return new Text("Error");
        }
      },
    );
  }
}