import 'dart:async';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool isConnected = true;
  late StreamSubscription subscription;

  ConnectivityProvider() {
    subscription = Connectivity().onConnectivityChanged.listen((result) {
      isConnected = (result != ConnectivityResult.none);
      notifyListeners();
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

void showNoInternetDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) async {
          bool isConnected = await InternetConnectionChecker().hasConnection;
          if (isConnected) {
            return Future.delayed(Duration.zero, () => isConnected);
          }
        },
        child: AlertDialog(
          title: Text('No Internet'),
          content: Text('You have no internet connection.'),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Check Connection'),
              onPressed: () async {
                bool isConnected =
                    await InternetConnectionChecker().hasConnection;
                if (isConnected) {
                  Navigator.pop(context, 'Cancel');
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
