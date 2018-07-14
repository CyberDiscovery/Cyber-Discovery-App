import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:cyber_discovery/widgets/drawer_header.dart';
import 'package:cyber_discovery/widgets/list_item.dart';
import 'package:cyber_discovery/pages/event_page.dart';
import 'package:cyber_discovery/pages/schedule_page.dart';
import 'package:cyber_discovery/pages/soundboard_page.dart';
import 'package:cyber_discovery/pages/blog_page.dart';
import 'package:cyber_discovery/widgets/error_message.dart';

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
      case 3:
        return new SchedulePage(db);
      default:
        return new ErrorMessage("Welp Something Went Wrong", "Unknown Cause");
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
                new ListItem(Icons.calendar_today, "Schedule", (){setState(
                  (){
                    _pageId = 3;
                    Navigator.pop(context);
                  }
                );}
                ),
                new ListItem(Icons.notifications, "Soundboard", (){setState(
                  (){
                    _pageId = 1;
                    Navigator.pop(context);
                  });
                }),
                new ListItem(Icons.library_books, "Blog", (){setState(
                  (){
                    _pageId = 2;
                    Navigator.pop(context);
                  });
                }),
                new ListItem(Icons.people, "Discord", (){setState(
                  (){
                    launch("https://discord.gg/Kf8n5rT");
                  });
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