import 'package:cached_network_image/cached_network_image.dart';

class ComunityData {
  final String _title;
  final String _subtitle;
  final String _link;
  final CachedNetworkImageProvider _imageProvider;
  ComunityData(this._title, this._subtitle, this._link, this._imageProvider);

  get title => _title;
  get subtitle => _subtitle;
  get link => _link;
  get imageProvider => _imageProvider;
}