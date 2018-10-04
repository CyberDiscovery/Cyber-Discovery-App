import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:cyber_discovery/comunity_data.dart';

class Comunity extends StatelessWidget {
  final ComunityData _data;
  Comunity(this._data);
  
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        children: <Widget>[
          new SizedBox(
            child: new Image(image: _data.imageProvider),
            width: 130.0,
            height: 130.0,
          ),
          new Flexible(
            fit: FlexFit.tight,
            child: new Card(
              child: new SizedBox(
                height: 130.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Padding(
                      padding: new EdgeInsets.symmetric(vertical: 5.0),
                      child: new Text(_data.title, style: Theme.of(context).textTheme.headline, textAlign: TextAlign.center,),
                    ),
                    new Padding(
                      padding: new EdgeInsets.only(bottom: 2.0),
                      child: new Text(_data.subtitle, style: Theme.of(context).textTheme.subhead, textAlign: TextAlign.center,),
                    ),
                    new Flexible(
                      child: new Container(),
                      fit: FlexFit.tight,
                    ),
                    new Padding(
                      padding: new EdgeInsets.symmetric(vertical: 3.0),
                      child: new RaisedButton(
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                        child: new Text("Click Here or Scan the QR Code"),
                        onPressed: (){
                          launch(_data.link);
                        },
                      ),
                    ) 
                  ],
                ),
              )
            ),     
          )
        ],
      )
    );
  }
}