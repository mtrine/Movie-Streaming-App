import 'package:flutter/material.dart';

class PosterFilm extends StatelessWidget {
  const PosterFilm({
    super.key,
    required this.url,
  });

  final String url;

  bool isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && (uri.isScheme('http') || uri.isScheme('https'));
  }

  @override
  Widget build(BuildContext context) {
    return isValidUrl(url)
        ? Image.network(
      url,
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Image.asset(
          'assets/images/fallback_image.png', // Path to your fallback image
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
        );
      },
    )
        : Image.asset(
      'assets/images/avatar.jpg', // Path to your fallback image
      fit: BoxFit.cover,
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width,
    );
  }
}
