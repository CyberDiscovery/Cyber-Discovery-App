import 'package:xml/xml.dart' as xml;

class BlogData {
  String _title;
  String _content;
  List<String> _categories;
  String _pubDate;

  BlogData(xml.XmlElement xmlData) {
    this._title = xmlData.findElements("title").single.text;
    this._content = xmlData.findElements("content:encoded").single.text;
    this._categories = xmlData.findAllElements("category").map(
      (xml.XmlElement categoryXml){
        return categoryXml.text;
      }
    ).toList();
    this._pubDate = xmlData.findElements("pubDate").single.text;
  }

  get title => _title;
  get content => _content;
  get categories => _categories;
  get pubDate => _pubDate;
}