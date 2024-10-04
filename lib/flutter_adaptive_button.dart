library flutter_adaptive_button;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension AdaptiveFilledButtonExtension on FilledButton {
  Widget adaptive(BuildContext context) {
    final style = defaultStyleOf(context);
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return Theme(
        data: Theme.of(context).copyWith(
          filledButtonTheme:
              FilledButtonThemeData(style: makeStyleMoreiOS(style)),
        ),
        child: this,
      );
    }
    return this;
  }
}

extension AdaptiveOutlinedButtonExtension on OutlinedButton {
  Widget adaptive(BuildContext context) {
    final style = defaultStyleOf(context);
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return Theme(
        data: Theme.of(context).copyWith(
          outlinedButtonTheme:
              OutlinedButtonThemeData(style: makeStyleMoreiOS(style)),
        ),
        child: this,
      );
    }
    return this;
  }
}

extension AdaptiveTextButtonExtension on TextButton {
  Widget adaptive(BuildContext context) {
    final style = defaultStyleOf(context);
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return Theme(
        data: Theme.of(context).copyWith(
          textButtonTheme: TextButtonThemeData(style: makeStyleMoreiOS(style)),
        ),
        child: this,
      );
    }
    return this;
  }
}

extension AdaptiveElevatedButtonExtension on ElevatedButton {
  Widget adaptive(BuildContext context) {
    final style = defaultStyleOf(context);
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return Theme(
        data: Theme.of(context).copyWith(
          elevatedButtonTheme:
              ElevatedButtonThemeData(style: makeStyleMoreiOS(style)),
        ),
        child: this,
      );
    }
    return this;
  }
}

ButtonStyle makeStyleMoreiOS(ButtonStyle style) {
  final currentForegroundColor = style.foregroundColor!.resolve({})!;
  final currentForegroundResolver = style.foregroundColor!.resolve;

  final currentBackgroundColor = style.backgroundColor!.resolve({})!;
  final currentBackgroundResolver = style.backgroundColor!.resolve;

  final newStyle = style.copyWith(
    foregroundColor: WidgetStateColor.resolveWith(
      (states) {
        if (states.contains(WidgetState.pressed)) {
          final currentForegroundColorOpacity = currentForegroundColor.opacity;
          return currentForegroundColor
              .withOpacity(currentForegroundColorOpacity * 0.4);
        }
        return currentForegroundResolver(states) ?? Colors.transparent;
      },
    ),
    backgroundColor: WidgetStateColor.resolveWith(
      (states) {
        if (states.contains(WidgetState.pressed)) {
          final currentBackgroundColorOpacity = currentBackgroundColor.opacity;
          return currentBackgroundColor
              .withOpacity(currentBackgroundColorOpacity * 0.4);
        }
        if (states.contains(WidgetState.disabled)) {
          return CupertinoColors.quaternarySystemFill;
        }
        return currentBackgroundResolver(states) ?? Colors.transparent;
      },
    ),
    side: WidgetStateProperty.resolveWith(
      (states) {
        if (style.side == null) {
          return null;
        }
        if (states.contains(WidgetState.disabled)) {
          return BorderSide.none;
        }

        if (states.contains(WidgetState.pressed)) {
          final currentSide = style.side!.resolve({})!;
          final currentSideColor = currentSide.color;
          final currentSideColorOpacity = currentSideColor.opacity;

          return currentSide.copyWith(
              color:
                  currentSideColor.withOpacity(currentSideColorOpacity * 0.4));
        }
        final currentSideResolver = style.side!.resolve;
        return currentSideResolver(states) ?? BorderSide.none;
      },
    ),
    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
    elevation: const WidgetStatePropertyAll(0),
    splashFactory: NoSplash.splashFactory,
    animationDuration: const Duration(milliseconds: 120),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  );
  return newStyle;
}
