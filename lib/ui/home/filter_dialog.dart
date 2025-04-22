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
      title: const Text('Filter Results'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _categoryController,
            decoration: const InputDecoration(
              labelText: 'Category',
              hintText: 'e.g., restaurants, cafes',
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
          DropdownButtonFormField<SortOption?>(
            value: _currentFilter.sortBy,
            decoration: const InputDecoration(
              labelText: 'Sort By',
            ),
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('None'),
              ),
              ...SortOption.values.map(
                (option) => DropdownMenuItem(
                  value: option,
                  child: Text(option.name),
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
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onFilterChanged(_currentFilter);
            Navigator.of(context).pop();
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}
