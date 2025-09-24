import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
    required this.onAddPressed,
  });

  final int currentIndex;
  final ValueChanged<int> onItemSelected;
  final VoidCallback onAddPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
          bottom: 30,
          left: 20,
          right: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(200, 248, 249, 251),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/tabbar/airline.svg",
                        height: 35,
                        colorFilter: ColorFilter.mode(
                          currentIndex == 0
                              ? CupertinoColors.black
                              : CupertinoColors.systemGrey,
                          BlendMode.srcIn,
                        ),
                      ),
                      onPressed: () => onItemSelected(0),
                    ),
                    const SizedBox(width: 60),
                    IconButton(
                      icon: SvgPicture.asset(
                        "assets/icons/tabbar/eq.svg",
                        height: 25,
                        colorFilter: ColorFilter.mode(
                          currentIndex == 1
                              ? CupertinoColors.black
                              : CupertinoColors.systemGrey,
                          BlendMode.srcIn,
                        ),
                      ),
                      onPressed: () => onItemSelected(1),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 25,
          child: GestureDetector(
            onTap: onAddPressed,
            child: Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CupertinoColors.systemBlue,
              ),
              child: const Icon(
                CupertinoIcons.add,
                color: CupertinoColors.white,
                size: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
