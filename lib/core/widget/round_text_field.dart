import 'package:flutter/material.dart';

import '../constants/app_color.dart';

class RoundTextField extends StatelessWidget {
  const RoundTextField({
    super.key,
    required this.onChanged,
    required this.controller,
    required this.hintText,
    this.title= '',
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    required this.textInputAction,
    this.validator,
  });
  final Function(String?) onChanged;
  final String title;
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style:const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 10,),
        TextFormField(
          onChanged: (value)=>onChanged(value),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 16,
            ),
            fillColor:AppColors.darkPurpleColor ,
            filled: true,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.pinkPurpleColor, // Màu viền khi không tập trung
                width: 2.0, // Độ dày của viền
              ),
            ),
          ),
          obscureText: isPassword,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 16,
          )
        )
      ],
    );
  }
}
