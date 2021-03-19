import 'package:flutter/material.dart';

class AppTheme {
  static TextTheme _buildTextTheme(TextTheme base) {
    const String fontName = 'WorkSans';
    return base.copyWith(
      headline1: base.headline1.copyWith(fontFamily: fontName),
      headline2: base.headline2.copyWith(fontFamily: fontName),
      headline3: base.headline3.copyWith(fontFamily: fontName),
      headline4: base.headline4.copyWith(fontFamily: fontName),
      headline5: base.headline5.copyWith(fontFamily: fontName),
      headline6: base.headline6.copyWith(fontFamily: fontName),
      button: base.button.copyWith(fontFamily: fontName),
      caption: base.caption.copyWith(fontFamily: fontName, color: Colors.black),
      bodyText1:
          base.bodyText1.copyWith(fontFamily: fontName, color: Colors.black),
      bodyText2:
          base.bodyText2.copyWith(fontFamily: fontName, color: Colors.black),
      subtitle1:
          base.subtitle1.copyWith(fontFamily: fontName, color: Colors.black),
      subtitle2:
          base.subtitle2.copyWith(fontFamily: fontName, color: Colors.black),
      overline: base.overline.copyWith(fontFamily: fontName),
    );
  }

  static ThemeData buildTheme() {
    final Color primaryColor = Color.fromRGBO(68, 61, 58, 1);
    final Color secondaryColor = Color.fromRGBO(68, 61, 58, 1);

    final ColorScheme colorScheme = const ColorScheme.light().copyWith(
      primary: primaryColor,
      secondary: secondaryColor,
    );

    final appBarTheme = AppBarTheme(
      color: Color.fromRGBO(68, 61, 58, 1),
    );

    final inputDecorationTheme = InputDecorationTheme(
      hintStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );

    final ThemeData base = ThemeData.dark();

    return base.copyWith(
      colorScheme: colorScheme,
      inputDecorationTheme: inputDecorationTheme,
      primaryColor: primaryColor,
      buttonColor: primaryColor,
      appBarTheme: appBarTheme,
      indicatorColor: Colors.white,
      splashColor: Colors.white24,
      splashFactory: InkRipple.splashFactory,
      accentColor: secondaryColor,
      canvasColor: Colors.white,
      backgroundColor: const Color(0xFFFFFFFF),
      scaffoldBackgroundColor: const Color(0xFFF6F6F6),
      errorColor: const Color(0xFFB00020),
      buttonTheme: ButtonThemeData(
        colorScheme: colorScheme,
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      accentTextTheme: _buildTextTheme(base.accentTextTheme),
      // platform: TargetPlatform.iOS,
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class ThemeChanger with ChangeNotifier {

  bool _darkTheme   = false;
  bool _customTheme = false;

  ThemeData _currentTheme;

  bool get darkTheme   => this._darkTheme;
  bool get customTheme => this._customTheme;
  ThemeData get currentTheme => this._currentTheme;


  ThemeChanger( int theme ) {

    switch( theme ) {

      case 1: // light
        _darkTheme   = false;
        _customTheme = false;
        _currentTheme = ThemeData.light();
        break;

      case 2: // Dark
        _darkTheme   = true;
        _customTheme = false;
        _currentTheme = ThemeData.dark().copyWith(
            accentColor: Colors.pink
        );
        break;

      case 3: // Dark
        _darkTheme   = false;
        _customTheme = true;
        break;

      default:
        _darkTheme = false;
        _darkTheme = false;
        _currentTheme = ThemeData.light();
    }
  }



  set darkTheme( bool value ) {
    _customTheme = false;
    _darkTheme = value;

    if ( value ) {
      _currentTheme = ThemeData.dark().copyWith(
          accentColor: Colors.pink
      );
    } else {
      _currentTheme = ThemeData.light();
    }

    notifyListeners();
  }

  set customTheme( bool value ) {
    _customTheme = value;
    _darkTheme = false;

    if ( value ) {
      _currentTheme = ThemeData.dark().copyWith(
        accentColor: Color(0xff48A0EB),
        primaryColorLight: Colors.white,
        scaffoldBackgroundColor: Color(0xff16202B),
        textTheme: TextTheme(
            body1: TextStyle( color: Colors.white )
        ),
        // textTheme.body1.color
      );
    } else {
      _currentTheme = ThemeData.light();
    }

    notifyListeners();
  }

}
