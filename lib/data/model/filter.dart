enum SortOption {
  distance,
  rating,
  popularity,
}

class Filter {
  final String? category;
  final SortOption? sortBy;
  final double? maxDistance;

  const Filter({
    this.category,
    this.sortBy,
    this.maxDistance,
  });

  Filter copyWith({
    String? category,
    SortOption? sortBy,
    double? maxDistance,
  }) {
    return Filter(
      category: category ?? this.category,
      sortBy: sortBy ?? this.sortBy,
      maxDistance: maxDistance ?? this.maxDistance,
    );
  }
}
