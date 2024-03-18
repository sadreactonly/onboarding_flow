import 'package:flutter/material.dart';

/// A custom widget that displays a horizontal list of indicators to denote the current position
/// within a series of pages or elements. Typically used in onboarding screens or carousels.
///
/// The `Indicator` widget highlights the current item with a distinct size and color, differentiating
/// it from other items.
///
/// Parameters:
///   - `itemCount`: The total number of indicators to be displayed. This should match the total number of pages or elements.
///   - `selectedItem`: The index of the currently active or selected item. This is zero-based, meaning the first item is represented by 0.
///   - `activeRadius`: The radius of the indicator circle when it is selected or active. Defaults to 4.0.
///   - `inactiveRadius`: The radius of the indicator circle when it is not selected. Defaults to 2.5.
///   - `activeColor`: The color of the active or selected indicator. Defaults to `Colors.black`.
///   - `inactiveColor`: The color of inactive indicators. Defaults to `Colors.grey`.
///   - `spaceBetween`: The horizontal space between each indicator. Defaults to 10.0.
///
/// Usage example:
/// ```dart
/// Indicator(
///   itemCount: 3,
///   selectedItem: 1,
/// )
/// ```
/// This will create a row of three indicators with the second indicator marked as active.
class Indicator extends StatelessWidget {
  ///   - `itemCount`: The total number of indicators to be displayed. This should match the total number of pages or elements.
  final int itemCount;

  ///   - `selectedItem`: The index of the currently active or selected item. This is zero-based, meaning the first item is represented by 0.
  final int selectedItem;

  ///   - `activeRadius`: The radius of the indicator circle when it is selected or active. Defaults to 4.0.
  final double activeRadius;

  ///   - `inactiveRadius`: The radius of the indicator circle when it is not selected. Defaults to 2.5.
  final double inactiveRadius;

  ///   - `activeColor`: The color of the active or selected indicator. Defaults to `Colors.black`.
  final Color activeColor;

  ///   - `inactiveColor`: The color of inactive indicators. Defaults to `Colors.grey`.
  final Color inactiveColor;

  ///   - `spaceBetween`: The horizontal space between each indicator. Defaults to 10.0.
  final double spaceBetween;

  /// Usage example:
  /// ```dart
  /// Indicator(
  ///   itemCount: 3,
  ///   selectedItem: 1,
  /// )
  /// ```
  /// This will create a row of three indicators with the second indicator marked as active.
  const Indicator({
    super.key,
    required this.itemCount,
    required this.selectedItem,
    this.activeRadius = 4,
    this.inactiveRadius = 2.5,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.grey,
    this.spaceBetween = 10,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: activeRadius * 2),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (_, i) {
          final isSelected = selectedItem == i + 1;

          return CircleAvatar(
            maxRadius: isSelected ? activeRadius : inactiveRadius,
            backgroundColor: isSelected ? activeColor : inactiveColor,
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: spaceBetween),
        itemCount: itemCount,
      ),
    );
  }
}

/// Defines a function type for building [Indicator] widget.
///
///
/// Parameters:
/// - `context`: The build context.
/// - `selectedItem`: The index of the currently selected item.
/// - `itemsCount`: The total number of items.
///
typedef IndicatorBuilder = Widget Function(
    BuildContext context, int selectedItem, int itemsCount);
