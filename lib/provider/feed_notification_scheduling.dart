import 'package:bhedhuk_app/utils/feed_background_service.dart';
import 'package:flutter/foundation.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class FeedNotificationScheduling extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledFeed(bool value) async {
    _isScheduled = value;

    if (_isScheduled) {
      print("Feed Scheduling Activated");
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(minutes: 1),
        1,
        FeedBackgroundService.portCallback,
        startAt: DateTime.now(),
        exact: true,
        wakeup: true,
      );
    } else {
      print("Feed Scheduling Disabled");
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
