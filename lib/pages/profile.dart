import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _appearanceValue = 0;
  bool _notifications = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      navigationBar: const CupertinoNavigationBar(),
      child: ListView(
        children: [
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "My Account",
                    style: TextStyle(
                      fontSize: 42,
                      fontFamily: 'Gigasans-ExtraBold',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: Text(
                    "PROFILE",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFFA0A0A6),
                      fontFamily: 'Helvetica',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 0,
              color: const Color(0xFFFFFFFF),
              child: Column(
                children: const [
                  CupertinoTextField(
                    placeholder: "Name",
                    padding: EdgeInsets.all(16),
                    decoration: null,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(height: 1, color: CupertinoColors.separator),
                  ),
                  CupertinoTextField(
                    placeholder: "Surname",
                    padding: EdgeInsets.all(16),
                    decoration: null,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Divider(height: 1, color: CupertinoColors.separator),
                  ),
                  CupertinoTextField(
                    placeholder: "Email",
                    padding: EdgeInsets.all(16),
                    decoration: null,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 36),
              child: const Text(
                "SETTINGS",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFFA0A0A6),
                  fontFamily: 'Helvetica',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Card(
              elevation: 0,
              color: const Color(0xFFFFFFFF),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Appearance:"),
                        CupertinoSegmentedControl<int>(
                          borderColor: CupertinoColors.systemGrey3,
                          selectedColor: CupertinoColors.white,
                          unselectedColor: CupertinoColors.systemGrey3,
                          pressedColor: CupertinoColors.systemGrey4,
                          children: const {
                            0: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.sun_max_fill,
                                    size: 18,
                                    color: CupertinoColors.black,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Light",
                                    style: TextStyle(
                                      color: CupertinoColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            1: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.moon_fill,
                                    size: 18,
                                    color: CupertinoColors.black,
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    "Dark",
                                    style: TextStyle(
                                      color: CupertinoColors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          },
                          onValueChanged: (value) {
                            setState(() {
                              _appearanceValue = value;
                            });
                          },
                          groupValue: _appearanceValue,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: CupertinoColors.separator),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Notifications:"),
                        CupertinoSwitch(
                          value: _notifications,
                          onChanged: (value) {
                            setState(() {
                              _notifications = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
