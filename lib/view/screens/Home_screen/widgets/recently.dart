import 'package:flutter/material.dart';

class RecentlyPlayed extends StatelessWidget {
  const RecentlyPlayed({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Text(
          'Recently played',
          style: TextStyle(color: Colors.white),
        ),
        // Heading(title: 'Recently Played'),
        Spacer(),
        Icon(
          Icons.settings_outlined,
          size: 23,
          color: Colors.white,
        )
      ],
    );
  }
}
