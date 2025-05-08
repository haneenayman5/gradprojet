class ClassificationResult {
  final String category;
  final double confidence;

  ClassificationResult({required this.category, required this.confidence});

  @override
  String toString() => '$category: ${(confidence * 100).toStringAsFixed(1)}%'; // Example formatting
}