import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import 'package:cyber_discovery/widgets/schedule_tab.dart';

class SchedulePage extends StatelessWidget {
  final FirebaseDatabase _db;
  SchedulePage(this._db);
  
  Future<DataSnapshot> getTabData() {
    return _db.reference().child("Schedule").child("Tabs").once();
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<DataSnapshot>(
      future: getTabData(),
      builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot){
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: new CircularProgressIndicator(),
            );
          case ConnectionState.done:
            //Load Tabs
            var data = snapshot.data.value;
            int i = 0;
            int count = data["count"];
            List<Widget> tabs = [];
            List<Widget> tabPages = [];
            for(i; i < count; i++) {
              tabs.add(new Tab(text: data[i.toString()]));
              tabPages.add(new ScheduleTab(_db, data[i.toString()]));
            }

            return new DefaultTabController(
              length: i+1,
              child: new Scaffold(
                backgroundColor: new Color.fromRGBO(13, 35, 50, 1.0),
                appBar: new TabBar(
                  tabs: tabs,
                  indicatorColor: Theme.of(context).primaryColor,
                ),
                body: new TabBarView(
                  children: tabPages,
                ),
              ),
            );
          default:
            return new Text("ERROR");
        }
      },
    );
  }
}