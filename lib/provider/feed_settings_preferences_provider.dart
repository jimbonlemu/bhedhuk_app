import 'package:feed_me/data/preferences/preferences_service.dart';
import 'package:flutter/material.dart';

class FeedSettingsPreferencesProvider extends ChangeNotifier {
  FeedSettingsPreferencesProvider() {
    _getDailyFeedNotificationPreferences();
  }

  bool _isDailyFeedNotificationActive = false;
  bool get isDailyFeedNotificationActive => _isDailyFeedNotificationActive;

  void _getDailyFeedNotificationPreferences() async {
    _isDailyFeedNotificationActive =
        await PreferencesService().isDailyFeedNotificationActive;
    notifyListeners();
  }

  void enableDailyFeedNotification(bool value) async {
    PreferencesService().setDailyFeedNotification(value);
    _getDailyFeedNotificationPreferences();
  }
}
