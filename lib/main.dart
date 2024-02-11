import 'package:bhedhuk_app/pages/feed_page/feed_settings_page.dart';

import 'data/api/api_service.dart';
import 'pages/feed_page/feed_detail_page.dart';
import 'provider/connecivity_provider.dart';
import 'provider/feed_review_provider.dart';
import 'provider/feed_search_provider.dart';
import 'provider/utils_provider.dart';
import 'provider/feed_list_provider.dart';
import 'utils/navigation_service.dart';
import 'utils/styles.dart';
import 'pages/utils_page/navbar_page.dart';
import 'pages/utils_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  ApiService apiService = ApiService();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedListProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (context) => UtilsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedSearchProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedReviewProvider(apiService: apiService),
        )
      ],
      child: const FeedMeApp(),
    ),
  );
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
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: primaryColor,
              onPrimary: onPrimaryColor,
              secondary: secondaryColor,
            ),
        scaffoldBackgroundColor: Colors.white70,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: Colors.amber[400],
          elevation: 0,
        ),
        textTheme: bhedhukTextTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: secondaryColor,
            textStyle: const TextStyle(),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(0),
              ),
            ),
          ),
        ),
      ),
      // home: const SplashPage(),
      initialRoute: SplashPage.route,
      routes: {
        SplashPage.route: (context) => const SplashPage(),
        NavBarPage.route: (context) => NavBarPage(),
        FeedDetailPage.route: (context) => FeedDetailPage(
              restaurantId:
                  (ModalRoute.of(context)?.settings.arguments as String?) ?? '',
            ),
        FeedSettingsPage.route: (context) => const FeedSettingsPage()
      },
    );
  }
}
