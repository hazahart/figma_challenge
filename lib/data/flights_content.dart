import 'package:flutter/cupertino.dart';

class FlightsContent extends StatelessWidget {
  const FlightsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text("My Flights"),
        trailing: CupertinoButton(
          onPressed: () {},
          padding: EdgeInsets.zero,
          child: const Text("Edit"),
        ),
      ),
      child: ListView.builder(
        itemCount: 16,
        itemBuilder: (context, index) {
          return SafeArea(
            top: false,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(
                    CupertinoIcons.airplane,
                    color: CupertinoColors.secondaryLabel,
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Munich Airport ✈ BCN (Barcelona)",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Mon 21 Mar, 2022",
                          style: TextStyle(
                            color: CupertinoColors.secondaryLabel,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    CupertinoIcons.right_chevron,
                    color: CupertinoColors.tertiaryLabel,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
