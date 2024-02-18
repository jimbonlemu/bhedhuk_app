import 'dart:async';
import '../widgets/custom_alert_dialog_widget.dart';
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
        child: CustomAlertDialog(
          purpose: 'internetConnectionAlert',
          onPressed: () async {
            final Completer<bool> completer = Completer<bool>();
            InternetConnectionChecker().hasConnection.then((isConnected) {
              if (isConnected) {
                completer.complete(true);
              }
            });
            return completer.future.then((isConnected) {
              if (isConnected && Navigator.canPop(context)) {
                Navigator.pop(context, 'Cancel');
              }
            });
          },
        ),
      );
    },
  );
}
