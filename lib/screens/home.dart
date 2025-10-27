import 'dart:ui';
import 'package:figma_challenge/pages/profile.dart';
import 'package:figma_challenge/screens/new_flight.dart';
import 'package:figma_challenge/widgets/tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/flights_content.dart';
import 'package:figma_challenge/models/users_model.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({
    super.key,
    required this.user,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final GlobalKey<FlightsContentState> _flightsContentKey = GlobalKey<FlightsContentState>();

  late User _currentUser;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    _currentUser = widget.user;
    _buildPages();
  }

  void _buildPages() {
    pages = [
      FlightsContent(
        key: _flightsContentKey,
        user: _currentUser,
      ),
      ProfilePage(
        user: _currentUser,
        onProfileUpdated: _handleProfileUpdate,
      ),
    ];
  }

  void _handleProfileUpdate(User updatedUser) {
    setState(() {
      _currentUser = updatedUser;
      _buildPages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          IndexedStack(
            index: currentIndex,
            children: pages,
          ),
          TabBarWidget(
            currentIndex: currentIndex,
            onItemSelected: (index) {
              setState(() => currentIndex = index);
            },
            onAddPressed: () async {
              final bool? flightAdded = await Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => NewFlight(user: _currentUser),
                ),
              );

              if (flightAdded == true) {
                _flightsContentKey.currentState?.loadUserFlights();
                setState(() => currentIndex = 0);
              }
            },
          ),
        ],
      ),
    );
  }
}