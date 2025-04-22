import 'package:geolocator/geolocator.dart';

class GeolocatorHelper {
  static bool _isDenied(LocationPermission permission) {
    return permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;
  }

  static Future<Position?> getPosition() async {
    final permission = await Geolocator.checkPermission();
    // 1. 현재 권한이 허용되지 않았을때 권한 요청하기
    if (_isDenied(permission)) {
      // 2. 권한 요청 후 결과가 거부일 때 리턴하기
      final permission2 = await Geolocator.requestPermission();
      if (_isDenied(permission2)) {
        return null;
      }
    }

    // 3. Geolocator 로 위치 가져와서 리턴
    final position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      ),
    );
    return position;
  }
}
