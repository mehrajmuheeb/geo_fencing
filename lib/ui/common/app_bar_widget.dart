
import 'package:base_flutter/ui/common/text_view.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final isDashboard;
  final String title;
  final Widget? location;

  const AppBarWidget(this.scaffoldKey,
      {this.title = "", this.isDashboard = false, this.location, Key? key})
      : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          IconButton(
              onPressed: () {
              },
              icon: Icon(
                Icons.location_searching_rounded,
                color: Colors.black,
              )),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Align(
                alignment: Alignment.center,
                child: widget.location ?? TextView(
                        text: widget.title,
                        weight: FontWeight.w800,
                        textAlign: TextAlign.center,
                  size: 24,
                      )
            ),
          )),
        ],
      ),
    );
  }
}
