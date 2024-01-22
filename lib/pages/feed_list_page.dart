import 'package:flutter/material.dart';

class FeedListPage extends StatefulWidget {
  static const route = '/feeds_page';
  const FeedListPage({super.key});

  @override
  State<FeedListPage> createState() => _FeedListPageState();
}

class _FeedListPageState extends State<FeedListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeds Page'),
      ),
    );
  }
}
