import 'package:flutter/material.dart';

class NameAndDescriptionOnSlide extends StatelessWidget {
  const NameAndDescriptionOnSlide({
    super.key,
    this.name,
    this.description,
  });
  final String? name;
  final String? description;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            description!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
