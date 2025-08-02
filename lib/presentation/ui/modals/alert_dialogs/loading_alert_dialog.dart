import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../providers/core/router_provider.dart';

@RoutePage(name: "LoadingAlertDialogRoute")
class LoadingAlertDialog extends ConsumerWidget {
  final Future<void> Function() callback;

  const LoadingAlertDialog({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    callback.call().whenComplete(() {
      // setState(() {
      //   canPop = true;
      // });
      ref.read(appRouterProvider).popForced();
    });
    return PopScope(
      canPop: false,
      child: Center(
        child: UIDimensions.sizedBox(
          height: 32,
          width: 32,
          child: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
