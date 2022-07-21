import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_list_app/src/res/colors.dart';

final theme = _appTheme();

ThemeData _appTheme() {
  final base = ThemeData.light();
  return base.copyWith(
      appBarTheme: base.appBarTheme.copyWith(
        titleTextStyle: base.textTheme.headline6!.copyWith(
            color: purpleT20,
            fontFamily: GoogleFonts.yanoneKaffeesatz().fontFamily),
        color: purpleS80,
        elevation: 8.0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
      colorScheme: base.colorScheme.copyWith(
        onPrimary: purpleT30,
        primary: purpleS60,
        primaryContainer: purpleS80,
        onPrimaryContainer: purpleT20,
        inversePrimary: purple,
        onSecondary: magentaT30,
        secondary: magentaS60,
        secondaryContainer: magentaS80,
        onSecondaryContainer: magentaT20,
        onTertiary: blueT30,
        tertiary: blueS60,
        tertiaryContainer: blueS80,
        onTertiaryContainer: blueT20,
      ),
      textTheme: _textTheme(GoogleFonts.yanoneKaffeesatzTextTheme()));
}

TextTheme _textTheme(TextTheme base) {
  return base
      .copyWith(
        headline5: base.headline5!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 18.0,
        ),
        caption: base.caption!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 14.0,
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontWeight: FontWeight.w500,
          fontSize: 16.0,
        ),
      )
      .apply(fontFamily: GoogleFonts.yanoneKaffeesatz().fontFamily);
}
