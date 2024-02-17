import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/styles.dart';

class CustomGeneralSliverSearchBarWidget extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String) onSubmitted;
  final String? hintText;

  const CustomGeneralSliverSearchBarWidget(
      {super.key, this.controller, required this.onSubmitted, this.hintText});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
        forceMaterialTransparency: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        floating: true,
        snap: true,
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(45.0), child: SizedBox()),
        flexibleSpace: _buildSearchBar(context));
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        margin: EdgeInsets.zero,
        child: Container(
          margin: EdgeInsets.zero,
          width: MediaQuery.of(context).size.width,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20) / 2,
            color: whiteColor,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 20),
              onSubmitted: onSubmitted,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 12.0),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  suffixIcon: Material(
                    child: Container(
                        width: 30,
                        height: 30,
                        padding: const EdgeInsets.only(top: 12.0),
                        child: const Icon(CupertinoIcons.search)),
                  ),
                  hintText: hintText,
                  hintStyle: feedMeTextTheme.bodyLarge),
            ),
          ),
        ),
      ),
    );
  }
}
