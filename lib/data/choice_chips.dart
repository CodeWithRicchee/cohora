import 'package:flutter/material.dart';
import 'package:redbull/models/choice_chip_model.dart';

class ChoiceChips {
  static final all = <ChoiceChipData>[
    ChoiceChipData(
      label: 'All',
      isSelected: true,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: 'People',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: 'Comments',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: 'Photos',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
    ChoiceChipData(
      label: 'Videos',
      isSelected: false,
      selectedColor: Colors.blue,
      textColor: Colors.white,
    ),
  ];
}
