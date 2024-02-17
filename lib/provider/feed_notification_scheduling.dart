import 'package:feed_me/utils/feed_background_service.dart';
import 'package:flutter/foundation.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import '../utils/date_time_service.dart';

class FeedNotificationScheduling extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledFeed(bool value) async {
    _isScheduled = value;

    if (_isScheduled) {
      print("Feed Scheduling Activated");
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        FeedBackgroundService.portCallback,
        startAt: DateTimeService.format(),
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
