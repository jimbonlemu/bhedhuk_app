class DateTimeService {
  static DateTime format() {
    final now = DateTime.now();
    final timeSpecific = DateTime(now.year, now.month, now.day, 11);

    if (now.isAfter(timeSpecific)) {
      return DateTime(now.year, now.month, now.day + 1, 11);
    } else {
      return timeSpecific;
    }
  }
}
