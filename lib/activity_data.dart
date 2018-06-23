class ActivityData {
  final String _name;
  final int _startTimestamp;
  final int _endTimestamp;

  ActivityData(
    this._name,
    this._startTimestamp,
    this._endTimestamp
  );

  get name => _name;
  get startTimestamp => _startTimestamp;
  get endTimestamp => _endTimestamp;
}