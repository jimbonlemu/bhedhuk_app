import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const dailyFeedNotification = 'DAILY_FEED_NOTIFICATION';

  PreferencesService._internal();
  static final PreferencesService _instance = PreferencesService._internal();
  factory PreferencesService() => _instance;

  Future<bool> get isDailyFeedNotificationActive async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(dailyFeedNotification) ?? false;
  }

  void setDailyFeedNotification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(dailyFeedNotification, value);
  }
}
