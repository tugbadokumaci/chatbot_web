import 'package:chatbot_web/extension/context_extension.dart';
import 'package:flutter/material.dart';

// class CustomTextStyles {
//   CustomTextStyles();

//   // static TextStyle appBarTitleTextStyle() {
//   //   return TextStyle(
//   //       fontFamily: 'REM', color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.4, fontWeight: FontWeight.bold);
//   // }

//   static TextStyle titleLargeTextStyle() {
//     return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.5, fontWeight: FontWeight.bold);
//   }

//   static TextStyle titleMediumTextStyle() {
//     return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2.2, fontWeight: FontWeight.bold);
//   }

//   static TextStyle titleSmallTextStyle() {
//     return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 2, fontWeight: FontWeight.bold);
//   }

//   static TextStyle titleExtraSmallTextStyle() {
//     return TextStyle(color: Colors.white, fontSize: SizeConfig.defaultSize! * 1.8, fontWeight: FontWeight.bold);
//   }
// }

class CustomTextStyles2 {
  static TextStyle buttonTextStyle(BuildContext context, Color textColor) {
    return context.theme.textTheme.titleMedium!.copyWith(
      color: textColor,
      fontWeight: FontWeight.bold,
      fontFamily: 'Inter',
    );
  }

  static TextStyle titleLargeTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontSize: 25,
          color: textColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        );
  }

  static TextStyle titleMediumTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineMedium!.copyWith(
          fontSize: 22,
          color: textColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        );
  }

  static TextStyle titleSmallTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 20,
          color: textColor,
          fontFamily: 'Inter',
        );
  }

  static TextStyle titleExtraSmallTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 18,
          color: textColor,
          fontFamily: 'Inter',
        );
  }

  static TextStyle textSmallTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 15,
          color: textColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        );
  }

  static TextStyle textMediumTextStyle(BuildContext context, Color textColor) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 17,
          color: textColor,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        );
  }

  static TextStyle appBarTextStyle(BuildContext context) {
    return Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontFamily: 'Inter',
          fontWeight: FontWeight.bold,
        );
  }

  static TextStyle drawerTitleTextStyle(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .headlineSmall!
        .copyWith(fontFamily: 'Inter', fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17);
  }
}
