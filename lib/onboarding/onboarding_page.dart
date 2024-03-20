import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  /// The width of the image displayed within the onboarding page. If null, the image
  /// will occupy the full available width.
  final double? imageWidth;

  /// The height of the image displayed within the onboarding page. If null, the image
  /// will occupy the full available height.
  final double? imageHeight;

  /// The widget to display over the image. Typically used for onboarding text content or buttons.
  final Widget? child;

  /// The [ImageProvider] for the image to display in the background.
  final ImageProvider imageProvider;

  /// Optional padding for the onboarding page. Defaults to symmetric horizontal padding of 20.
  final EdgeInsets? padding;

  /// The title widget to display over the image.
  final Widget? title;

  /// The description widget to display over the image.
  final Widget? description;

  const OnboardingPage(
      {super.key,
      this.child,
      this.title,
      this.description,
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
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title ?? const SizedBox.shrink(),
                      description ?? const SizedBox.shrink(),
                      child ?? const SizedBox.shrink()
                    ],
                  )))
        ],
      ),
    );
  }
}
