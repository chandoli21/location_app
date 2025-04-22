import 'package:dio/dio.dart';

class VworldRepository {
  const VworldRepository();

  Future<List<String>> findByLatLng(double lat, double lng) async {
    final Dio dioClient = Dio(BaseOptions(
      validateStatus: (status) => true,
    ));
    try {
      final response = await dioClient.get(
        'https://api.vworld.kr/req/data',
        queryParameters: {
          'request': 'GetFeature',
          'key': 'F8535CD0-9ACB-38AE-9D71-48E363366BD0',
          'data': 'LT_C_ADEMD_INFO',
          'geomFilter': 'POINT($lng $lat)',
          'geometry': false,
          'size': 100,
        },
      );

      if (response.statusCode == 200 &&
          response.data['response']['status'] == 'OK') {
        // Response > result > featureCollection > features >> properties > full_nm
        final features = response.data['response']['result']
            ['featureCollection']['features'];
        final featureList = List.from(features);
        final iterable = featureList.map((feat) {
          return '${feat['properties']['full_nm']}';
        });
        return iterable.toList();
      }

      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
