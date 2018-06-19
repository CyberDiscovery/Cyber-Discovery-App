import 'package:flutter/material.dart';
import 'package:cyber_discovery/blog_data.dart';

import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

class BlogCard extends StatelessWidget {
  final BlogData _blogData;

  BlogCard(this._blogData);

  @override
  Widget build(BuildContext context) {

    int start = 0;
    int end = 0;
    String data = _blogData.content;
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

    return Padding(
      padding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: new Card(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: new Text(_blogData.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title
              ),
            ),
            new Divider(),
            new Padding(
              padding: new EdgeInsets.all(5.0),
              child: new MarkdownBody(data: html2md.convert(data)),
            )
          ],
        ),
      ),
    );
  }
}
