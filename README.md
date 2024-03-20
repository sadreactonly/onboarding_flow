# Onboarding Flow

A comprehensive and customizable Flutter package designed to simplify the creation of onboarding experiences in your Flutter applications. This package allows you to easily set up onboarding screens with beautiful images, customizable text, and intuitive navigation buttons.

## Features

- **Customizable Onboarding Pages**: Gain full control over your onboarding flow with the ability to customize images, text, and buttons.
- **Flexible Layout Options**: Opt for full-size images or specify fixed dimensions to meet your design needs.
- **Seamless Navigation**: Utilize an integrated page controller for smooth transitions between onboarding screens.
- **Customizable AppBar**: Incorporate an AppBar with adjustable text style, background color, and navigation options for a coherent look and feel.
- **Custom Skip Button**: Provide users with the option to bypass the onboarding process via a customizable skip button.
- **Customizable Continue/Finish Button**: Provide users with the option to bypass the onboarding process via a customizable continue/finish button.
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
   Onboarding(
      animationDuration: Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      children: [
         OnboardingPage(
            imageProvider: AssetImage('path/to/your/first/image.png'),
            child: Text('Welcome to our App!'),
         ),
         OnboardingPage(
            imageProvider: AssetImage('path/to/your/second/image.png'),
            child: Text('Discover Features'),
         ),
         OnboardingPage(
            imageProvider: AssetImage('path/to/your/third/image.png'),
            child: Text('Stay Connected'),
         )
      ],
      onSkip():(){
        print("Finished Onboarding");
      }     
      onFinished: () {
         print("Finished Onboarding");
      },
      continueText: 'Next',
      finishText: 'Get Started',
      skipText: 'Skip',
   // Add any additional configurations here
   )

```

### With Custom AppBarBuilder

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




### With Custom IndicatorBuilder

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
   backgroundColor: Colors.black87,
   animationDuration: const Duration(milliseconds: 100),
   onSkip: () {
    Navigator.pop(context);
   },
   onFinished: () async {
      if (context.mounted) {
        Navigator.pop(context);
      }
   },
   appBarBuilder: (context, selected, count, controller) {
      return AppBar(
         backgroundColor: Colors.black87,
         leading: IconButton(
            icon: Icon(
               Icons.arrow_back_ios_outlined,
               color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
         ),
         title: Text('$selected/$count'),
         centerTitle: true,
         actions: [
            TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Skip'),
            )
         ],
      );
   },
   continueText: 'Continue',
   continueBorderColor: Colors.white,
   continueBackgroundColor: Colors.transparent,
   continueTextStyle: const TextStyle(color: Colors.white),
   buttonBorderRadius: 24,
   finishText: 'Finish',
   finishBorderColor: Colors.white,
   finishBackgroundColor: Colors.white,
   finishTextStyle: const TextStyle(color: Colors.black),
   children: [
      OnboardingPage(
         title: Text(
            'Title 1',
            style: TextStyle(color: Colors.white, fontSize: 22),
         ),
         description: Text(
            'Description 1',
            style: TextStyle(color: Colors.white, fontSize: 20),
         ),
         imageProvider: AssetImage('assets/background/news_background.jpg')
      ),
      // Other pages
      //...
   ],
   indicatorBuilder: (context, itemSelected, itemsCount) {
   // Example: Wrap the indicator with additional padding and align it at the bottom center
   return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 28),
      child: ListView.separated(
         scrollDirection: Axis.horizontal,
         shrinkWrap: true,
         itemBuilder: (_, i) {
            final isSelected = itemSelected == i + 1;
            
            return Image.asset(
               'assets/img.png',
               height: isSelected ? 30 : 20,
               width: isSelected ? 30 : 20,
               color: isSelected ? Colors.white : Colors.white24,
            );
         },
         separatorBuilder: (_, __) => const SizedBox(width: 10),
         itemCount: itemsCount,
         ),
      );
   },
);
```