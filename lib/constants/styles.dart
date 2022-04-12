import 'package:creative_app/constants/colors.dart';
import 'package:flutter/cupertino.dart';

const TextStyle title = TextStyle(
    fontSize: 22, fontWeight: FontWeight.w500, color: MyColors.textSubHeader);

const TextStyle subTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: MyColors.textBody,
    fontFamily: 'opensans');

BoxShadow boxShadow(Color myColor) {
  return BoxShadow(
    color: myColor,
    blurRadius: 15,
    spreadRadius: 8,
    offset: Offset(3, 3),
  );
}
