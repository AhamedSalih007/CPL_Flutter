import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/assets_gen/assets.gen.dart';
import '../../../core/utils/extensions/context_extension.dart';
import '../sliver_tab_bar_delegate.dart';

class CommonSliverBody extends ConsumerWidget {
  final Widget? child;
  final TabController tabController;
  final List<Widget> tabs;
  final List<Widget> tabViewChildren;
  const CommonSliverBody(
      {super.key,
      this.child,
      required this.tabController,
      required this.tabViewChildren,
      required this.tabs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollCtrl = ScrollController();
    return CustomScrollView(controller: scrollCtrl, slivers: <Widget>[
      child ??
          const SliverToBoxAdapter(
            child: SizedBox(),
          ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverTabBarViewDelegate(
          child: ColoredBox(
              color: context.colorScheme.primaryContainer,
              child: Column(
                children: [
                  Assets.images.logo.image(
                      width: context.screenWidth,
                      height: context.screenHeight * 0.3),
                  TabBar(
                    isScrollable: true,
                    dividerHeight: 0,
                    tabAlignment: TabAlignment.start,
                    labelColor: context.colorScheme.secondary,
                    unselectedLabelColor:
                        context.colorScheme.onTertiaryContainer,
                    tabs: tabs,
                    controller: tabController,
                  ),
                ],
              )),
        ),
      ),
      SliverFillRemaining(
        hasScrollBody: true,
        child: ColoredBox(
          color: context.colorScheme.primary,
          child: TabBarView(
            controller: tabController,
            children: tabViewChildren,
          ),
        ),
      ),
    ]);
  }
}
