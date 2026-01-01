import 'package:flutter/material.dart';
import 'package:flutter_extended/extensions/ext_context.dart';
import 'package:flutter_extended/extensions/ext_falsy.dart';
import 'package:flutter_extended/extensions/ext_widget.dart';
import 'package:flutter_extended/utils/color.dart';

/// A customizable AlertDialog with optional title, message, and action buttons.
/// Supports styling and centering text, as well as custom colors for confirm/cancel buttons.
class ExtendedAlertDialog extends StatelessWidget {
  const ExtendedAlertDialog({
    super.key,
    this.title,
    required this.message,
    this.confirmText,
    this.cancelText,
    this.onConfirm,
    this.onCancel,
    this.center,
    this.confirmColor,
    this.cancelColor,
    this.titleStyle,
    this.messageStyle,
    this.confirmStyle,
    this.cancelStyle,
  });

  /// Optional title of the dialog.
  final String? title;

  /// The main message body of the dialog.
  final String message;

  /// Text for the confirm button (default: "Confirm").
  final String? confirmText;

  /// Text for the cancel button (default: "Cancel").
  final String? cancelText;

  /// Callback executed when the confirm button is tapped.
  final VoidCallback? onConfirm;

  /// Callback executed when the cancel button is tapped.
  final VoidCallback? onCancel;

  /// If true, text content and title are centered.
  final bool? center;

  /// Color of the confirm button.
  final Color? confirmColor;

  /// Color of the cancel button.
  final Color? cancelColor;

  /// Optional style for the title text.
  final TextStyle? titleStyle;

  /// Optional style for the message text.
  final TextStyle? messageStyle;

  /// Optional style for the confirm button text.
  final TextStyle? confirmStyle;

  /// Optional style for the cancel button text.
  final TextStyle? cancelStyle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title:
          title == null
              ? null
              : Text(
                title!,
                textAlign: TextAlign.center.onlyIf(center),
              ).styled(TS.bold.size(18).merge(titleStyle)),
      content: Text(
        message,
        textAlign: TextAlign.center.onlyIf(center),
      ).styled(TS.size(14).merge(messageStyle)),
      actionsPadding: EdgeInsets.all(0),
      actions: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Cancel button (if provided)
              if (onCancel != null) ...[
                action(
                  cancelText ?? 'Cancel',
                  color: cancelColor ?? red,
                  onTap: onCancel,
                  style: cancelStyle,
                ),
                Container(color: Colors.grey.shade100, width: 1),
              ],
              // Confirm button
              action(
                confirmText ?? 'Confirm',
                color: confirmColor ?? blue,
                onTap: onConfirm,
                style: confirmStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Builds a single action button (confirm or cancel) with optional [style], [color], and [onTap] callback.
  Expanded action(
    String text, {
    BuildContext? context,
    TextStyle? style,
    Color? color,
    void Function()? onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          // Close the dialog first
          context?.back();
          onTap?.call();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 14,
          ).copyWith(bottom: 16),
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey.shade100)),
          ),
          child: Center(
            child: Text(
              text,
            ).styled(TS.col(color ?? black).size(15).w600.hgt(1).merge(style)),
          ),
        ),
      ),
    );
  }
}
