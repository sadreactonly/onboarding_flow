import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onboarding_flow/onboarding/widgets/app_bar.dart';
import 'package:onboarding_flow/onboarding/widgets/skip_button.dart';

import 'button_params.dart';
import 'widgets/indicator.dart';

/// `OnboardPage` is a StatefulWidget that provides a customizable onboarding experience.
/// It allows developers to specify the content of each onboarding page, customize the appearance and behavior
/// of navigation buttons and page indicators, and handle actions such as page changes, completion, and skipping the onboarding.
///
/// Parameters:
/// - `animationDuration`: The duration of the animation between onboarding pages.
/// - `appBarTextStyle`: TextStyle for the text displayed in the AppBar, like the current page number.
/// - `backgroundColor`: Background color of the onboarding screens.
/// - `buttonParams`: Parameters to customize the appearance of the continue and finish buttons.
/// - `children`: A list of widgets that represent each page of the onboarding content.
/// - `onFinished`: Callback function that is called when the onboarding process is completed.
/// - `onPageChange`: Callback function that is called when a new page is displayed to the user.
/// - `onSkip`: Callback function that is called when the skip button is pressed.
/// - `skipText`: Text to display on the skip button.
/// - `skipTextColor`: Color of the text displayed on the skip button.
///
/// Example Usage:
/// ```dart
/// OnboardPage(
///   animationDuration: Duration(milliseconds: 300),
///   backgroundColor: Colors.white,
///   children: [OnboardingPage(...), OnboardingPage(...), OnboardingPage(...)],
///   onFinished: () {
///     print("Finished Onboarding");
///   },
/// )
/// ```
///
class Onboarding extends StatefulWidget {
  /// - `animationDuration`: The duration of the animation between onboarding pages.
  final Duration animationDuration;

  /// - `appBarTextStyle`: TextStyle for the text displayed in the AppBar, like the current page number.
  final TextStyle? appBarTextStyle;

  /// - `backgroundColor`: Background color of the onboarding screens.
  final Color backgroundColor;

  /// - `buttonParams`: Parameters to customize the appearance of the continue and finish buttons.
  final ButtonParams? buttonParams;

  /// - `children`: A list of widgets that represent each page of the onboarding content.
  final List<Widget> children;

  /// - `onFinished`: Callback function that is called when the onboarding process is completed.
  final Function()? onFinished;

  /// - `onPageChange`: Callback function that is called when a new page is displayed to the user.
  final Function(int index)? onPageChange;

  /// - `onSkip`: Callback function that is called when the skip button is pressed.
  final Function()? onSkip;

  /// - `onBack`: Callback function that is called when the skip button is pressed.
  final Function()? onBack;

  /// - `skipText`: Text to display on the skip button.
  final String? skipText;

  /// - `skipTextStyle`: TextStyle of the text displayed on the skip button.
  final TextStyle? skipTextStyle;

  /// Defines a function type for building [SkipButtonBuilder] widget.
  ///
  ///
  /// Parameters:
  /// - `context`: The build context.
  /// - `SkipButtonBuilder`: [SkipButton] item.
  ///
  final SkipButtonBuilder? skipButtonBuilder;

  /// Defines a function type for building [Indicator] widget.
  ///
  ///
  /// Parameters:
  /// - `context`: The build context.
  /// - `selectedItem`: The index of the currently selected item.
  /// - `itemsCount`: The total number of items.
  ///
  final IndicatorBuilder? indicatorBuilder;

  /// Defines a function type for building [AppBar] widget.
  ///
  ///
  /// Parameters:
  /// - `context`: The build context.
  /// - `selectedItem`: The index of the currently selected item.
  /// - `itemsCount`: The total number of items.
  /// - `controller`: The PageController for the associated PageView.
  ///
  final AppBarBuilder? appBarBuilder;

  /// Example Usage:
  /// ```dart
  /// Onboarding(
  ///   animationDuration: Duration(milliseconds: 300),
  ///   backgroundColor: Colors.white,
  ///   children: [
  ///     OnboardingPage(...),
  ///     OnboardingPage(...),
  ///     OnboardingPage(...)
  ///   ],
  ///   onFinished: () {
  ///     print("Finished Onboarding");
  ///   },
  /// )
  /// ```
  ///
  const Onboarding({
    super.key,
    this.appBarTextStyle,
    required this.backgroundColor,
    this.buttonParams,
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
                buttonParams: widget.buttonParams,
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
  final ButtonParams? buttonParams;
  final bool isFinished;
  final Function()? onFinished;
  final Function()? onSkip;

  const _OnboardingButton({
    required this.animationDuration,
    this.onFinished,
    required this.isFinished,
    this.onSkip,
    this.buttonParams,
  });

  @override
  Widget build(BuildContext context) {
    final buttonParams = this.buttonParams ?? const ButtonParams();

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
            foregroundColor: isFinished
                ? buttonParams.continueBackgroundColor.withOpacity(0.6)
                : buttonParams.finishBackgroundColor.withOpacity(0.6),
            backgroundColor: isFinished
                ? buttonParams.finishBackgroundColor
                : buttonParams.continueBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonParams.borderRadius),
            ),
          ),
          onPressed: () {
            isFinished ? onFinished?.call() : onSkip?.call();
          },
          child: Text(
            isFinished ? buttonParams.finishText : buttonParams.continueText,
            style: TextStyle(
                fontSize: 16,
                color: !isFinished
                    ? buttonParams.continueTextColor
                    : buttonParams.finishTextColor),
          ),
        ),
      ),
    );
  }
}
