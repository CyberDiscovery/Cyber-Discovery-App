import 'package:flutter/material.dart';

import 'package:cyber_discovery/widgets/link.dart';

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
                      new Link("@BenTechy66 - Building the IOS version without paying a cent", "https://twitter.com/BenTechy66"),
                      new Link("@thebeanogamer - Financial support and marketing", "https://twitter.com/thebeanogamer"),
                      new Link("@dwouca - Curing my dislexia and the website", "https://twitter.com/dwouca"),
                      new Link("@OwlNamedSeymour - Everything else", "https://twitter.com/OwlNamedSeymour"),
                      new Link("@BritMonk3y - Graphic Design", "https://twitter.com/BritMonk3y"),
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