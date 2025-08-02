import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/assets_gen/assets.gen.dart';
import '../../../../../../../core/utils/extensions/context_extension.dart';
import '../../../../../../../core/utils/styles/dimensions/ui_dimensions.dart';
import '../../../../../../../domain/enums/category.dart';
import '../../../../../../../domain/usecases/storage/category/category_usecases.dart';
import '../../../../../../providers/home/home_provider.dart';
import '../home_screen.dart';

class CategorySelectionContainer extends ConsumerStatefulWidget {
  const CategorySelectionContainer({super.key});

  @override
  ConsumerState<CategorySelectionContainer> createState() =>
      _CategorySelectionContainerState();
}

class _CategorySelectionContainerState
    extends ConsumerState<CategorySelectionContainer> {
  late final WriteCategory _writeCategory =
      ref.watch(writeCategoryUseCaseProvider);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: ref.watch(categorySelectionNotifierProvider),
      child: SizedBox(
        width: context.screenWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: UIDimensions.onlyPaddingInsets(top: 16),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ref.watch(selectedCategoryNotifierProvider) ==
                            CategoryType.cpl
                        ? context.customColors.white10Color
                        : null),
                child: ListTile(
                  onTap: () async {
                    ref
                        .read(selectedCategoryNotifierProvider.notifier)
                        .updateTo(CategoryType.cpl);
                    ref
                        .read(categorySelectionNotifierProvider.notifier)
                        .updateTo();
                    switchCategory(ref);
                    await _writeCategory(CategoryType.cpl.name);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  leading: SizedBox(
                    child: Assets.images.logo.image(height: 36),
                  ),
                ),
              ),
            ),
            Padding(
              padding: UIDimensions.symmetricPaddingInsets(vertical: 16),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ref.watch(selectedCategoryNotifierProvider) ==
                            CategoryType.wcpl
                        ? context.customColors.white10Color
                        : null),
                child: ListTile(
                  onTap: () async {
                    ref
                        .read(selectedCategoryNotifierProvider.notifier)
                        .updateTo(CategoryType.wcpl);
                    ref
                        .read(categorySelectionNotifierProvider.notifier)
                        .updateTo();
                    switchCategory(ref);
                    await _writeCategory(CategoryType.wcpl.name);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  leading: SizedBox(
                    child: Assets.images.wcpl.image(height: 36),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
