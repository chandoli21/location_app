import 'package:location_app/data/model/location.dart';
import 'package:location_app/data/model/filter.dart';
import 'package:location_app/data/repository/location_repository.dart';
import 'package:location_app/data/repository/vworld_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  final List<Location> locations;
  final Filter filter;
  final bool isLoading;
  final String? lastSearchQuery;

  HomeState({
    required this.locations,
    this.filter = const Filter(),
    this.isLoading = false,
    this.lastSearchQuery,
  });

  HomeState copyWith({
    List<Location>? locations,
    Filter? filter,
    bool? isLoading,
    String? lastSearchQuery,
  }) {
    return HomeState(
      locations: locations ?? this.locations,
      filter: filter ?? this.filter,
      isLoading: isLoading ?? this.isLoading,
      lastSearchQuery: lastSearchQuery ?? this.lastSearchQuery,
    );
  }
}

class HomeViewModel extends Notifier<HomeState> {
  @override
  HomeState build() {
    return HomeState(locations: []);
  }

  final locationRepository = const LocationRepository();
  final vworldRepository = const VworldRepository();

  void searchByLatLng(double lat, double lng) async {
    state = state.copyWith(isLoading: true);
    final locationResult = await vworldRepository.findByLatLng(lat, lng);
    if (locationResult.isNotEmpty) {
      searchLocation(locationResult.first);
    }
    state = state.copyWith(isLoading: false);
  }

  void searchLocation(String query) async {
    state = state.copyWith(isLoading: true);
    final result = await locationRepository.searchLocation(query);
    state = state.copyWith(
      locations: _applyFilters(result),
      isLoading: false,
      lastSearchQuery: query,
    );
  }

  void updateFilter(Filter newFilter) {
    if (state.lastSearchQuery != null) {
      // If we have a previous search, reapply it with the new filter
      searchLocation(state.lastSearchQuery!);
    } else {
      // If no previous search, just update the filter
      state = state.copyWith(
        filter: newFilter,
        locations: _applyFilters(state.locations),
      );
    }
  }

  List<Location> _applyFilters(List<Location> locations) {
    var filteredLocations = List<Location>.from(locations);

    // Apply category filter
    if (state.filter.category != null) {
      filteredLocations = filteredLocations
          .where((location) =>
              location.category.contains(state.filter.category!) ||
              location.title.contains(state.filter.category!))
          .toList();
    }

    // Apply distance filter
    if (state.filter.maxDistance != null) {
      // TODO: Implement distance filtering when we have distance data
    }

    // Apply sorting
    if (state.filter.sortBy != null) {
      switch (state.filter.sortBy) {
        case SortOption.distance:
          // For now, we'll just return the original order
          // TODO: Implement distance sorting when we have distance data
          break;
        case SortOption.rating:
          // For now, we'll just return the original order
          // TODO: Implement rating sorting when we have rating data
          break;
        case SortOption.popularity:
          // For now, we'll just return the original order
          // TODO: Implement popularity sorting when we have popularity data
          break;
        default:
          break;
      }
    }

    return filteredLocations;
  }
}

final homeViewModel =
    NotifierProvider<HomeViewModel, HomeState>(() => HomeViewModel());
