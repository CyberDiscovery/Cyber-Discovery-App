import 'package:flutter/material.dart';
import 'package:cyber_discovery/blog_data.dart';

import 'package:html2md/html2md.dart' as html2md;
import 'package:flutter_markdown/flutter_markdown.dart';

class BlogCard extends StatelessWidget {
  final BlogData _blogData;

  BlogCard(this._blogData);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: new Card(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0, ),
              child: new Text(_blogData.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.title
              ),
            ),
            new Divider(height: 0.0),
            new Padding(
              padding: new EdgeInsets.all(5.0),
              child: new MarkdownBody(data: html2md.convert(_blogData.content)),
            )
          ],
        ),
      ),
    );
  }
}
