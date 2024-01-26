import 'package:bhedhuk_app/data/api/api_service.dart';
import 'package:bhedhuk_app/data/models/old_data_models/restaurant.dart';
import 'package:bhedhuk_app/pages/feed_page/feed_detail_page.dart';
import 'package:bhedhuk_app/provider/feed_list_page_provider.dart';
import 'package:bhedhuk_app/provider/restaurant_provider.dart';
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
          create: (context) => RestaurantProvider(apiService: apiService),
        ),
        ChangeNotifierProvider(
          create: (context) => FeedListPageProvider(),
        ),
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
      // home: const SplashPage(),
      initialRoute: SplashPage.route,
      routes: {
        SplashPage.route: (context) => const SplashPage(),
        NavBarPage.route: (context) => const NavBarPage(),
        FeedDetailPage.route: (context) => FeedDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:pagination_flutter/pagination.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         splashColor: Colors.transparent,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int selectedPage = 1;

//   setSelectedPage(int index) {
//     setState(() {
//       selectedPage = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text("Flutter Pagination"),
//           backgroundColor: Colors.black),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Pagination(
//                 numOfPages: 10,
//                 selectedPage: selectedPage,
//                 pagesVisible: 3,
//                 spacing: 1,
//                 onPageChanged: (page) {
//                   setState(() {
//                     selectedPage = page;
//                   });
//                 },
//                 nextIcon: const Icon(
//                   Icons.chevron_right_rounded,
//                   color: Colors.redAccent,
//                   size: 20,
//                 ),
//                 previousIcon: const Icon(
//                   Icons.chevron_left_rounded,
//                   color: Colors.redAccent,
//                   size: 20,
//                 ),
//                 activeTextStyle: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w700,
//                 ),
//                 activeBtnStyle: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.all(Colors.redAccent),
//                   shape: MaterialStateProperty.all(const CircleBorder(
//                     side: BorderSide(
//                       color: Colors.redAccent,
//                       width: 1,
//                     ),
//                   )),
//                 ),
//                 inactiveBtnStyle: ButtonStyle(
//                   elevation: MaterialStateProperty.all(0),
//                   backgroundColor: MaterialStateProperty.all(Colors.white),
//                   shape: MaterialStateProperty.all(const CircleBorder(
//                     side: BorderSide(
//                       color: Colors.redAccent,
//                       width: 1,
//                     ),
//                   )),
//                 ),
//                 inactiveTextStyle: const TextStyle(
//                   fontSize: 14,
//                   color: Colors.redAccent,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
