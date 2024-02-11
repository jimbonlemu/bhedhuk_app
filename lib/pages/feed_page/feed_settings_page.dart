import 'package:bhedhuk_app/widgets/custom_appbar_widget.dart';
import 'package:flutter/material.dart';

class FeedSettingsPage extends StatelessWidget {
  static const route = '/feed_settings_page';
  const FeedSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: "Feed Settings Page",
      ),
    );
  }
}
