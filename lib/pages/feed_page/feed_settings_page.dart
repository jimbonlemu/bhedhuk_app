import 'package:feed_me/provider/feed_notification_scheduling.dart';
import 'package:feed_me/provider/feed_settings_preferences_provider.dart';
import 'package:feed_me/utils/styles.dart';
import 'package:feed_me/widgets/custom_appbar_widget.dart';
import 'package:feed_me/widgets/custom_snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedSettingsPage extends StatefulWidget {
  static const route = '/feed_settings_page';
  const FeedSettingsPage({super.key});

  @override
  State<FeedSettingsPage> createState() => _FeedSettingsPageState();
}

class _FeedSettingsPageState extends State<FeedSettingsPage> {
  bool isEnableSnackBar(bool value) {
    if (value) {
      CustomSnackBarWidget.victory(context,
          "You have just turned ON daily restaurant recommendations every 11 AM!");
      return true;
    } else {
      CustomSnackBarWidget.facts(
        context,
        "You've just turned OFF the daily restaurant recommendations.",
        durationInSeconds: 5,
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBarWidget(
          title: "Feed Settings Page",
        ),
        body: Consumer<FeedSettingsPreferencesProvider>(
            builder: (context, feedSettingsPreferencesProvider, child) {
          return Container(
            padding: const EdgeInsets.only(top: 15, left: 7, right: 7),
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    title: const Text('Enable Daily Recommendation'),
                    trailing: Consumer<FeedNotificationScheduling>(
                      builder: (context, feedScheduling, _) {
                        return Switch.adaptive(
                          activeTrackColor: primaryColor,
                          inactiveTrackColor: blackColor,
                          activeColor: blackColor,
                          inactiveThumbColor: primaryColor,
                          trackOutlineColor:
                              MaterialStateColor.resolveWith((states) {
                            if (states.contains(MaterialState.selected)) {
                              return primaryColor;
                            }
                            return blackColor;
                          }),
                          value: feedSettingsPreferencesProvider
                              .isDailyFeedNotificationActive,
                          onChanged: (value) async {
                            feedScheduling.scheduledFeed(value);
                            feedSettingsPreferencesProvider
                                .enableDailyFeedNotification(value);
                            isEnableSnackBar(value);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
