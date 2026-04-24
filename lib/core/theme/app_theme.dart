import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: Colors.teal,
      brightness: Brightness.light,
      fontFamily: 'Roboto', // Replace with rounded font if added later
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFF0F4F8),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 16.0, color: Colors.blueGrey),
        titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.blueGrey),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}
