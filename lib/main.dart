import 'package:bhedhuk_app/data/api/api_service.dart';
import 'package:bhedhuk_app/provider/feed_search_provider.dart';
import 'package:bhedhuk_app/provider/utils_provider.dart';
import 'package:bhedhuk_app/provider/feed_list_provider.dart';
import 'package:bhedhuk_app/utils/navigation_service.dart';
import 'package:bhedhuk_app/utils/styles.dart';
import 'package:bhedhuk_app/pages/navbar_page.dart';
import 'package:bhedhuk_app/pages/utils_page/splash_page.dart';
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
          create: (context) => FeedListProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (context) => UtilsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedSearchProvider(apiService: apiService),
        )
      ],
      child: const BhedhukApp(),
    ),
  );
}

class BhedhukApp extends StatelessWidget {
  const BhedhukApp({super.key});

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
      },
    );
  }
}
