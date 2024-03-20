import 'package:flutter/material.dart';
import 'package:onboarding_flow/onboarding/onboarding.dart';
import 'package:onboarding_flow/onboarding/onboarding_page.dart';

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
        continueText: 'Continue',
        finishText: 'Finish',
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

  _partizan(BuildContext context) {
    return Onboarding(
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
      continueText: 'Nastavi',
      continueBorderColor: Colors.white,
      continueBackgroundColor: Colors.transparent,
      continueTextStyle: const TextStyle(color: Colors.white),
      buttonBorderRadius: 24,
      finishText: 'Zavrsi',
      finishBorderColor: Colors.white,
      finishBackgroundColor: Colors.white,
      finishTextStyle: const TextStyle(color: Colors.black),
      children: [
        OnboardingPage(
            title: Text(
              'Rezultati i utakmice',
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            description: Text(
              'Budite u toku sa trenutnim rezultatima i predstojećim utakmicama',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            imageProvider: AssetImage('assets/background/news_background.jpg')),
        OnboardingPage(
            child: Column(
              children: [
                Text(
                  'Najnovije vesti',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Budite u toku sa trenutnim rezultatima i predstojećim utakmicama',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            imageProvider: AssetImage('assets/background/main_background.jpg')),
        OnboardingPage(
            child: Column(
              children: [
                Text(
                  'Gledajte Partizan na YouTube-u',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  'Istražite sve Partizan tematske video sadržaje i prenose uživo sa raznih YouTube kanala',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            imageProvider: AssetImage('assets/background/fk_background.jpg'))
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
                          builder: (context) => _partizan(context)),
                    );
                  },
                  child: const Text('Custom'))
            ],
          ),
        ));
  }
}
