import 'package:flutter/material.dart';

import 'dropdown_input.dart';
import 'input.dart';

class InputGroup extends StatelessWidget {
  final String? inputTitle;
  final String inputPlaceholder;
  final String? dropdownTitle;
  final String dropdownPlaceholder;
  final List<String> dropdownItems;
  final bool disabled;
  final IconData? icon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final TextEditingController? controllerDropDown;

  const InputGroup({
    super.key,
    this.inputTitle,
    required this.inputPlaceholder,
    this.dropdownTitle,
    required this.dropdownPlaceholder,
    required this.dropdownItems,
    this.disabled = false,
    this.icon,
    this.controller,
    this.controllerDropDown,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Input(
            keyboardType: keyboardType,
            controller: controller!,
            title: inputTitle,
            hintText: inputPlaceholder,
            disabled: disabled,
            icon: icon,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          flex: 1,
          child: DropdownInput(
            controller: controllerDropDown!,
            title: dropdownTitle,
            hintText: dropdownPlaceholder,
            items: dropdownItems,
            disabled: disabled,
          ),
        ),
      ],
    );
  }
}
