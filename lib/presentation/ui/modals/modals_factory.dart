import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/extensions/context_extension.dart';
import 'bottom_sheets/close_button_bottom_sheet.dart';

abstract class ModalsFactory {
  const ModalsFactory._();

  //? Bottom Sheets Routes
  static Route<T> closeButtonModalBottomSheetBuilder<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return ModalBottomSheetRoute<T>(
      builder: (context) => CloseButtonBottomSheet(
        child: Material(child: child),
      ),
      isScrollControlled: true,
      settings: page,
    );
  }

  //? Alert Dialog Routes
  static Route<T> customAlertDialogBuilder<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return DialogRoute<T>(
      context: context,
      builder: (context) => child,
      settings: page,
    );
  }

  //? Overlay Routes
  static Route<T> loadingAlertDialogBuilder<T>(
    BuildContext context,
    Widget child,
    AutoRoutePage<T> page,
  ) {
    return DialogRoute<T>(
      context: context,
      barrierDismissible: false,
      barrierColor: context.colorScheme.onBackground.withOpacity(0.5),
      builder: (context) => child,
      settings: page,
    );
  }
}
