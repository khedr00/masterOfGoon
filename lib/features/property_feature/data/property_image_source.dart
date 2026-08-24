import 'package:flutter/material.dart';

class PropertyImageSource {
  static const propertyFallback =
      'assets/images/test_photos/property_primary_photo.png';
  static const roomFallback = 'assets/images/test_photos/1.jpg';
  static const outdoorFallback = 'assets/images/test_photos/2.png';

  static List<String> normalizeAll(Iterable<String> values, String fallback) {
    final normalized = values
        .map((value) => normalize(value, fallback))
        .toList();
    return normalized.isEmpty ? [fallback] : normalized;
  }

  static String normalize(String? value, String fallback) {
    final source = value?.trim() ?? '';
    if (source.startsWith('assets/')) return source;
    final uri = Uri.tryParse(source);
    return uri != null &&
            uri.hasScheme &&
            (uri.scheme == 'http' || uri.scheme == 'https') &&
            uri.host.isNotEmpty
        ? source
        : fallback;
  }

  static Widget image(
    String source,
    String fallback, {
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
  }) {
    if (source.startsWith('assets/')) {
      return Image.asset(source, fit: fit, width: width, height: height);
    }
    return Image.network(
      source,
      fit: fit,
      width: width,
      height: height,
      errorBuilder: (_, _, _) =>
          Image.asset(fallback, fit: fit, width: width, height: height),
    );
  }
}
