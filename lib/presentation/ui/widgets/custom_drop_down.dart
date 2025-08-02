import 'package:flutter/material.dart';

import '../../../core/utils/extensions/context_extension.dart';
import '../../../core/utils/styles/dimensions/ui_dimensions.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.selectedValue,
    this.onChanged,
    required this.hintText,
    this.items,
  });

  final String hintText;
  final T? selectedValue;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: UIDimensions.symmetricPaddingInsets(horizontal: 8),
      decoration: BoxDecoration(
          color: context.customColors.black40Color,
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(
            color: Colors.white,
          )),
      height: 40,
      width: 80,
      child: DropdownButton(
        underline: const SizedBox.shrink(),
        padding: EdgeInsets.zero,
        iconSize: 16,
        icon: const Icon(Icons.keyboard_arrow_down),
        alignment: Alignment.center,
        items: items,
        onChanged: onChanged,
        isExpanded: true,
        value: selectedValue,
        hint: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(hintText),
        ),
      ),
    );
  }
}
