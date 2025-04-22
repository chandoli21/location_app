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

    if (response.statusCode == 200) {
      return List.from(response.data['items'])
          .map((e) => Location.fromJson(e))
          .toList();
    }

    return [];
  }
}
