import 'package:flutter/material.dart';
import 'package:flutter_extended/extensions/ext_widget.dart';

/// Creates a [SliverList] with a fixed number of items.
///
/// [count] specifies the total number of items.
/// [builder] is a function that returns a widget for each index.
Widget sliverListView({
  required int count,
  required Widget? Function(BuildContext context, int index) builder,
}) {
  return SliverList(
    delegate: SliverChildBuilderDelegate(builder, childCount: count),
  );
}

/// Creates a [CustomScrollView] from a list of widgets, automatically converting
/// non-sliver widgets into [SliverToBoxAdapter].
///
/// [children] is the list of widgets to display.
/// [controller] optionally controls scrolling.
/// [key] optionally assigns a key to the scroll view.
Widget sliverScrollView({
  required List<Widget> children,
  ScrollController? controller,
  Key? key,
}) {
  return CustomScrollView(
    controller: controller,
    key: key,
    slivers:
        children
            .map(
              (s) =>
                  s is SliverList || s is SliverGrid || s is SliverPadding
                      ? s
                      : s.sliver(), // Wrap non-slivers into SliverToBoxAdapter
            )
            .toList(),
  );
}
