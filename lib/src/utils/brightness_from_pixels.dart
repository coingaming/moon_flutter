import 'dart:typed_data';

double getBrightnessFromBytes(Uint8List bytes) {
  /// Calculates the brightness score for each pixel in the image.
  ///
  /// For each pixel, a brightness score is assigned based on its color.
  /// Bright pixels receive a positive value, while dark pixels receive a negative value.
  /// A score close to 0 indicates a neutral grey color.
  ///
  /// The score is discounted if the pixel has transparency (alpha < 255).
  /// For example, a semi-transparent black pixel (#000000 with alpha < 255) has a negative score.
  double totalScore = 0.0;

  for (int i = 0; i < bytes.length; i += 4) {
    final r = bytes[i];
    final g = bytes[i + 1];
    final b = bytes[i + 2];
    final a = bytes[i + 3];

    final brightness = 0.2126 * r + 0.7152 * g + 0.0722 * b; // 0 to 255.
    final normalized = (brightness / 127.5 - 1) * (a / 255); // -1 to 1.

    totalScore += normalized;
  }
  return totalScore;
}
