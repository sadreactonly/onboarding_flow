import 'package:flutter/material.dart';
import 'package:onboarding_minimal/onboarding/onboarding.dart';
import 'package:onboarding_minimal/onboarding/onboarding_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  _openDefault(context) {
    return Onboarding(
        animationDuration: const Duration(milliseconds: 300),
        skipText: 'Skip',
        backgroundColor: Colors.white,
        onSkip: () {
          Navigator.pop(context);
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
        ]);
  }

  _openCustom(BuildContext context) {
    return Onboarding(
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
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Onboarding Plus'),
        ),
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _openDefault(context)),
                    );
                  },
                  child: const Text('Default')),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => _openCustom(context)),
                    );
                  },
                  child: const Text('Custom'))
            ],
          ),
        ));
  }
}
