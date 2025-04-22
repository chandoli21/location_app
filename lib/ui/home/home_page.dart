import 'package:flutter/material.dart';
import 'package:location_app/core/geolocator_helper.dart';
import 'package:location_app/ui/detail/detail_page.dart';
import 'package:location_app/ui/home/home_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final viewModel = ref.read(homeViewModel.notifier);
      final state = ref.watch(homeViewModel);
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            actions: [
              GestureDetector(
                onTap: () async {
                  final position = await GeolocatorHelper.getPosition();
                  if (position != null) {
                    viewModel.searchByLatLng(
                        position.latitude, position.longitude);
                  }
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.transparent,
                  alignment: Alignment.center,
                  child: const Icon(Icons.gps_fixed),
                ),
              )
            ],
            title: TextField(
              maxLines: 1,
              onSubmitted: (value) {
                viewModel.searchLocation(value);
              },
              decoration: InputDecoration(
                hintText: '검색어를 입력해 주세요',
                border: MaterialStateOutlineInputBorder.resolveWith(
                  (states) {
                    if (states.contains(WidgetState.focused)) {
                      return OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      );
                    }
                    return OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ),
          body: ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: state.locations.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final location = state.locations[index];
              return GestureDetector(
                onTap: () {
                  if (location.link.startsWith('https')) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailPage(link: location.link);
                        },
                      ),
                    );
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey[300]!,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(location.category),
                      Text(location.roadAddress),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}
