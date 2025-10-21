// lib/src/core/theme/app_theme.dart

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// This class holds all the design tokens for the Fairware Lift application.
class AppTheme {
  // Private constructor to prevent instantiation.
  AppTheme._();

  // ---------------------------------------------------------------------------
  // --- COLOR PALETTE ---------------------------------------------------------
  // ---------------------------------------------------------------------------
  static const _colors = _AppColors(
    background: Color(0xFF0f0f0f), // Updated to match design
    surface: Color(0xFF1E1E24),
    surfaceAlt: Color(0xFF181818),
    textPrimary: Color(0xFFEEF0F3),
    textSecondary: Color(0xFFB9BEC8),
    textMuted: Color(0xFF8C919B),
    accent: Color(0xFFBA39FF),
    accentPressed: Color(0xFFA02DDC),
    chipInfo: Color(0xFF231E2D),
    warning: Color(0xFFFFC857),
    danger: Color(0xFFF06272),
    infoBlue: Color(0xFF2AA1E9),

    // --- NEW: Prompt Studio Accent Colors ---
    accentRust: Color(0xFFD26B35),
    accentTeal: Color(0xFF00BFFF), // Placeholder
    accentSilver: Color(0xFFC0C0C0), // Placeholder
  );

  // ---------------------------------------------------------------------------
  // --- TYPOGRAPHY ------------------------------------------------------------
  // ---------------------------------------------------------------------------
  static final _typography = _AppTypography(
    display: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w600,
      color: _colors.textPrimary,
    ),
    title: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      color: _colors.textPrimary,
    ),
    body: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: _colors.textSecondary,
    ),
    caption: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: _colors.textMuted,
    ),
    number: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w600,
      color: _colors.textPrimary,
    ),
  );

  // ---------------------------------------------------------------------------
  // --- COMPONENTS & SIZING ---------------------------------------------------
  // ---------------------------------------------------------------------------
  static const _sizing = _AppSizing(
    cardRadius: 20.0, // Updated to match design (radius.lg)
    buttonRadius: 20.0,
    chipRadius: 14.0,
    touchTargetMinimum: 44.0,
    baseGrid: 8.0,
    verticalRhythm: 24.0,
  );

  // ---------------------------------------------------------------------------
  // --- PUBLIC ACCESSORS ------------------------------------------------------
  // ---------------------------------------------------------------------------
  static _AppColors get colors => _colors;
  static _AppTypography get typography => _typography;
  static _AppSizing get sizing => _sizing;
}

// --- Private helper classes for organization ---

class _AppColors {
  const _AppColors({
    required this.background,
    required this.surface,
    required this.surfaceAlt,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.accent,
    required this.accentPressed,
    required this.chipInfo,
    required this.warning,
    required this.danger,
    required this.infoBlue,
    required this.accentRust,
    required this.accentTeal,
    required this.accentSilver,
  });

  // Backgrounds
  final Color background;
  final Color surface;
  final Color surfaceAlt;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  // Main Accent
  final Color accent;
  final Color accentPressed;

  // Prompt Studio Accents
  final Color accentRust;
  final Color accentTeal;
  final Color accentSilver;

  // Components
  final Color chipInfo;

  // Status
  final Color warning;
  final Color danger;
  final Color infoBlue;
}

class _AppTypography {
  const _AppTypography({
    required this.display,
    required this.title,
    required this.body,
    required this.caption,
    required this.number,
  });

  final TextStyle display;
  final TextStyle title;
  final TextStyle body;
  final TextStyle caption;
  final TextStyle number;
}

class _AppSizing {
  const _AppSizing({
    required this.cardRadius,
    required this.buttonRadius,
    required this.chipRadius,
    required this.touchTargetMinimum,
    required this.baseGrid,
    required this.verticalRhythm,
  });

  final double cardRadius;
  final double buttonRadius;
  final double chipRadius;
  final double touchTargetMinimum;
  final double baseGrid;
  final double verticalRhythm;
}