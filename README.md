# Onboarding Plus

A comprehensive and customizable Flutter package designed to simplify the creation of onboarding experiences in your Flutter applications. With this package, you can easily set up onboarding screens with beautiful images, customizable text, and navigation buttons.

## Features

- **Customizable Onboarding Pages**: Design your onboarding flow with full control over the content, including images, text, and buttons.
- **Flexible Layout Options**: Choose between full-size images or fixed dimensions to fit your design needs.
- **Easy Navigation**: Integrated page controller for smooth navigation between onboarding screens.
- **Custom AppBar**: Includes an AppBar with customizable text style, background color, and navigation options.
- **Custom Skip Button**: A customizable skip button allowing users to bypass the onboarding process.

## Getting Started

To use the  onboarding_plus package in your project, follow these steps:

### Installation

Add the package to your `pubspec.yaml` file:

```yaml
dependencies:
  onboarding_plus: ^0.0.1
```
## Usage
- **Default**

```dart
OnboardPage(
   animationDuration: Duration(milliseconds: 300),
   backgroundColor: Colors.white,
   children: [OnboardingPage(...), OnboardingPage(...), OnboardingPage(...)],
   onFinished: () {
     print("Finished Onboarding");
   },
)
```

- **Custom layout**

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