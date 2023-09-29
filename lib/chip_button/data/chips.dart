import 'package:flutter/material.dart';
import 'package:custom_flutter/chip_button/model/index.dart';

class Chips {
  static const List<ChipData> all = [
    ChipData(
      label: 'Chip',
      backgroundColor: Colors.red,
    ),
    ChipData(
      label: 'ActionChip',
      backgroundColor: Colors.blue,
    ),
    ChipData(
      label: 'InputChip',
      backgroundColor: Colors.orange,
    ),
    ChipData(
      label: 'FilterChip',
      backgroundColor: Colors.green,
    ),
    ChipData(
      label: 'ChoiceChip',
      backgroundColor: Colors.purple,
    ),
  ];
}
