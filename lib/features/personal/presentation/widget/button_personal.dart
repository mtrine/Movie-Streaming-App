import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class ButtonPersonal extends StatelessWidget {
  const ButtonPersonal({
    super.key,
    required this.size,
    required this.text,
    required this.onPressed,
  });

  final Size size;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.darkPurpleColor,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
        minimumSize: Size(size.width, 10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
