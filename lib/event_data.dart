import 'package:cached_network_image/cached_network_image.dart';

class EventData {
  final String _name;
  final String _description;
  final int _timestamp;
  final CachedNetworkImageProvider _imageProvider;
  EventData(this._name, this._description, this._timestamp, this._imageProvider);

  get name => _name;
  get description => _description;
  get timestamp => _timestamp;
  get imageProvider => _imageProvider;
}