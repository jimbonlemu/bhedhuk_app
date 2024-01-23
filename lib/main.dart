import 'package:bhedhuk_app/data/models/restaurant.dart';
import 'package:bhedhuk_app/data/utils/styles.dart';
import 'package:bhedhuk_app/pages/feed_detail_page.dart';
import 'package:bhedhuk_app/pages/navbar_page.dart';
import 'package:bhedhuk_app/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const BhedhukApp());
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
      title: 'Bhedhuk App',
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
      home:const  SplashPage(),
      
      routes: {
        NavBarPage.route: (context) => const NavBarPage(),
      
        FeedDetailPage.route: (context) => FeedDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
