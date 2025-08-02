import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../core/utils/extensions/context_extension.dart';

@RoutePage()
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.colorScheme.primary,
      body: Center(
        child: SizedBox(
            width: context.screenWidth,
            child:
                Lottie.asset(Assets.lottie.splash, width: context.screenWidth)),
      ),
    );
  }
}
