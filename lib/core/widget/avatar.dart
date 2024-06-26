import 'package:flutter/material.dart';



class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context,'/personal');
      },
      child: ClipOval(
        child: Image.asset(
          'assets/images/avatar.jpg', // Sử dụng URL của hình ảnh từ Firebase Storage
          width: 45,
          height: 45,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
