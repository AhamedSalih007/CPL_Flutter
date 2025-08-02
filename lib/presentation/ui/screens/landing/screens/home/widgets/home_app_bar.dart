import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/router/app_router.dart';
import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/enums/category.dart';
import '../../../../../../providers/home/home_provider.dart';
import '../../../../../widgets/circular_icon.dart';
import 'category_selection_container.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: context.colorScheme.primary,
      toolbarHeight: (ref.watch(categorySelectionNotifierProvider))
          ? kToolbarHeight + context.screenHeight * 0.2
          : kToolbarHeight,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      title: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  ref
                      .read(categorySelectionNotifierProvider.notifier)
                      .updateTo();
                },
                child: Container(
                  height: 50,
                  width: context.screenWidth * 0.5,
                  decoration: BoxDecoration(
                    color: ref.watch(categorySelectionNotifierProvider)
                        ? context.customColors.white10Color
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: UIDimensions.allPaddingInsets(8.0),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            ref.watch(selectedCategoryNotifierProvider) ==
                                    CategoryType.cpl
                                ? Assets.images.logo.image(height: 36)
                                : Assets.images.wcpl.image(height: 36),
                            ref.watch(categorySelectionNotifierProvider)
                                ? const Icon(Icons.arrow_drop_up)
                                : const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              InkWell(
                  onTap: () => context.pushRoute(const SearchRoute()),
                  child: const SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularIcon(
                        icon: Icon(
                      Icons.search,
                      size: 24,
                    )),
                  ))
            ],
          ),
          const CategorySelectionContainer(),
        ],
      ),
      centerTitle: false,
    );
  }
}
