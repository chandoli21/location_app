import 'package:location_app/data/model/location.dart';
import 'package:dio/dio.dart';

class LocationRepository {
  const LocationRepository();
  Future<List<Location>> searchLocation(String query) async {
    final Dio dioClient = Dio(BaseOptions(
      validateStatus: (status) => true,
    ));
    final response =
        await dioClient.get('https://openapi.naver.com/v1/search/local.json',
            queryParameters: {
              'query': query,
              'display': 5,
            },
            options: Options(
              headers: {
                'X-Naver-Client-Id': 'ABn2ztLDnM8nuCNaddqW',
                'X-Naver-Client-Secret': 'E7XNAiSR1L',
              },
            ));

    print('Naver API Response Status: ${response.statusCode}');
    print('Naver API Response Data: ${response.data}');

    if (response.statusCode == 200) {
      final items = response.data['items'] as List;
      print('Number of items found: ${items.length}');
      return items.map((e) => Location.fromJson(e)).toList();
    }

    return [];
  }
}
