import 'package:flutter/material.dart';

class AppTheme {
  ThemeData darkMode() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF99292F),
        onPrimary: Color(0xff2D4485),
        secondary: Color(0xff2D4485),
        onSecondary: Color(0xFF99292F),
        error: Color.fromARGB(255, 255, 0, 0),
        onError: Color.fromARGB(255, 255, 0, 0),
        surface: Color.fromARGB(255, 0, 0, 0),
        onSurface: Color.fromARGB(255, 255, 255, 255),
        shadow: Color.fromARGB(255, 255, 255, 255),
        surfaceContainer: Color(0xFF2D4485),
        surfaceBright: Color.fromARGB(255, 255, 255, 255),
        primaryContainer: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  ThemeData lightMode() {
    return ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF99292F),
          onPrimary: Color(0xff2D4485),
          secondary: Color(0xff2D4485),
          onSecondary: Color(0xFF99292F),
          error: Color.fromARGB(255, 255, 0, 0),
          onError: Color.fromARGB(255, 255, 0, 0),
          surface: Color.fromARGB(255, 255, 255, 255),
          onSurface: Color.fromARGB(255, 0, 0, 0),
          shadow: Color.fromARGB(255, 0, 0, 0),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                elevation: const WidgetStatePropertyAll(8),
                mouseCursor: WidgetStateMouseCursor.clickable,
                surfaceTintColor:
                    const WidgetStatePropertyAll(Color(0xFF99292F)),
                textStyle: WidgetStateProperty.all(const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15.0,
                )))),
        filledButtonTheme: FilledButtonThemeData(
            style: ButtonStyle(
          mouseCursor: WidgetStateMouseCursor.clickable,
          foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
          elevation: WidgetStateProperty.all<double>(8),
          textStyle: WidgetStateProperty.all<TextStyle>(const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 13.0,
          )),
        )),
        dataTableTheme: DataTableThemeData(
          dataTextStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
          ),
          headingTextStyle: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
          headingRowColor:
              WidgetStateProperty.all<Color>(const Color(0xFF99292F)),
        ),
        checkboxTheme: CheckboxThemeData(
            checkColor: WidgetStateProperty.all<Color>(Colors.white),
            shape: const CircleBorder(
              side: BorderSide(
                color: Color(0xFF99292F),
                width: 15.0,
              ),
            ),
            splashRadius: 15.0,
            mouseCursor: WidgetStateMouseCursor.clickable),
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF99292F),
          titleTextStyle: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
            shadows: <Shadow>[
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(0, 0),
                blurRadius: 9,
              ),
            ],
          ),
        ),
        sliderTheme: const SliderThemeData(
          inactiveTickMarkColor: Color(0xFF99292F),
          inactiveTrackColor: Color.fromARGB(32, 153, 41, 47),
          valueIndicatorTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 15.0,
            fontWeight: FontWeight.w900,
          ),
          showValueIndicator: ShowValueIndicator.always,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF99292F),
          foregroundColor: Colors.white,
          elevation: 8,
          focusElevation: 8,
          hoverElevation: 8,
          highlightElevation: 8,
          disabledElevation: 8,
          shape: CircleBorder(),
        ));
  }
}

List<BoxShadow> buildShadowBox() {
  return List<BoxShadow>.generate(
    3,
    (int index) => BoxShadow(
      color: Colors.black.withOpacity(0.2),
      spreadRadius: 0.5,
      blurRadius: 10,
      offset: const Offset(0, 0),
    ),
  );
}
