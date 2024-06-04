
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
          surfaceTintColor: const WidgetStatePropertyAll(Color(0xFF99292F)),
          textStyle: WidgetStateProperty.all(const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 15.0,
            shadows: [
              Shadow(
                color: Color.fromARGB(148, 153, 41, 47),
                offset: Offset(0, 0),
                blurRadius: 3,
              )],
          ))
        )
      )
    );
  }
}
