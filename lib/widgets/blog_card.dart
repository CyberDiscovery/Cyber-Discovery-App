import 'package:flutter/material.dart';
import 'package:cyber_discovery/blog_data.dart';

import 'package:flutter_html_view/flutter_html_view.dart';

class BlogCard extends StatelessWidget {
  final BlogData _blogData;
  
  BlogCard(this._blogData);

  @override
  Widget build(BuildContext context) {

    List<Widget> categories = [];
    _blogData.categories.forEach(
      (String category){
        categories.add(new Card(
          child:  new Text(category)
          )
        );
      }
    );

    return Padding(
      padding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
      child: new Card(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.only(top: 15.0),
              child: new Text(_blogData.title, style: Theme.of(context).textTheme.title),
            ),
            new HtmlView(data: _blogData.content),
            new Flex(
              direction: Axis.horizontal,
              verticalDirection: VerticalDirection.down,
              children: categories,
            )
          ],
        ),
      ),
    );
  }
}