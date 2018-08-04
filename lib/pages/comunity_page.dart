import 'package:flutter/material.dart';
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cyber_discovery/comunity_data.dart';

import 'package:cyber_discovery/widgets/contributers.dart';
import 'package:cyber_discovery/widgets/comunity.dart';
import 'package:cyber_discovery/widgets/error_message.dart';

class ComunityPage extends StatelessWidget {
  final FirebaseDatabase _db;
  ComunityPage(this._db);

  Future<List<ComunityData>> getComunityData(FirebaseDatabase db, BuildContext context) async {
    DataSnapshot snapshot = await db.reference().child("Comunity").once();
    dynamic data = snapshot.value;
    int count = data["count"];
    var configuration = createLocalImageConfiguration(context);
    
    List<ComunityData> comunityData = [];
    for (int i = 0; i<count; i++) {
      dynamic rawComunityData = data[i.toString()];
      ComunityData comunity = new ComunityData(
        rawComunityData["title"],
        rawComunityData["subtitle"],
        rawComunityData["link"],
        new CachedNetworkImageProvider(rawComunityData["qrLink"])..resolve(configuration)
      );
      comunityData.add(comunity);
    }
    return comunityData;
  }
  
  
  @override
  Widget build(BuildContext context) {
    /*List<Widget> comunitys = [
      new Text("Comunity", style: Theme.of(context).textTheme.headline.apply(color: Colors.white)),
      new Text("Over the course of Cyber Discovery a large comunity has formed.  Originating from the discord server several comunity projects were undertaken showing the strength of the comunity, this app is one of them.  Some others and other pillars of the comunity are listed below.", style: Theme.of(context).textTheme.body1.apply(color: Colors.white)),
      new Divider(),
      new Comunity(
        "Discord",
        "Come and Lurk",
        "https://discord.gg/Kf8n5rT",
        "assets/images/discord_qr.png"
      ),
      new Comunity(
        "The App",
        "Leave a 5 star review xxx",
        "https://play.google.com/store/apps/details?id=com.danielmilnes.cyberdiscovery",
        "assets/images/playstore_qr.png"
      ),
      new Comunity(
        "Challenge Master", "A shit webiste I made", "https://challenge-master.firebaseapp.com/", "assets/images/discord_qr.png")
    ];*/
    
    return new Padding(
      padding: new EdgeInsets.all(5.0),
      child: new FutureBuilder(
        future: getComunityData(_db, context),
        builder: (BuildContext context, AsyncSnapshot<List<ComunityData>> snapshot) {
          if (snapshot.hasError) {
            return new ErrorMessage("Welp Something Went Wrong", "Check your connection to the internet");
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Center(
                child: new CircularProgressIndicator(),
              );
            case (ConnectionState.done):
              //Got Data
              List<Widget> comunities = [new Contributors()];
              for(ComunityData data in snapshot.data) {
                comunities.add(new Comunity(data));
              }
              return new ListView(children: comunities);
            default:
              return new ErrorMessage("Welp Something Went Wrong", "Check your connection to the internet");
          }
        }
      )
      
      
      
    );
  }
}