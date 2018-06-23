import 'package:flutter/material.dart';

class ScheduleHeader extends StatelessWidget {
  final String _tabName;
  final bool _active;
  final double _progress;

  ScheduleHeader(this._tabName, this._active, this._progress);
  
  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new  Text(_tabName, 
          style: Theme.of(context).textTheme.headline.apply(color: Colors.white),
          textAlign: TextAlign.left,
        ),
        new Text(_active? "In Progress":"In Active",
          style: Theme.of(context).textTheme.subhead.apply(color: _active? Colors.green:Colors.red),
          textAlign: TextAlign.left,
        ),
        new Padding(
          padding: new EdgeInsets.only(top: 6.0),
          child: new LinearProgressIndicator(
            value: _progress,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
            backgroundColor: Colors.red,
          ),
        ),
        new Divider(color: Colors.white,)
      ],
    );
  }
}