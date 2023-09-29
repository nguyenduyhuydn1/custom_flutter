import 'package:flutter/material.dart';
import 'package:custom_flutter/chip_button/model/index.dart';

class FilterChips {
  static final List<FilterChipData> all = [
    const FilterChipData(
      label: 'Price: Low To High',
      isSelected: false,
      color: Colors.green,
    ),
    const FilterChipData(
      label: 'Price: High To Low',
      isSelected: false,
      color: Colors.red,
    ),
    const FilterChipData(
      label: 'Get By Tomorrow',
      isSelected: false,
      color: Colors.blue,
    ),
    const FilterChipData(
      label: 'Avg. Customer Review',
      isSelected: false,
      color: Colors.orange,
    ),
    const FilterChipData(
      label: 'Sort By Relevance',
      isSelected: false,
      color: Colors.purple,
    ),
  ];
}
