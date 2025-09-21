import 'dart:io';
import 'package:flutter/cupertino.dart';

class NewFlight extends StatelessWidget {
  const NewFlight({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            exit(0);
          },
          child: const Text('Close'),
        ),
      ),
      child: Stack(
        children: [
          // Background con imagen
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/new_flight/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 74.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Let's find out how to get",
                      style: TextStyle(
                        fontSize: 19.5,
                        fontFamily: 'Montserrat-ExtraBold',
                        color: CupertinoDynamicColor.withBrightness(
                          color: Color(0xFF000000),
                          darkColor: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                    const Text(
                      "To The Plane!",
                      style: TextStyle(
                        fontSize: 45,
                        fontFamily: 'Montserrat-ExtraBold',
                        color: CupertinoColors.label,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What is your Flight Number?',
                      style: TextStyle(
                        color: CupertinoColors.secondaryLabel,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CupertinoTextField(
                      placeholder: 'ex. AA555',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      style: const TextStyle(fontSize: 19.5),
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey5,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton.filled(
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Find the way'),
                            SizedBox(width: 5),
                            Icon(CupertinoIcons.airplane),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
