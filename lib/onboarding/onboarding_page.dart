import 'package:flutter/material.dart';

/// A widget that displays a single page of an onboarding process.
///
/// This widget is designed to showcase an image along with optional
/// overlay content provided by the [child] widget. The image can be customized
/// in size through [imageWidth] and [imageHeight], and the whole page
/// can be padded using [padding]. For a full-size image that covers the
/// entire widget area without specific width or height, use the [OnboardingPage.fullSize]
/// constructor.
///
/// [OnboardingPage.fullSize] constructor creates an instance with the image
/// occupying the full available space, disregarding [imageWidth] and [imageHeight].
///
/// Example Usage:
/// ```dart
/// OnboardingPage(
///   imageProvider: AssetImage('path/to/your/image.png'),
///   child: Text('Welcome to our app!'),
///   padding: EdgeInsets.all(20),
/// )
/// ```
///
/// Or for a full-size image:
/// ```dart
/// OnboardingPage.fullSize(
///   imageProvider: AssetImage('path/to/your/image.png'),
///   child: Text('Dive right in!'),
/// )
/// ```
class OnboardingPage extends StatelessWidget {
  /// The width of the image displayed within the onboarding page. If null, the image
  /// will occupy the full available width.
  final double? imageWidth;

  /// The height of the image displayed within the onboarding page. If null, the image
  /// will occupy the full available height.
  final double? imageHeight;

  /// The widget to display over the image. Typically used for onboarding text content or buttons.
  final Widget child;

  /// The [ImageProvider] for the image to display in the background.
  final ImageProvider imageProvider;

  /// Optional padding for the onboarding page. Defaults to symmetric horizontal padding of 20.
  final EdgeInsets? padding;

  const OnboardingPage(
      {super.key,
      required this.child,
      required this.imageProvider,
      this.imageWidth = 300,
      this.imageHeight = 300,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: Image(
              image: imageProvider,
              fit: BoxFit.cover,
              width: double.maxFinite,
              height: double.maxFinite,
            ),
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(8),
              ),
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.45),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 20,
                  right: 20,
                ),
                child: child),
          )
        ],
      ),
    );
  }
}
