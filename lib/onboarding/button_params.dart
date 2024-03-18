import 'package:flutter/material.dart';

/// Encapsulates styling parameters for custom buttons within a UI component, such as an onboarding screen.
///
/// This class is designed to provide a convenient way to pass around styling information for buttons
/// that represent "Continue" and "Finish" actions. It allows for customization of border colors, background colors,
/// text, text colors, and the border radius for the buttons.
///
/// Parameters:
/// - `continueBorderColor`: The border color of the "Continue" button. Defaults to `Colors.black`.
/// - `continueBackgroundColor`: The background color of the "Continue" button. Defaults to `Colors.white`.
/// - `continueText`: The text to display on the "Continue" button. Defaults to 'Continue'.
/// - `continueTextColor`: The color of the text on the "Continue" button. Defaults to `Colors.black`.
///
/// - `finishBorderColor`: The border color of the "Finish" button. Defaults to `Colors.black`.
/// - `finishBackgroundColor`: The background color of the "Finish" button. Defaults to `Colors.black`.
/// - `finishText`: The text to display on the "Finish" button. Defaults to 'Finish'.
/// - `finishTextColor`: The color of the text on the "Finish" button. Defaults to `Colors.white`.
///
/// - `borderRadius`: The border radius for the buttons. This affects the roundness of the button corners. Defaults to 8.
///
/// Example usage:
/// ```dart
/// ButtonParams(
///   continueBorderColor: Colors.blue,
///   continueBackgroundColor: Colors.lightBlue,
///   continueText: 'Next',
///   continueTextColor: Colors.white,
///   finishBorderColor: Colors.green,
///   finishBackgroundColor: Colors.lightGreen,
///   finishText: 'Done',
///   finishTextColor: Colors.white,
///   borderRadius: 10,
/// )
/// ```
/// This example defines custom colors and text for both "Continue" and "Finish" buttons, along with a custom border radius.

class ButtonParams {
  ///The border color of the "Continue" button. Defaults to `Colors.black`.
  final Color continueBorderColor;

  ///The background color of the "Continue" button. Defaults to `Colors.white`.
  final Color continueBackgroundColor;

  ///The text to display on the "Continue" button. Defaults to 'Continue'.
  final String continueText;

  ///The color of the text on the "Continue" button. Defaults to `Colors.black`.
  final Color continueTextColor;

  ///The border color of the "Finish" button. Defaults to `Colors.black`.
  final Color finishBorderColor;

  ///The background color of the "Finish" button. Defaults to `Colors.black`.
  final Color finishBackgroundColor;

  ///The text to display on the "Finish" button. Defaults to 'Finish'.
  final String finishText;

  ///The color of the text on the "Finish" button. Defaults to `Colors.white`.
  final Color finishTextColor;

  ///The border radius for the buttons. This affects the roundness of the button corners. Defaults to 8.
  final double borderRadius;

  /// Example usage:
  /// ```dart
  /// ButtonParams(
  ///   continueBorderColor: Colors.blue,
  ///   continueBackgroundColor: Colors.lightBlue,
  ///   continueText: 'Next',
  ///   continueTextColor: Colors.white,
  ///   finishBorderColor: Colors.green,
  ///   finishBackgroundColor: Colors.lightGreen,
  ///   finishText: 'Done',
  ///   finishTextColor: Colors.white,
  ///   borderRadius: 10,
  /// )
  /// ```
  /// This example defines custom colors and text for both "Continue" and "Finish" buttons, along with a custom border radius.
  const ButtonParams({
    this.continueBorderColor = Colors.black,
    this.continueBackgroundColor = Colors.white,
    this.finishBorderColor = Colors.black,
    this.finishBackgroundColor = Colors.black,
    this.borderRadius = 8,
    this.continueText = 'Continue',
    this.finishText = 'Finish',
    this.continueTextColor = Colors.black,
    this.finishTextColor = Colors.white,
  });
}
