import 'dart:convert';
import 'dart:math';
import 'package:bhedhuk_app/data/models/list_of_restaurant_object_api_response.dart';
import 'package:bhedhuk_app/data/models/object_of_restaurant.dart';
import 'package:bhedhuk_app/utils/navigation_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final selectedFeedInNotification = BehaviorSubject<String>();

class FeedNotificationService {
  FeedNotificationService._internal();
  static final FeedNotificationService _instance =
      FeedNotificationService._internal();

  factory FeedNotificationService() => _instance;

  Future<void> initNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initAndroidSettings = const AndroidInitializationSettings('app_icon');
    var initIosSettings = const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initPlatformSettings = InitializationSettings(
      android: initAndroidSettings,
      iOS: initIosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(initPlatformSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
      final payLoad = response.payload;
      if (payLoad != null) {
        print("Notif payload : $payLoad");
      }
      selectedFeedInNotification.add(payLoad ?? "Empty Payload");
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      ListOfRestaurantObjectApiResponse
          listOfRestaurantObjectApiResponse) async {
    var channelId = "1";
    var channelName = "channel_01";
    var channelDesc = "Feed Me Recommendation Channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDesc,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: const DefaultStyleInformation(true, true),
    );

    var iosPlatformChannelSpecifics = const DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics,
    );

    var notificationId = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    var randomFeed = Random().nextInt(
        listOfRestaurantObjectApiResponse.listobjectOfRestaurant.length);
    var result =
        listOfRestaurantObjectApiResponse.listobjectOfRestaurant[randomFeed];
    var titleFeed = "<b>${result.name}</b>";
    var descFeed = result.description;

    await flutterLocalNotificationsPlugin.show(
      notificationId,
      titleFeed,
      descFeed,
      platformChannelSpecifics,
      payload: jsonEncode(result.toJson()),
    );
  }

  void configureSelectNotificationSubject(String route) {
    selectedFeedInNotification.stream.listen((String payload) async {
      var restaurant = ObjectOfRestaurant.fromJson(jsonDecode(payload));
      Navigate.withGift(route, restaurant.id);
    });
  }
}
