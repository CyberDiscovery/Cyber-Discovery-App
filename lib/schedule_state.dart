class ScheduleState {
  final String _state;
  final bool _active;

  ScheduleState(this._state, this._active);

  get state => _state;
  get active => _active;
}