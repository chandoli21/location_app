import 'package:flutter_local_search_app/data/model/location.dart';
import 'package:flutter_local_search_app/data/repository/location_repository.dart';
import 'package:flutter_local_search_app/data/repository/vworld_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  List<Location> locations;
  HomeState({required this.locations});
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState(locations: []);
  }

  final locationRepository = const LocationRepository();
  final vworldRepository = const VworldRepository();

  void searchByLatLng(double lat, double lng) async {
    final locationResult = await vworldRepository.findByLatLng(lat, lng);
    if (locationResult.isNotEmpty) {
      searchLocation(locationResult.first);
    }
  }

  void searchLocation(String query) async {
    final result = await locationRepository.searchLocation(query);
    state = HomeState(locations: result);
  }
}

final homeViewModel =
    NotifierProvider<HomeViewModel, HomeState>(() => HomeViewModel());
