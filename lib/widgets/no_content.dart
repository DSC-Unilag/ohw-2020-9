import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget buildNoContent(BuildContext context, {String text}) {
  return Center(
    child: ListView(
      padding: EdgeInsets.all(20.0),
      shrinkWrap: true,
      children: <Widget>[
        SvgPicture.asset(
          'assets/images/no_content.svg',
          height: 300.0,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.w600,
            fontSize: 30.0,
          ),
        ),
      ],
    ),
  );
}
