import 'package:flutter/material.dart';

/// A typedef for a function that builds a custom SkipButton widget.
///
/// This builder is provided with a [BuildContext] and a [SkipButton] instance,
/// allowing for flexible customization of the skip button within different contexts.
///
/// Parameters:
/// - `context`: The [BuildContext] in which the skip button is being built.
/// - `skipButton`: The [SkipButton] instance that provides properties for the skip button.
typedef SkipButtonBuilder = Widget Function(
    BuildContext context, SkipButton skipButton);

/// A widget that represents a skip button typically used in onboarding screens or similar contexts.
///
/// This button allows users to skip a certain flow or task. The behavior when the skip button is pressed
/// can be customized via the `onSkip` callback.
///
/// Parameters:
/// - `onSkip`: A callback function that is called when the skip button is pressed. It allows for custom behavior
///   to be executed upon button press, such as navigating to a different screen or cancelling an operation.
/// - `skipText`: The text to be displayed on the skip button. This should be descriptive enough to indicate
///   to users that pressing the button will skip the current task or flow.
/// - `skipTextColor`: The color of the text displayed on the skip button. This can be used to match the skip button's
///   appearance with the overall theme or design of the screen it is part of.
///
/// Example Usage:
/// ```dart
/// SkipButton(
///   onSkip: () {
///     // Define what happens when the skip button is pressed
///   },
///   skipText: 'Skip',
///   skipTextColor: Colors.blue,
/// )
/// ```
class SkipButton extends StatelessWidget {
  /// - `onSkip`: Callback function that is called when the skip button is pressed.
  final Function()? onSkip;

  /// - `skipText`: Text to display on the skip button.
  final String? skipText;

  /// - `skipTextStyle`: Style of the text displayed on the skip button.
  final TextStyle? skipTextStyle;

  const SkipButton(
      {super.key, this.onSkip, this.skipText, required this.skipTextStyle});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        onSkip?.call();
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        minimumSize: const Size(0, 36),
        backgroundColor: Colors.transparent,
        side: const BorderSide(color: Colors.transparent),
      ),
      child: Text(
        skipText ?? 'Skip',
        style: skipTextStyle ??
            Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.blue,
                  fontWeight: FontWeight.w400,
                ),
      ),
    );
  }
}
