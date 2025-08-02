import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/context_extension.dart';
import '../../widgets/custom_text.dart';

@RoutePage(name: "CustomAlertDialogRoute")
class CustomAlertDialog extends StatelessWidget {
  final VoidCallback allowCallback;
  final String title;
  final String? content;
  final String? positiveButtonText;
  final String? negativeButtonText;

  const CustomAlertDialog({
    super.key,
    required this.allowCallback,
    required this.title,
    this.content,
    this.positiveButtonText,
    this.negativeButtonText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText.headlineMedium(title),
      content: content == null ? null : CustomText.headlineMedium(content!),
      actions: [
        CustomText.headlineMedium(
          negativeButtonText ?? context.appLoc.cancel,
        ),
        CustomText.headlineMedium(
          positiveButtonText ?? context.appLoc.clear,
        ),
      ],
    );
  }
}
