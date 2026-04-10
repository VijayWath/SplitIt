import 'package:flutter/material.dart';

final lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Samsung blue
  primary: Color(0xFF1A73E8),
  onPrimary: Colors.white,

  secondary: Color(0xFF5F6368),
  onSecondary: Colors.white,

  error: Color(0xFFD93025),
  onError: Colors.white,

  // Soft background (not pure white)
  background: Color(0xFFF7F8FA),
  onBackground: Colors.black,

  surface: Colors.white,
  onSurface: Colors.black,

  // Optional accent
  tertiary: Color(0xFF03DAC6),
  onTertiary: Colors.black,

  // Subtle UI surfaces
  surfaceVariant: Color(0xFFF1F3F4),
  onSurfaceVariant: Color(0xFF5F6368),

  outline: Color(0xFFE0E0E0),
);

final darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Softer Samsung blue for dark mode
  primary: Color(0xFF8AB4F8),
  onPrimary: Colors.black,

  secondary: Color(0xFFBDC1C6),
  onSecondary: Colors.black,

  error: Color(0xFFF28B82),
  onError: Colors.black,

  // Samsung dark (not AMOLED black)
  background: Color(0xFF121212),
  onBackground: Colors.white,

  surface: Colors.black, //Color(0xFF1E1E1E),
  onSurface: Colors.white,

  tertiary: Color(0xFF03DAC6),
  onTertiary: Colors.black,

  surfaceVariant: Color(0xFF2A2A2A),
  onSurfaceVariant: Color(0xFFBDC1C6),

  outline: Color(0xFF3A3A3A),
);
