import 'package:flutter/material.dart';
import 'package:location_app/data/model/filter.dart';

class FilterDialog extends StatefulWidget {
  final Filter initialFilter;
  final Function(Filter) onFilterChanged;

  const FilterDialog({
    super.key,
    required this.initialFilter,
    required this.onFilterChanged,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late Filter _currentFilter;
  final _categoryController = TextEditingController();
  final List<String> _commonCategories = [
    '음식점',
    '카페',
    '쇼핑',
    '숙박',
    '문화시설',
    '관광지',
    '병원',
    '약국',
    '학교',
    '주차장',
  ];

  @override
  void initState() {
    super.initState();
    _currentFilter = widget.initialFilter;
    _categoryController.text = _currentFilter.category ?? '';
  }

  @override
  void dispose() {
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('검색 필터'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '카테고리',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                hintText: '카테고리를 입력하세요',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _currentFilter = _currentFilter.copyWith(
                    category: value.isEmpty ? null : value,
                  );
                });
              },
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: _commonCategories.map((category) {
                return FilterChip(
                  label: Text(category),
                  selected: _currentFilter.category == category,
                  onSelected: (selected) {
                    setState(() {
                      _currentFilter = _currentFilter.copyWith(
                        category: selected ? category : null,
                      );
                      _categoryController.text = selected ? category : '';
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              '정렬 기준',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<SortOption?>(
              value: _currentFilter.sortBy,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '정렬 기준을 선택하세요',
              ),
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('기본'),
                ),
                ...SortOption.values.map(
                  (option) => DropdownMenuItem(
                    value: option,
                    child: Text(_getSortOptionText(option)),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _currentFilter = _currentFilter.copyWith(sortBy: value);
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            widget.onFilterChanged(_currentFilter);
            Navigator.of(context).pop();
          },
          child: const Text('적용'),
        ),
      ],
    );
  }

  String _getSortOptionText(SortOption option) {
    switch (option) {
      case SortOption.distance:
        return '거리순';
      case SortOption.rating:
        return '평점순';
      case SortOption.popularity:
        return '인기순';
    }
  }
}
