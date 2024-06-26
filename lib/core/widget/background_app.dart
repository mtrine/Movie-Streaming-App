import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/app_color.dart';

Container buildBackgroundApp({required Size size,required Widget child}) {
  return Container(
    height: size.height,
    width: size.width,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          colors: [
            AppColors.pinkPurpleColor , // Màu bắt đầu của gradient
            AppColors.darkPurpleColor
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
      ),
    ),
    child: child,
  );
}