import 'package:flutter/material.dart';

import 'package:cyber_discovery/schedule_state.dart';
import 'package:intl/intl.dart';

class ScheduleHeader extends StatelessWidget {
  final String _tabName;
  final DateTime _startDate;
  final ScheduleState _state;

  ScheduleHeader(this._tabName, this._startDate, this._state);
  
  String getHumanDate(DateTime dateTime) {
    DateTime local = dateTime..toLocal();
    return new DateFormat.yMMMMEEEEd().format(local);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new  Text(_tabName, 
          style: Theme.of(context).textTheme.headline.apply(color: Colors.white),
          textAlign: TextAlign.left,
        ),
        new Text(getHumanDate(_startDate),
          style: Theme.of(context).textTheme.caption.apply(color: Colors.white),
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