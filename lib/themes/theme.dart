import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double defaultMargin = 10.0;
double mMargin = 20.0;
double xlMargin = 30.0;

double sRadius = 20.0;
double defaultRadius = 30.0;

double sPadding = 10;
double defaultPadding = 20;
double mPadding = 20;

double defaultResponsive = 10;
double mresponsive = 20;
double xlresponsive = 30;

double defaultSpacer = 15;

double headerSize = 0.6;

double heightFraction = 0.22;

MaterialColor mBlue = Colors.blue;
Color cBlack = const Color(0xff000000);
Color cWhite = const Color(0xffFFFFFF);
Color cBlue = const Color(0xff1AA7EC);
Color cDisable = const Color(0xff999999);
Color cSecondary = const Color(0xff757C88);
Color cScaffold = const Color(0xFFF2F0F0);
Color cUnselected = const Color(0xFFFFC107);
Color cGreen = const Color(0xff4CAF50);

TextTheme tTheme = GoogleFonts.poppinsTextTheme();

TextStyle tPrimary = GoogleFonts.poppins(
  fontSize: 16,
  color: cBlack,
);
TextStyle tSecondary = GoogleFonts.poppins(
  fontSize: 13,
  color: cSecondary,
);
TextStyle tTrailingRepo = GoogleFonts.poppins(
  fontSize: 10,
  color: cSecondary,
);
TextStyle tTrailingIssue = GoogleFonts.poppins(
  fontSize: 14,
  color: cGreen,
);
TextStyle tButton = GoogleFonts.poppins(
  fontSize: 13,
  color: cWhite,
);

Size designScreenSize = const Size(375, 754);

extension BuildContextX on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  double get iconSize => IconTheme.of(this).size;

  EdgeInsets get padding => MediaQuery.of(this).padding;

  double responsive(double size, {Axis axis = Axis.vertical}) {
    final currentSize =
        axis == Axis.horizontal ? screenSize.width : screenSize.height;
    final designSize = axis == Axis.horizontal
        ? designScreenSize.width
        : designScreenSize.height;

    return size * currentSize / designSize;
  }
}

class FadeRoute extends PageRouteBuilder {
  FadeRoute({this.page})
      : super(
          pageBuilder: (_, __, ___) => page,
          transitionsBuilder: (_, animation, __, child) => FadeTransition(
            opacity: animation,
            child: child,
          ),
        );

  final Widget page;
}
