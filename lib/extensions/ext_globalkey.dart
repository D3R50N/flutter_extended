import 'package:flutter/material.dart';

extension ExtGlobalkey on GlobalKey {
  /// Returns the underlying [RenderBox] associated with this [GlobalKey].
  ///
  /// Assumes that the widget is mounted and has a render object.
  RenderBox get box => currentContext!.findRenderObject() as RenderBox;

  /// Returns the size of the widget associated with this [GlobalKey].
  Size get size => box.size;

  /// Height of the widget in logical pixels.
  double get h => size.height;

  /// Width of the widget in logical pixels.
  double get w => size.width;

  /// Converts a local [offset] to a global screen position.
  Offset globalOffsetTo(Offset offset) => box.localToGlobal(offset);

  /// Converts a global [offset] to a local widget position.
  Offset localOffsetTo(Offset offset) => box.globalToLocal(offset);

  /// Global position of the widget's top-left corner.
  Offset get globalOffset => globalOffsetTo(Offset.zero);

  /// Global X position of the widget.
  double get globalX => globalOffset.dx;

  /// Global Y position of the widget.
  double get globalY => globalOffset.dy;

  /// Local position (relative to itself), usually `Offset.zero`.
  Offset get localOffset => localOffsetTo(Offset.zero);

  /// Local X position.
  double get localX => localOffset.dx;

  /// Local Y position.
  double get localY => localOffset.dy;

  /// Checks if the widget associated with this [GlobalKey] is currently mounted in the widget tree.
  bool get isMounted => currentContext?.mounted == true;
}
