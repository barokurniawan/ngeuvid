import 'package:flutter/material.dart';

ThemeData ngeuvidDarkTheme = ThemeData(
  // Use Material Design 3
  useMaterial3: true,

  // Primary color scheme (deep indigo with vibrant accent)
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF6C5CE7), // Vibrant purple-indigo
    brightness: Brightness.dark,
    surface: const Color(0xFF121212), // True black surface
    surfaceVariant:
        const Color(0xFF2D2D2D), // Slightly lighter surface for cards
    outline: const Color(0xFF555555), // Subtle dividers
    outlineVariant: const Color(0xFF444444), // Softer outlines
    shadow: const Color(0xFF000000), // Pure black shadows
  ),

  // Background and surface colors
  scaffoldBackgroundColor: const Color(0xFF121212),
  canvasColor: const Color(0xFF121212), // Dialogs, menus, etc.

  // Text styling
  textTheme: const TextTheme(
    // Headlines
    headlineLarge: TextStyle(
        fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    headlineMedium: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
    headlineSmall: TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),

    // Body text
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white70),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white70),
    bodySmall: TextStyle(fontSize: 12, color: Colors.white54),

    // Labels
    labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
    labelMedium: TextStyle(fontSize: 12, color: Colors.white70),
    labelSmall: TextStyle(fontSize: 11, color: Colors.white54),
  ),

  // Elevated button (primary actions)
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(const Color(0xFF6C5CE7)),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevation: MaterialStateProperty.all<double>(4),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    ),
  ),

  // Text button (secondary actions)
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all<Color>(const Color(0xFF6C5CE7)),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 16),
      ),
    ),
  ),

  // App bar
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1E1E1E),
    foregroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),

  // Bottom navigation
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Color(0xFF1E1E1E),
    selectedItemColor: Color(0xFF6C5CE7),
    unselectedItemColor: Colors.white54,
    elevation: 8,
  ),

  // Card
  cardTheme: CardTheme(
    color: const Color(0xFF1E1E1E),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    elevation: 4,
    margin: const EdgeInsets.all(8),
  ),

  // Divider
  dividerTheme: const DividerThemeData(
    color: Color(0xFF333333),
    thickness: 1,
    space: 1,
  ),

  // Dialog
  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xFF1E1E1E),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),

  // Input decorator (text fields)
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFF1E1E1E),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF333333)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF333333)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF6C5CE7), width: 2),
    ),
    labelStyle: const TextStyle(color: Colors.white70),
    hintStyle: const TextStyle(color: Colors.white54),
  ),

  // Floating action button
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF6C5CE7),
    foregroundColor: Colors.white,
    elevation: 6,
  ),

  // Scrollbar
  scrollbarTheme: ScrollbarThemeData(
    thumbColor: MaterialStateProperty.all<Color>(
        const Color(0xFF6C5CE7).withOpacity(0.7)),
    radius: const Radius.circular(8),
    thickness: MaterialStateProperty.all<double>(6),
  ),

  // Disabled state colors
  disabledColor: Colors.white24,
  unselectedWidgetColor: Colors.white38,

  // Icon themes
  iconTheme: const IconThemeData(color: Colors.white70),
  primaryIconTheme: const IconThemeData(color: Colors.white),

  // Popup menu
  popupMenuTheme: PopupMenuThemeData(
    color: const Color(0xFF1E1E1E),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    elevation: 8,
  ),
);
