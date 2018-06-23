class ActivityData {
  final String _name;
  final String _description;
  final int _startTimestamp;
  final int _endTimestamp;

  ActivityData(
    this._name,
    this._description,
    this._startTimestamp,
    this._endTimestamp
  );

  get name => _name;
  get description => _description;
  get startTimestamp => _startTimestamp;
  get endTimestamp => _endTimestamp;
}