# Onboarding Flow

A comprehensive and customizable Flutter package designed to simplify the creation of onboarding experiences in your Flutter applications. This package allows you to easily set up onboarding screens with beautiful images, customizable text, and intuitive navigation buttons.

## Features

- **Customizable Onboarding Pages**: Gain full control over your onboarding flow with the ability to customize images, text, and buttons.
- **Flexible Layout Options**: Opt for full-size images or specify fixed dimensions to meet your design needs.
- **Seamless Navigation**: Utilize an integrated page controller for smooth transitions between onboarding screens.
- **Customizable AppBar**: Incorporate an AppBar with adjustable text style, background color, and navigation options for a coherent look and feel.
- **Custom Skip Button**: Provide users with the option to bypass the onboarding process via a customizable skip button.

## Getting Started

To incorporate the `onboarding_flow` package into your project, follow the steps below:

### Installation

1. Add the package to your `pubspec.yaml` file:

    ```yaml
    dependencies:
      onboarding_flow: latest
    ```

2. Run `flutter pub get` to install the package.

## Usage

### Default Example

```dart
  OnboardPage(
    animationDuration: Duration(milliseconds: 300),
    backgroundColor: Colors.white,
    children: [
      OnboardingPage(...),
      OnboardingPage(...),
      OnboardingPage(...)
    ],
    onFinished: () => print("Finished Onboarding"),
  )
```
- **Custom layout**

### Custom AppBarBuilder

Customize the AppBar to suit your onboarding theme:

```dart
  appBarBuilder: (context, selectedItem, itemCount, controller) => 
    AppBar(
        title: Text(
          itemCount != selectedItem ? '${itemCount - selectedItem} more left' : '',
            style: TextStyle(color: Colors.green),
        ),
      actions: [
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.skip_next)
        )
      ],
  )
```




### Custom IndicatorBuilder

Customize the Indicator to suit your onboarding theme:
```dart
indicatorBuilder: (context, itemSelected, itemsCount) {
  // Example: Wrap the indicator with additional padding and align it at the bottom center
  return ConstrainedBox(
    constraints: const BoxConstraints(maxHeight: 28),
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (_, i) {
        final isSelected = itemSelected == i + 1;

        return Icon(
          Icons.sports_basketball,
          size: isSelected ? 22 : 14.5,
          color: isSelected ? Colors.green : Colors.red,
        );
      },
      separatorBuilder: (_, __) => const SizedBox(width: 10),
      itemCount: itemsCount,
    ),
  );
},
```
### Full Custom Example

```dart
 Onboarding(
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.white,
        appBarBuilder: (context, itemSelected, itemCount, controller) {
          return AppBar(
            title: Text(
              itemCount != itemSelected
                  ? '${itemCount - itemSelected} more left'
                  : '',
              style: const TextStyle(color: Colors.green),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.skip_next))
            ],
          );
        },
        indicatorBuilder: (context, itemSelected, itemsCount) {
          // Example: Wrap the indicator with additional padding and align it at the bottom center
          return ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 28),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (_, i) {
                final isSelected = itemSelected == i + 1;

                return Icon(
                  Icons.sports_basketball,
                  size: isSelected ? 22 : 14.5,
                  color: isSelected ? Colors.green : Colors.red,
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemCount: itemsCount,
            ),
          );
        },
        children: const [
          OnboardingPage(
            imageProvider: AssetImage('assets/img1.jpeg'),
            child: Column(
              children: [
                Text(
                  'Title 1',
                  style: TextStyle(fontSize: 42, color: Colors.white),
                ),
                Text(
                  'Subtitle 1',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ],
            ),
          ),
          OnboardingPage(
            imageProvider: AssetImage('assets/img2.jpeg'),
            child: Column(
              children: [
                Text(
                  'Title 2',
                  style: TextStyle(fontSize: 42, color: Colors.white),
                ),
                Text(
                  'Subtitle 2',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ],
            ),
          ),
          OnboardingPage(
            imageProvider: AssetImage('assets/img3.jpeg'),
            child: Column(
              children: [
                Text(
                  'Title 3',
                  style: TextStyle(fontSize: 42, color: Colors.white),
                ),
                Text(
                  'Subtitle3',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ],
            ),
          ),
        ])
```