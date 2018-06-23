import 'package:flutter/material.dart';

import 'package:cyber_discovery/schedule_state.dart';

class ScheduleHeader extends StatelessWidget {
  final String _tabName;
  final ScheduleState _state;

  ScheduleHeader(this._tabName, this._state);
  
  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new  Text(_tabName, 
          style: Theme.of(context).textTheme.headline.apply(color: Colors.white),
          textAlign: TextAlign.left,
        ),
        new Text(_state.state,
          style: Theme.of(context).textTheme.subhead.apply(color: _state.active? Colors.green:Colors.red),
          textAlign: TextAlign.left,
        ),
        new Divider(color: Colors.white,)
      ],
    );
  }
}