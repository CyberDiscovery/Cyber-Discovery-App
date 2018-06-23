import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'dart:async';

import 'package:cyber_discovery/widgets/blog_card.dart';
import 'package:cyber_discovery/blog_data.dart';
import 'package:cyber_discovery/widgets/error_message.dart';

class BlogPage extends StatelessWidget {
  
  Future<String> getRSSData() async {
    String rssFeed = "https://medium.com/feed/@CyberDiscUK";
    String data = await http.read(rssFeed);
    //TODO implement https://pub.dartlang.org/packages/petitparser
    
    int start = 0;
    int end = 0;
    while (true) {
      if((start = data.indexOf("<scr")) != -1){
        end = data.indexOf("</scr", start) + 9;
        data = data.replaceRange(start, end, "");
      }else {
        break;
      }
    }
    while (true) {
      if((start = data.indexOf("<sty")) != -1){
        end = data.indexOf("</sty", start) + 8;
        data = data.replaceRange(start, end, "");
      }else {
        break;
      }
    }
    return data;
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getRSSData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        
        if (snapshot.hasError) {
          return new ErrorMessage("Welp Something Went Wrong", "Check your connection to the internet");
        }

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
            return new ErrorMessage("Welp Something Went Wrong", "Check your connection to the internet");
        }
      },
    );
  }
}