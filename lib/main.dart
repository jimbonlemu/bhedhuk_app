import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:feed_me/data/api/api_service.dart';
import 'package:feed_me/data/database/feed_database_service.dart';
import 'package:feed_me/provider/feed_list_provider.dart';
import 'package:feed_me/provider/feed_notification_scheduling.dart';
import 'pages/feed_page/feed_settings_page.dart';
import 'provider/feed_database_provider.dart';
import 'provider/feed_settings_preferences_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'pages/feed_page/feed_detail_page.dart';
import 'provider/connecivity_provider.dart';
import 'provider/feed_review_provider.dart';
import 'provider/feed_search_provider.dart';
import 'provider/utils_provider.dart';
import 'utils/feed_background_service.dart';
import 'utils/navigation_service.dart';
import 'utils/notification_service.dart';
import 'utils/styles.dart';
import 'pages/utils_page/navbar_page.dart';
import 'pages/utils_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  initNotif();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => UtilsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedSearchProvider(apiService:  ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedReviewProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedDatabaseProvider(feedDatabaseService: FeedDatabaseService()),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedSettingsPreferencesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedNotificationScheduling(),
        ),  
      ],
      child: const FeedMeApp(),
    ),
  );
}

Future<void> initNotif() async {
  final FeedNotificationService notificationService = FeedNotificationService();
  final FeedBackgroundService backgroundService = FeedBackgroundService();
  backgroundService.initIsolatePort();
  await AndroidAlarmManager.initialize();
  await notificationService.initNotification(flutterLocalNotificationsPlugin);
}


class FeedMeApp extends StatelessWidget {
  const FeedMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Feed Me',
      debugShowCheckedModeBanner: false,
      theme: feedMeThemeData(context),
      initialRoute: SplashPage.route,
      routes: {
        SplashPage.route: (context) => const SplashPage(),
        NavBarPage.route: (context) => const NavBarPage(),
        FeedDetailPage.route: (context) => FeedDetailPage(
              restaurantId:
                  (ModalRoute.of(context)?.settings.arguments as String?) ?? '',
            ),
        FeedSettingsPage.route: (context) => const FeedSettingsPage()
      },
    );
  }
}
