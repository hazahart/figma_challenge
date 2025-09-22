import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/flights_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            backgroundColor: CupertinoColors.black.withOpacity(0.025),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.airplane),
                activeIcon: Icon(
                  CupertinoIcons.airplane,
                  color: CupertinoColors.black,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.list_bullet),
                activeIcon: Icon(
                  CupertinoIcons.list_bullet,
                  color: CupertinoColors.black,
                ),
              ),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            return CupertinoTabView(
              builder: (BuildContext context) {
                if (index == 0) {
                  return const FlightsContent();
                }
                return const CupertinoPageScaffold(
                  child: Center(child: Text('Filters Screen')),
                );
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(
                context,
                rootNavigator: true,
              ).pushNamed('/onboarding0');
            },
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [
                    CupertinoColors.systemBlue,
                    CupertinoColors.systemTeal,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                CupertinoIcons.add,
                color: CupertinoColors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
