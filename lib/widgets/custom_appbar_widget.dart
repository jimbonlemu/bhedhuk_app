import 'package:bhedhuk_app/data/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? titleWidget;
  final double? fontSize;
  final bool? centerTitle;
  final bool? disappearWhenScrolled;
  final bool? isUsingDefaultColorTheme;
  final List<Widget>? slivers;
  final Image? image;
  final Color? color;
  final Widget? imageTitle;

  const CustomAppBarWidget(
      {Key? key,
      this.title,
      this.titleWidget,
      this.fontSize = 25,
      this.centerTitle = true,
      this.disappearWhenScrolled = false,
      this.isUsingDefaultColorTheme = true,
      this.slivers,
      this.color,
      this.image,
      this.imageTitle})
      : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _CustomAppBarWidgetState createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.disappearWhenScrolled == true) {
      return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: true,
              backgroundColor: widget.isUsingDefaultColorTheme == true
                  ? primaryColor
                  : Colors.transparent,
              centerTitle: widget.centerTitle,
              title: widget.titleWidget ??
                  Text(
                    widget.title ?? '',
                    style: TextStyle(
                      fontSize: widget.fontSize,
                    ),
                  ),
              stretch: true,
              elevation: 0,
              pinned: true,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                title: widget.imageTitle,
                background: widget.image,
              ),
            ),
            ...widget.slivers ?? [],
          ],
        ),
      );
    }
    return AppBar(
      backgroundColor: widget.isUsingDefaultColorTheme == true
          ? primaryColor
          : Colors.transparent,
      centerTitle: widget.centerTitle,
      title: widget.titleWidget ??
          Text(
            widget.title!,
            style: TextStyle(
              fontSize: widget.fontSize,
            ),
          ),
    );
  }
}
