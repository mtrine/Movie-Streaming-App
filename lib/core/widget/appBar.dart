import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'avatar.dart';

class AppBarApp extends StatelessWidget {
  const AppBarApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Constants.defaultPadding,
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
          ),
          const Spacer(),
          Avatar(),
        ],
      ),
    );
  }
}
