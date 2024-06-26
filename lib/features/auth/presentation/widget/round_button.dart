import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
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
    return InkWell(
      onTap: onPressed,
      child: Container(
          height: 50,
          width: size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [
                  AppColors.darkBlueColor,
                  AppColors.pinkPurpleColor
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  color: AppColors.whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
          )
      ),
    );
  }
}