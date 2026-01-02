import 'package:flutter/material.dart';
import 'package:flutter_extended/widgets/alert_dialog.dart';
import 'package:page_transition/page_transition.dart';

export 'package:page_transition/page_transition.dart';


extension ExtContext on BuildContext {
  /// Shortcut to access [MediaQueryData] from the current context.
  MediaQueryData get media => MediaQuery.of(this);

  /// Screen height in logical pixels.
  double get h => media.size.height;

  /// Screen width in logical pixels.
  double get w => media.size.width;

  /// Shortcut to access the nearest [NavigatorState].
  NavigatorState get navigator => Navigator.of(this);

  /// Shortcut to access the current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Pushes a new page onto the navigation stack.
  ///
  /// If [safe] is enabled, the navigation will be skipped when the
  /// current route name matches the destination page type.
  ///
  /// Uses [PageTransition] for animated navigation.
  Future<T?> goTo<T>(
    Widget page, {
    bool safe = true,
    PageTransitionType? type,
  }) async {
    final currentRoute = ModalRoute.settingsOf(this)?.name;
    final newRoute = page.runtimeType.toString();

    if (safe && currentRoute == newRoute) return null;

    return navigator.push<T>(
      PageTransition(
        type: type ?? PageTransitionType.rightToLeft,
        child: page,
        settings: RouteSettings(name: newRoute),
      ),
    );
  }

  /// Pushes a new page and removes all previous routes.
  ///
  /// Useful for authentication flows or resetting navigation state.
  Future<T?> allTo<T>(Widget page, {PageTransitionType? type}) {
    final newRoute = page.runtimeType.toString();

    return navigator.pushAndRemoveUntil<T>(
      PageTransition(
        type: type ?? PageTransitionType.fade,
        child: page,
        settings: RouteSettings(name: newRoute),
      ),
      (route) => false,
    );
  }

  /// Replaces the current route with a new page.
  ///
  /// If [safe] is enabled, the replacement is skipped when
  /// navigating to the same route.
  Future<T?> replaceTo<T, TO>(
    Widget page, {
    bool safe = false,
    PageTransitionType? type,
  }) async {
    final currentRoute = ModalRoute.settingsOf(this)?.name;
    final newRoute = page.runtimeType.toString();

    if (safe && currentRoute == newRoute) return null;

    return navigator.pushReplacement<T, TO>(
      PageTransition(
        type: type ?? PageTransitionType.fade,
        child: page,
        settings: RouteSettings(name: newRoute),
      ),
    );
  }

  /// Pops routes until the given [page] route name is reached.
  Future backTo(Widget page) async {
    final newRoute = page.runtimeType.toString();
    navigator.popUntil((route) => route.settings.name == newRoute);
  }

  /// Pops the current route if possible.
  ///
  /// Optionally returns a [result] to the previous route.
  Future<void> back<T>([T? result]) async {
    if (navigator.canPop()) navigator.pop<T>(result);
  }

  /// Displays an error snack bar from an exception.
  ///
  /// The exception prefix (`Exception:`) is automatically removed.
  void snackException(
    dynamic e, {
    bool clearAll = true,
    int ms = 2000,
    String? actionText,
    VoidCallback? onAction,
    bool zeroMargin = true,
    Color? textColor,
  }) {
    snack(
      e.toString().replaceFirst("Exception:", "").trim(),
      success: false,
      clearAll: clearAll,
      ms: ms,
      actionText: actionText,
      onAction: onAction,
      zeroMargin: zeroMargin,
      textColor: textColor,
    );
  }

  /// Displays a snack bar with an almost infinite duration.
  ///
  /// Useful for loading states or persistent notifications.
  void snackInfinite(
    String message, {
    bool success = true,
    bool clearAll = true,
    String? actionText,
    VoidCallback? onAction,
    bool zeroMargin = true,
    Color? textColor,
  }) {
    snack(
      message,
      success: success,
      clearAll: clearAll,
      actionText: actionText,
      onAction: onAction,
      zeroMargin: zeroMargin,
      textColor: textColor,
      ms: 9999999,
    );
  }

  /// Displays a customizable [SnackBar].
  ///
  /// Supports optional action, styles, auto-clear, and margin control.
  void snack(
    String message, {
    bool success = true,
    bool clearAll = true,
    int ms = 2000,
    String? actionText,
    TextStyle? messageStyle,
    TextStyle? actionStyle,
    VoidCallback? onAction,
    bool zeroMargin = true,
    Color? textColor,
  }) {
    if (!mounted) return;

    if (clearAll) {
      ScaffoldMessenger.of(this).clearSnackBars();
    }

    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: Duration(milliseconds: ms),
        margin:
            zeroMargin
                ? const EdgeInsets.symmetric(horizontal: 0, vertical: 0)
                : null,
        content: Row(
          children: [
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor ?? Colors.black,
                ).merge(messageStyle),
              ),
            ),
            if (actionText != null)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(this).clearSnackBars();
                    onAction?.call();
                  },
                  child: Text(
                    actionText,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ).merge(actionStyle),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Validates multiple boolean [conditions].
  ///
  /// Displays the first matching error message using a snack bar
  /// and stops validation immediately.
  bool validateWithSnack(List<bool> conditions, List<String> errors) {
    for (var i = 0; i < conditions.length; i++) {
      if (!conditions[i]) {
        final error = errors.length > i ? errors[i] : errors.first;
        snack(error, success: false);
        return false;
      }
    }
    return true;
  }

  /// Displays a customizable popup dialog.
  ///
  /// Returns a value when the dialog is dismissed.
  Future<T?> showPopUp<T>({
    String? title,
    required String message,
    String? confirmText,
    String? cancelText,
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    bool? dismissible,
    bool? center,
    Color? confirmColor,
    Color? cancelColor,
    TextStyle? titleStyle,
    TextStyle? messageStyle,
    TextStyle? confirmStyle,
    TextStyle? cancelStyle,
  }) {
    return showDialog<T>(
      context: this,
      barrierDismissible: dismissible ?? true,
      builder: (context) {
        return PopScope(
          canPop: dismissible ?? true,
          child: ExtendedAlertDialog(
            title: title,
            center: center,
            message: message,
            confirmText: confirmText,
            cancelText: cancelText,
            onConfirm: onConfirm,
            onCancel: onCancel,
            confirmColor: confirmColor,
            cancelColor: cancelColor,
            titleStyle: titleStyle,
            messageStyle: messageStyle,
            confirmStyle: confirmStyle,
            cancelStyle: cancelStyle,
          ),
        );
      },
    );
  }

  /// Returns `true` if this route is the current active route.
  bool get isCurrent => ModalRoute.of(this)?.isCurrent ?? false;
}
