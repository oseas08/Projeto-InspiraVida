class HealthItem {
  final String id;
  final String title;
  final String description;
  final String type; // 'exercise' ou 'food'
  final String emoji;
  final DateTime dateTime;

  HealthItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.emoji,
    required this.dateTime,
  });
}