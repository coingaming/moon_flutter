import 'dart:typed_data';

double getBrightnessFromBytes(Uint8List bytes) {
  // Keep track of total brightness of the image.
  // For each pixel, assign positive value if it's bright.
  // For example: +1 for #FFFFFF, -1 for #000000.
  // So for neutral grey, its score will be close to 0.
  // However, if alpha is not FF, the score is discounted accordingly.
  // For example: `Colors.black.withOpacity(0.5)` has a score of `-0.5`.
  double totalScore = 0.0;

  for (int i = 0; i < bytes.length; i += 4) {
    final r = bytes[i];
    final g = bytes[i + 1];
    final b = bytes[i + 2];
    final a = bytes[i + 3];

    final brightness = 0.2126 * r + 0.7152 * g + 0.0722 * b; // 0 to 255
    final normalized = (brightness / 127.5 - 1) * (a / 255); // -1 to 1

    totalScore += normalized;
  }
  return totalScore;
}
