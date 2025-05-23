// {
//       "title": "코엑스아쿠아리움",
//       "link": "http://www.coexaqua.com/",
//       "category": "관람,체험>아쿠아리움",
//       "description": "",
//       "telephone": "",
//       "address": "서울특별시 강남구 삼성동 159",
//       "roadAddress": "서울특별시 강남구 영동대로 513",
//       "mapx": "1270583802",
//       "mapy": "375133680"
//     }

import 'package:html_unescape/html_unescape.dart';

class Location {
  final String title;
  final String link;
  final String category;
  final String description;
  final String telephone;
  final String address;
  final String roadAddress;
  final String mapx;
  final String mapy;

  Location({
    required this.title,
    required this.link,
    required this.category,
    required this.description,
    required this.telephone,
    required this.address,
    required this.roadAddress,
    required this.mapx,
    required this.mapy,
  });

  factory Location.fromJson(Map<String, dynamic> map) {
    final unescape = HtmlUnescape();
    return Location(
      title: unescape.convert(map["title"]?.toString() ?? ''),
      link: map["link"]?.toString() ?? '',
      category: map["category"]?.toString() ?? '',
      description: map["description"]?.toString() ?? '',
      telephone: map["telephone"]?.toString() ?? '',
      address: map["address"]?.toString() ?? '',
      roadAddress: map["roadAddress"]?.toString() ?? '',
      mapx: map["mapx"]?.toString() ?? '',
      mapy: map["mapy"]?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
        "category": category,
        "description": description,
        "telephone": telephone,
        "address": address,
        "roadAddress": roadAddress,
        "mapx": mapx,
        "mapy": mapy,
      };
}
