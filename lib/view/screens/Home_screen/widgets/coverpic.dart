import 'package:flutter/material.dart';

class CoverPhoto extends StatelessWidget {
  final String url;
  const CoverPhoto({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      width: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          url,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
