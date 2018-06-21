import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:cyber_discovery/widgets/drawer_header.dart';
import 'package:cyber_discovery/widgets/list_item.dart';
import 'package:cyber_discovery/pages/event_page.dart';
import 'package:cyber_discovery/pages/soundboard_page.dart';
import 'package:cyber_discovery/pages/blog_page.dart';

class HomePage extends StatefulWidget {
  final FirebaseDatabase _db;
  final FirebaseAnalytics _analytics;
  HomePage(this._db, this._analytics);
  
  @override
  _HomePageState createState() => _HomePageState(_db, _analytics);
}

class _HomePageState extends State<HomePage> {
  final FirebaseDatabase db;
  final FirebaseAnalytics analytics;
  _HomePageState(this.db, this.analytics);

  int _pageId = 0;

  Widget getActivePage(id, db) {
    switch(id) {
      case 0: 
        return new EventPage(db);
      case 1: 
        return new SoundBoardPage(db, analytics);
      case 2:
        return new BlogPage();
      default:
        return new Text("ERROR");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Cyber Discovery"),
        ),
        drawer: new Drawer(
          child: new Container(
            color: Colors.deepPurple[500],
            child: new ListView(
              children: <Widget>[
                new DrawerHead(),
                new ListItem(Icons.access_time, "Events", (){setState(
                  (){
                    _pageId = 0;
                    Navigator.pop(context);
                  });
                }),
                new ListItem(Icons.notifications, "Soundboard", (){setState(
                  (){
                    _pageId = 1;
                    Navigator.pop(context);
                  });
                }),
                new ListItem(Icons.library_books, "Blog", (){
                  Navigator.pop(context);
                  setState((){_pageId = 2;});
                }),
              ],
            ),
          ),
        ),
        body: getActivePage(_pageId, db),
      backgroundColor: new Color.fromRGBO(9, 24, 35, 1.0)
    );
  }
}