import 'package:flutter/material.dart';

/// Defines a function type for building [AppBar] widget.
///
///
/// Parameters:
/// - `context`: The build context.
/// - `selectedItem`: The index of the currently selected item.
/// - `itemsCount`: The total number of items.
/// - `controller`: The [PageController] for the associated PageView.
///
typedef AppBarBuilder = AppBar Function(BuildContext context, int selectedItem,
    int itemsCount, PageController controller);

/// A custom [AppBar] widget designed specifically for use in an onboarding flow.
///
/// This [AppBar] widget displays a back button (when not on the first page),
/// the current page number out of the total number of pages, and a skip button
/// (when not on the last page). It's tailored for onboarding screens where users
/// might want to navigate back or skip the onboarding process entirely.
///
/// The appearance of the [AppBar], including its background color and text style,
/// can be customized through the provided parameters.
///
/// Parameters:
/// - `backgroundColor`: The background color of the [AppBar].
/// - `controller`: The [PageController] that controls the page view associated with the onboarding flow.
/// - `index`: The current page index, used to determine if the back button and skip button should be shown.
/// - `itemsCount`: The total number of pages in the onboarding flow, used to display the current position.
/// - `animationDuration`: The duration of the animation when moving to the previous page.
/// - `appBarTextStyle`: Optional text style for the AppBar's title.
/// - `skipButton`: The widget to use as the skip button. It is shown on all pages except the last one.
///
/// Example Usage:
/// ```dart
/// OnboardingAppBar(
///   backgroundColor: Colors.blue,
///   controller: _pageController,
///   index: _currentPageIndex,
///   itemsCount: _totalPages,
///   animationDuration: Duration(milliseconds: 300),
///   appBarTextStyle: TextStyle(color: Colors.white),
///   skipButton: TextButton(
///     onPressed: () {
///       // Skip logic here
///     },
///     child: Text('Skip'),
///   ),
/// )
/// ```
class OnboardingAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// - `backgroundColor`: The background color of the AppBar.
  final Color backgroundColor;

  /// - `controller`: The PageController that controls the page view associated with the onboarding flow.
  final PageController controller;

  /// - `index`: The current page index, used to determine if the back button and skip button should be shown.
  final int index;

  /// - `itemsCount`: The total number of pages in the onboarding flow, used to display the current position.
  final int itemsCount;

  /// - `animationDuration`: The duration of the animation when moving to the previous page.
  final Duration animationDuration;

  ///   appBarTextStyle: TextStyle(color: Colors.white),
  final TextStyle? appBarTextStyle;

  /// - `skipButton`: The widget to use as the skip button.
  final Widget skipButton;

  ///
  final Function()? onBack;

  /// Example Usage:
  /// ```dart
  /// OnboardingAppBar(
  ///   backgroundColor: Colors.blue,
  ///   controller: _pageController,
  ///   index: _currentPageIndex,
  ///   itemsCount: _totalPages,
  ///   animationDuration: Duration(milliseconds: 300),
  ///   appBarTextStyle: TextStyle(color: Colors.white),
  ///   skipButton: TextButton(
  ///     onPressed: () {
  ///       // Skip logic here
  ///     },
  ///     child: Text('Skip'),
  ///   ),
  /// )
  /// ```
  const OnboardingAppBar(
      {super.key,
      required this.backgroundColor,
      required this.controller,
      required this.index,
      required this.animationDuration,
      required this.itemsCount,
      this.appBarTextStyle,
      this.onBack,
      required this.skipButton});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      leadingWidth: 100,
      leading: index == 1
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                onPressed: () {
                  onBack?.call();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            ),
      title: Text('$index/$itemsCount', style: appBarTextStyle),
      actions: [
        Visibility(visible: index != itemsCount, child: skipButton),
      ],
    );
  }
}
