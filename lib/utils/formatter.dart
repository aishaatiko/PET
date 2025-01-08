import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final timeFormat = DateFormat('HH:mm');

  if (date.isAtSameDayAs(today)) {
    return "Today (${timeFormat.format(date)})";
  } else if (date.isAtSameDayAs(yesterday)) {
    return "Yesterday (${timeFormat.format(date)})";
  } else {
    final dateFormat = DateFormat('dd MMM yyyy (HH:mm)');
    return dateFormat.format(date);
  }
}

// Helper extension to check if two dates are the same day
extension DateTimeExtensions on DateTime {
  bool isAtSameDayAs(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

String formatCurrency(double amount) {
  return 'Rp ${amount.toStringAsFixed(0).replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (match) => '${match[1]}.',
      )}';
}
