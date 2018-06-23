import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:audioplayer/audioplayer.dart';

import 'package:cyber_discovery/widgets/sound_tab.dart';
import 'package:cyber_discovery/widgets/error_message.dart';

class SoundBoardPage extends StatelessWidget {
  final FirebaseDatabase _db;
  final FirebaseAnalytics _analytics;
  SoundBoardPage(this._db, this._analytics);  
  
  final AudioPlayer audioPlayer = new AudioPlayer();

  Future<DataSnapshot> getTabData() {
    return _db.reference().child("Soundboard").child("Tabs").once();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
      future: getTabData(),
      builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: new CircularProgressIndicator(),
            );
          case ConnectionState.done:
            //Load Tabs
            int i = 0;
            List<Widget> tabs = [];
            List<Widget> tabPages = [];
            for(i; i<snapshot.data.value["count"]; i++) {
              tabs.add(new Tab(text: snapshot.data.value[i.toString()]));
              tabPages.add(new SoundTab(_db, _analytics, audioPlayer, snapshot.data.value[i.toString()]));
            }

            return new DefaultTabController(
              length: i+1,
              child: new Scaffold(
                backgroundColor: new Color.fromRGBO(13, 35, 50, 1.0),
                appBar: new TabBar(
                  tabs: tabs,
                  indicatorColor: Theme.of(context).primaryColor,
                ),
                floatingActionButton: new FloatingActionButton(
                  onPressed: (){
                    audioPlayer.stop();
                  },
                  backgroundColor: Theme.of(context).primaryColor.withAlpha(200),
                  child: new Icon(
                    Icons.pause,
                    color: Colors.white),
                ),
                body: new TabBarView(
                  children: tabPages,
                ),
              )
            );
          default:
            return new ErrorMessage("Welp Something Went Wrong", "Check your connection to the internet");
        }
      },
    );
  }
}