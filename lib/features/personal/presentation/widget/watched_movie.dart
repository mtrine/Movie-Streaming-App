import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class WatchedMovie extends StatelessWidget {
  WatchedMovie({
    super.key,
    required this.imageUrl,
    required this.title,
  });
  String? imageUrl;
  String? title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
            child: Image.network(
              imageUrl!,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title!,
          style: const TextStyle(
            color: AppColors.whiteColor,
            fontSize: 18,
          ),
          softWrap: true,
          overflow: TextOverflow.visible,
          maxLines: 1,
        ),
      ],
    );
  }
}
