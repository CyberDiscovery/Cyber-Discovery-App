import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class Contributors extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.symmetric(vertical: 10.0),
      child: new Card(
        margin: new EdgeInsets.all(0.0),
        child: new Column(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Image.asset("assets/images/contributors.png"),
                new Padding(
                  padding: new EdgeInsets.all(5.0),
                  child: new Column(
                    children: <Widget>[
                      new Text("Contributors", style: Theme.of(context).textTheme.headline),
                      new Padding(
                        padding: new EdgeInsets.symmetric(vertical: 5.0),
                        child: new Text("This app is the result of some amazing people from the community! Why not give them a follow and show your appreciation?"),
                      ),
                      new GestureDetector(
                        child: new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 5.0),
                          child: new Text("@BenTechy66 - Building the IOS version without paying a cent", style: new TextStyle(color: Colors.lightBlue)),
                        ),
                        onTap: (){
                          launch("https://twitter.com/BenTechy66");
                        },
                      ),
                      new GestureDetector(
                        child: new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 5.0),
                          child: new Text("@thebeanogamer - Financial support and marketing", style: new TextStyle(color: Colors.lightBlue)),
                        ),
                        onTap: (){
                          launch("https://twitter.com/thebeanogamer");
                        },
                      ),
                      new GestureDetector(
                        child: new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 5.0),
                          child: new Text("@dwouca - Curing my dislexia and the website", style: new TextStyle(color: Colors.lightBlue)),
                        ),
                        onTap: (){
                          launch("https://twitter.com/dwouca");
                        },
                      ),
                      new GestureDetector(
                        child: new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 5.0),
                          child: new Text("@OwlNamedSeymour - Everything else", style: new TextStyle(color: Colors.lightBlue)),
                        ),
                        onTap: (){
                          launch("https://twitter.com/OwlNamedSeymour");
                        },
                      ),
                      new GestureDetector(
                        child: new Padding(
                          padding: new EdgeInsets.symmetric(vertical: 5.0),
                          child: new Text("@BritMonk3y - Graphic Design", style: new TextStyle(color: Colors.lightBlue)),
                        ),
                        onTap: (){
                          launch("https://twitter.com/BritMonk3y");
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }
}