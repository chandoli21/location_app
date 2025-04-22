# Location App

A Flutter application that helps users search for locations and get detailed information about them. The app uses the Naver Local Search API to provide location-based search results and includes features like GPS-based location search.

## Features

- Location search using text input
- GPS-based location search
- Detailed location information display
- Web view for location details
- Modern and intuitive user interface
- Support for both Android and iOS platforms
- Filter search results by category
- Sort results by distance, rating, or popularity

## Prerequisites

- Flutter SDK (version 3.5.3 or higher)
- Dart SDK (version 3.0.0 or higher)
- Android Studio / Xcode for platform-specific development
- Naver API credentials (Client ID and Client Secret)

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/chandoli21/location_app.git
cd location_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Configure API credentials:
   - Open `lib/data/repository/location_repository.dart`
   - Replace the Naver API credentials with your own:
     ```dart
     'X-Naver-Client-Id': 'YOUR_CLIENT_ID',
     'X-Naver-Client-Secret': 'YOUR_CLIENT_SECRET',
     ```

4. Run the app:
```bash
flutter run
```

## Project Structure

```
lib/
├── core/
│   └── geolocator_helper.dart
├── data/
│   ├── model/
│   │   ├── location.dart
│   │   └── filter.dart
│   └── repository/
│       ├── location_repository.dart
│       └── vworld_repository.dart
└── ui/
    ├── detail/
    │   └── detail_page.dart
    └── home/
        ├── home_page.dart
        ├── home_view_model.dart
        └── filter_dialog.dart
```

## Features in Detail

### Location Search
- Text-based search using the Naver Local Search API
- GPS-based search using device location
- Real-time search results

### Filtering and Sorting
- Filter results by category with common Korean categories:
  - 음식점 (Restaurants)
  - 카페 (Cafes)
  - 쇼핑 (Shopping)
  - 숙박 (Accommodation)
  - 문화시설 (Cultural Facilities)
  - 관광지 (Tourist Spots)
  - 병원 (Hospitals)
  - 약국 (Pharmacies)
  - 학교 (Schools)
  - 주차장 (Parking Lots)
- Sort results by:
  - 거리순 (Distance)
  - 평점순 (Rating)
  - 인기순 (Popularity)
- Multiple filter combinations
- Easy-to-use filter interface with category chips
- Korean language support throughout the app

## Dependencies

- `flutter_inappwebview`: ^6.1.5 - For displaying web content
- `dio`: ^5.7.0 - For making HTTP requests
- `flutter_riverpod`: ^2.6.1 - For state management
- `geolocator`: ^13.0.2 - For handling location services
- `html_unescape`: ^2.0.0 - For handling HTML entities in API responses

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Naver Local Search API](https://developers.naver.com/docs/serviceapi/search/local/local.md) for location data
- [Flutter](https://flutter.dev/) for the framework
- [Riverpod](https://riverpod.dev/) for state management
