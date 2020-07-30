import 'package:flutter/material.dart';
import 'package:meme_generator/widgets/theme_icon.dart';

Widget header(BuildContext context, {String title, bool hasLeading = false}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        fontFamily: 'Poppins',
      ),
    ),
    automaticallyImplyLeading: hasLeading,
    centerTitle: true,
    actions: <Widget>[
      ThemeIcon(),
    ],
  );
}
