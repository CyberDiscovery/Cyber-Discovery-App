import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'dart:async';

import 'package:cyber_discovery/widgets/blog_card.dart';
import 'package:cyber_discovery/blog_data.dart';

class BlogPage extends StatelessWidget {
  
  Future<String> getRSSData() {
    String rssFeed = "https://medium.com/feed/@CyberDiscUK";
    return http.read(rssFeed);
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRSSData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        switch(snapshot.connectionState) {
          case ConnectionState.waiting:
            return new Center(
              child: new CircularProgressIndicator(),
            );
          case ConnectionState.done:
            //Parse and Render RSS Data
            List<Widget> articles = [];
            xml.parse(snapshot.data).findAllElements("item").forEach((xml){
              BlogData data = new BlogData(xml);
              articles.add(new BlogCard(data));
            });

            return new ListView(
              children: articles,
            );
          default:
            return new Text("ERROR");
        }
      },
    );
  }
}