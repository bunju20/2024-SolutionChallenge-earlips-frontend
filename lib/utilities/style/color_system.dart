import 'package:flutter/material.dart';

class ColorSystem {
  // Tonal Palette
  static const Map<int, Color> _tonalPalette = {
    50: Color(0xFFE3F2FD),
    100: Color(0xFFBBDEFB),
    200: Color(0xFF90CAF9),
    300: Color(0xFF64B5F6),
    400: Color(0xFF42A0F2),
    500: Color(0xFF1DA1FA),
    600: Color(0xFF1A94E6),
    700: Color(0xFF1887D2),
    800: Color(0xFF157ABC),
    900: Color(0xFF126E99),
  };
  static const Color main = Color(0xFF1DA1FA);
  static const Color main2 = Color(0xFF1FA9DC);
  static const Color sub1 = Color(0xFF5588FD);
  static const Color sub2 = Color(0xFFC1D2FF);
  static const Color sub3 = Color(0xFFF1F5FE);

  // Basic Colors
  static Color primary = _tonalPalette[500]!;

  static Color secondary = _tonalPalette[200]!;
  static Color tertiary = _tonalPalette[100]!;
  static Color primaryVariant = _tonalPalette[600]!;
  static Color secondaryVariant = _tonalPalette[300]!;
  static Color tertiaryVariant = _tonalPalette[400]!;
  static const Color surface = Colors.white;
  static const Color onSurface = Colors.black;
  static const Color error = Colors.red;

  // Neutral Colors
  static const Color background = Color(0xFFF0F4F8);
  static const Color black = Color(0xFF151515);
  static const Color gray6 = Color(0xFF464655);
  static const Color gray5 = Color(0xFF626272);
  static const Color gray4 = Color(0xFF90909F);
  static const Color gray3 = Color(0xFFC6C6CF);
  static const Color gray2 = Color(0xFFE9E9EE);
  static const Color gray1 = Color(0xFFF5F5F9);
  static const Color white = Color(0xFFFFFFFF);

  // Semantic Colors
  static const Color success = Color(0xFF63DC68);
  static const Color warning = Color(0xFFFFC100);
  static const Color info = Color(0xFF1DA1FA);
  static const Color accent = Color(0xFFD81B60); // Example accent color

  // Color Getters
  static Color getFromTonalPalette(int index) {
    return _tonalPalette[index] ?? Colors.transparent;
  }

  // Material 3 ColorScheme Creation
  static ColorScheme createColorScheme({
    required Brightness brightness,
    Color? primary,
    Color? primaryVariant,
    Color? secondary,
    Color? secondaryVariant,
    Color? tertiary,
    Color? tertiaryVariant,
    Color? background,
    Color? surface,
    Color? onBackground,
    Color? onSurface,
    Color? error,
  }) {
    return ColorScheme(
      primary: primary ?? ColorSystem.primary,
      onPrimary: onSurface ?? ColorSystem.onSurface,
      secondary: secondary ?? ColorSystem.secondary,
      onSecondary: onSurface ?? ColorSystem.onSurface,
      surface: surface ?? ColorSystem.surface,
      onSurface: onSurface ?? ColorSystem.onSurface,
      background: background ?? ColorSystem.background,
      onBackground: onBackground ?? ColorSystem.onSurface,
      error: error ?? ColorSystem.error,
      onError: onSurface ?? ColorSystem.onSurface,
      brightness: brightness,
    );
  }

  static ColorScheme createLightColorScheme({
    Color? primary,
    Color? primaryVariant,
    Color? secondary,
    Color? secondaryVariant,
    Color? tertiary,
    Color? tertiaryVariant,
    Color? background,
    Color? surface,
    Color? onBackground,
    Color? onSurface,
    Color? error,
  }) {
    return createColorScheme(
      brightness: Brightness.light,
      primary: Colors.blue,
      primaryVariant: primaryVariant,
      secondary: secondary,
      secondaryVariant: secondaryVariant,
      tertiary: tertiary,
      tertiaryVariant: tertiaryVariant,
      background: background,
      surface: surface,
      onBackground: onBackground,
      onSurface: onSurface,
      error: error,
    );
  }

  // dark
  static ColorScheme createDarkColorScheme({
    Color? primary,
    Color? primaryVariant,
    Color? secondary,
    Color? secondaryVariant,
    Color? tertiary,
    Color? tertiaryVariant,
    Color? background,
    Color? surface,
    Color? onBackground,
    Color? onSurface,
    Color? error,
  }) {
    return createColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      primaryVariant: primaryVariant,
      secondary: secondary,
      secondaryVariant: secondaryVariant,
      tertiary: tertiary,
      tertiaryVariant: tertiaryVariant,
      background: background,
      surface: surface,
      onBackground: onBackground,
      onSurface: onSurface,
      error: error,
    );
  }

  // Generate ThemeData using ColorScheme
  static ThemeData generateThemeFromColorScheme(ColorScheme colorScheme) {
    return ThemeData.from(colorScheme: colorScheme);
  }
}
