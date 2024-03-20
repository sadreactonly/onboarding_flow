import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding_flow/onboarding/widgets/app_bar.dart';
import 'package:onboarding_flow/onboarding/widgets/skip_button.dart';

import 'widgets/indicator.dart';

/// A customizable onboarding widget for Flutter applications.
///
/// This widget provides a flexible framework for building onboarding screens
/// with customizable text styles, background colors, buttons, and more. It supports
/// custom navigation logic including page changes, completion actions, and skip functionality.
///
/// Parameters:
/// - `animationDuration`: Duration of the animation between onboarding pages.
/// - `appBarTextStyle`: TextStyle for the text displayed in the AppBar. Cannot be used with `appBarBuilder`.
/// - `backgroundColor`: Background color of the onboarding screens.
/// - `children`: A list of widgets that represent each page of the onboarding content.
/// - `onFinished`: Callback function that is called when the onboarding process is completed.
/// - `onPageChange`: Callback function that is called when a new page is displayed.
/// - `onSkip`: Callback function that is called when the skip button is pressed.
/// - `onBack`: Callback function that is called when the back navigation is triggered.
/// - `skipText`: Text to display on the skip button. Cannot be used with `skipButtonBuilder`.
/// - `skipTextStyle`: TextStyle for the text displayed on the skip button.
/// - `skipButtonBuilder`: Custom builder for the skip button. Overrides `skipText` and `skipTextStyle`.
/// - `indicatorBuilder`: Custom builder for the page indicator.
/// - `appBarBuilder`: Custom builder for the AppBar. Overrides `appBarTextStyle`.
/// - `continueText`: Text for the continue button.
/// - `finishText`: Text for the finish button.
/// - `continueTextStyle`: TextStyle for the continue button text.
/// - `finishTextStyle`: TextStyle for the finish button text.
/// - `continueBackgroundColor`: Background color of the continue button.
/// - `finishBackgroundColor`: Background color of the finish button.
/// - `continueBorderColor`: Border color of the continue button.
/// - `finishBorderColor`: Border color of the finish button.
/// - `buttonBorderRadius`: Border radius of the continue and finish buttons.
///
/// Example Usage:
/// ```dart
/// Onboarding(
///   animationDuration: Duration(seconds: 1),
///   backgroundColor: Colors.white,
///   children: [
///     Text('Welcome to our App'),
///     Text('Learn to navigate'),
///     Text('Enjoy our features'),
///   ],
///   onFinished: () => print('Onboarding Finished'),
///   continueText: 'Next',
///   finishText: 'Get Started',
/// )
/// ```
///
/// Note: Ensure to not use `appBarTextStyle` and `appBarBuilder` at the same time. The same applies to `skipText` and `skipButtonBuilder`.

class Onboarding extends StatefulWidget {
  /// Duration for the transition animation between onboarding pages.
  final Duration animationDuration;

  /// Optional text style for the AppBar's title. Not used if `appBarBuilder` is provided.
  final TextStyle? appBarTextStyle;

  /// Background color for the onboarding screen.
  final Color backgroundColor;

  /// Widgets to display on each onboarding page.
  final List<Widget> children;

  /// Callback triggered when the onboarding process completes.
  final Function()? onFinished;

  /// Callback for handling page changes, provides the index of the new page.
  final Function(int index)? onPageChange;

  /// Callback triggered when the user decides to skip the onboarding.
  final Function()? onSkip;

  /// Callback triggered when the user navigates back from the onboarding.
  final Function()? onBack;

  /// Text to display on the skip button. Not used if `skipButtonBuilder` is provided.
  final String? skipText;

  /// Text style for the skip button's text.
  final TextStyle? skipTextStyle;

  /// Custom builder for creating a skip button. Overrides `skipText` and `skipTextStyle`.
  final SkipButtonBuilder? skipButtonBuilder;

  /// Custom builder for creating page indicators.
  final IndicatorBuilder? indicatorBuilder;

  /// Custom builder for creating the AppBar. Overrides `appBarTextStyle`.
  final AppBarBuilder? appBarBuilder;

  /// Text for the 'Continue' navigation button.
  final String continueText;

  /// Text for the 'Finish' navigation button.
  final String finishText;

  /// Text style for the 'Continue' button's text.
  final TextStyle? continueTextStyle;

  /// Text style for the 'Finish' button's text.
  final TextStyle? finishTextStyle;

  /// Background color of the 'Continue' button.
  final Color? continueBackgroundColor;

  /// Background color of the 'Finish' button.
  final Color? finishBackgroundColor;

  /// Border color of the 'Continue' button.
  final Color? continueBorderColor;

  /// Border color of the 'Finish' button.
  final Color? finishBorderColor;

  /// Border radius for the 'Continue' and 'Finish' buttons.
  final double? buttonBorderRadius;

  /// Constructs an [Onboarding] widget with customizable onboarding experience.
  ///
  /// Asserts that not both `appBarBuilder` and `appBarTextStyle`, `skipButtonBuilder` and `skipText`,
  /// and not both `appBarBuilder` and `skipButtonBuilder` are used simultaneously.
  const Onboarding({
    super.key,
    this.appBarTextStyle,
    required this.backgroundColor,
    required this.children,
    required this.animationDuration,
    this.onFinished,
    this.onPageChange,
    this.onSkip,
    this.onBack,
    this.skipText,
    this.skipTextStyle,
    this.indicatorBuilder,
    this.skipButtonBuilder,
    this.appBarBuilder,
    required this.continueText,
    required this.finishText,
    this.continueTextStyle,
    this.finishTextStyle,
    this.continueBackgroundColor = Colors.blue,
    this.finishBackgroundColor = Colors.blue,
    this.continueBorderColor = Colors.blue,
    this.finishBorderColor = Colors.blue,
    this.buttonBorderRadius = 16,
  })  : assert(!(appBarBuilder != null && appBarTextStyle != null),
            '\n\nEither use appBarBuilder or appBarTextStyle, but not both.\n\n'),
        assert(!(skipButtonBuilder != null && skipText != null),
            '\n\nEither use skipButtonBuilder or appBarTextStyle, but not both.\n\n'),
        assert(!(appBarBuilder != null && skipButtonBuilder != null),
            '\n\nIf you are using appBarBuilder, skipButtonBuilder will not be used. Please provide skip button in appBarBuilder.\n\n');

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _controller = PageController();
  int _currentIndex = 1;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        _currentIndex = _controller.page!.toInt() + 1;
      });

      widget.onPageChange?.call(_controller.page!.toInt());
    });
  }

  SkipButton _defaultSkipButton() {
    return SkipButton(
      skipText: widget.skipText,
      skipTextStyle: widget.skipTextStyle,
      onSkip: widget.onSkip,
    );
  }

  OnboardingAppBar _defaultAppBar() {
    return OnboardingAppBar(
      animationDuration: widget.animationDuration,
      index: _currentIndex,
      backgroundColor: widget.backgroundColor,
      controller: _controller,
      onBack: () {
        _controller.previousPage(
          duration: widget.animationDuration,
          curve: Curves.easeOutCubic,
        );
      },
      itemsCount: widget.children.length,
      skipButton: widget.skipButtonBuilder != null
          ? widget.skipButtonBuilder!(context, _defaultSkipButton())
          : _defaultSkipButton(),
      appBarTextStyle: widget.appBarTextStyle,
    );
  }

  Indicator _defaultIndicator() {
    return Indicator(
      itemCount: widget.children.length,
      selectedItem: _currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        appBar: widget.appBarBuilder != null
            ? widget.appBarBuilder!(
                context, _currentIndex, widget.children.length, _controller)
            : _defaultAppBar(),
        backgroundColor: widget.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              Expanded(
                flex: 88,
                child: PageView(
                  controller: _controller,
                  children: widget.children,
                ),
              ),
              const Spacer(flex: 5),
              _OnboardingButton(
                onSkip: () {
                  _controller.nextPage(
                    duration: widget.animationDuration,
                    curve: Curves.easeOutCubic,
                  );
                },
                onFinished: () {
                  widget.onFinished?.call();
                },
                animationDuration: widget.animationDuration,
                isFinished: _currentIndex == widget.children.length,
                continueText: widget.continueText,
                finishText: widget.finishText,
                continueTextStyle: widget.continueTextStyle,
                continueBackgroundColor: widget.continueBackgroundColor,
                finishBackgroundColor: widget.finishBackgroundColor,
                borderRadius: widget.buttonBorderRadius!,
              ),
              const Spacer(flex: 5),
              widget.indicatorBuilder == null
                  ? _defaultIndicator()
                  : widget.indicatorBuilder!(
                      context,
                      _defaultIndicator().selectedItem,
                      _defaultIndicator().itemCount),
              if (MediaQuery.of(context).padding.bottom == 0)
                const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingButton extends StatelessWidget {
  final Duration animationDuration;
  final String continueText;
  final String finishText;
  final TextStyle? continueTextStyle;
  final TextStyle? finishTextStyle;
  final Color? continueBackgroundColor;
  final Color? finishBackgroundColor;
  final Color? continueBorderColor;
  final Color? finishBorderColor;
  final double borderRadius;
  final bool isFinished;
  final Function()? onFinished;
  final Function()? onSkip;

  const _OnboardingButton({
    required this.animationDuration,
    this.onFinished,
    required this.isFinished,
    this.onSkip,
    required this.continueText,
    required this.finishText,
    this.continueTextStyle,
    this.finishTextStyle,
    required this.borderRadius,
    this.continueBackgroundColor,
    this.finishBackgroundColor,
    this.continueBorderColor,
    this.finishBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxHeight: 40,
          minWidth: double.infinity,
        ),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.zero,
            side: BorderSide(
              width: 1.0,
              color: isFinished ? Colors.black : const Color(0xFFb9b8b3),
            ),
            foregroundColor:
                isFinished ? continueBorderColor : finishBorderColor,
            backgroundColor:
                isFinished ? finishBackgroundColor : continueBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: () {
            isFinished ? onFinished?.call() : onSkip?.call();
          },
          child: Text(
            isFinished ? finishText : continueText,
            style: isFinished ? finishTextStyle : continueTextStyle,
          ),
        ),
      ),
    );
  }
}
