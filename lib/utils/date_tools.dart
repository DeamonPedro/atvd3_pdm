String formatDate(num timestamp) {
  final date = DateTime.fromMillisecondsSinceEpoch(timestamp as int);
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  return '$day/$month/${date.year}';
}
