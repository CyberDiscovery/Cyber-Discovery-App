import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:cyber_discovery/pages/home_page.dart';

Future<void> main() async {
  final FirebaseApp app = await FirebaseApp.configure(
    name: "Cyber Discovery",
    options: Platform.isIOS
      ? const FirebaseOptions(
        googleAppID: '1:287186378897:ios:17ac1b5ae5577712',
        gcmSenderID: '287186378897',
        databaseURL: 'https://cyber-discovery.firebaseio.com',
      )
      : const FirebaseOptions(
        googleAppID: '1:287186378897:android:2796bb5d9b40e0ba',
        apiKey: 'AIzaSyA9yBidKPCJ3VRUFd4zIKouEWprqICOcn0',
        databaseURL: 'https://cyber-discovery.firebaseio.com',
      )
  );
  runApp(new CyberDiscoveryApp(app));
} 

class CyberDiscoveryApp extends StatefulWidget {
final FirebaseApp _app;
CyberDiscoveryApp(this._app);

  @override
  _CyberDiscoveryAppState createState() => _CyberDiscoveryAppState(_app);
}

class _CyberDiscoveryAppState extends State<CyberDiscoveryApp> {
  final FirebaseApp _app;
  _CyberDiscoveryAppState(this._app);

  static FirebaseAnalytics analytics = new FirebaseAnalytics();
  final FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    firebaseMessaging.requestNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    
    //Connect To Database
    final FirebaseDatabase db = new FirebaseDatabase(app: _app);    
    
    return MaterialApp(
      title: "Cyber Discovery",
      color: Colors.deepPurple[500],
      theme: new ThemeData(
        primaryColor: Colors.deepPurple[500],
        accentColor: new Color.fromRGBO(62, 174, 211, 1.0),
        fontFamily: "Dosis",
      ),
      home: new HomePage(db, analytics),
    );
  }
}
