import 'dart:isolate';
import 'dart:ui';

import 'package:feed_me/data/api/api_service.dart';
import 'package:feed_me/main.dart';
import 'package:feed_me/utils/notification_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final ReceivePort receivePort = ReceivePort();

class FeedBackgroundService {
  static FeedBackgroundService? _instance;
  static const String _isolateName = 'feed_isolate';
  static SendPort? _sendPort;

  FeedBackgroundService._internal() {
    _instance = this;
  }

  factory FeedBackgroundService() =>
      _instance ?? FeedBackgroundService._internal();

  void initIsolatePort() {
    IsolateNameServer.registerPortWithName(
      receivePort.sendPort,
      _isolateName,
    );
  }

  static Future<void> portCallback() async {
    await dotenv.load(fileName: ".env");
    var result = await ApiService().getListOfRestaurant();
    await FeedNotificationService()
        .showNotification(flutterLocalNotificationsPlugin, result);
    _sendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _sendPort?.send(null);
  }
}
