// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// This class holds all the design tokens for the Fairware Lift application,
/// directly translated from the Single Source of Truth (SSOT) document.
///
/// Using a class with static constants provides a single, authoritative source
/// for all UI constants, ensuring consistency and ease of maintenance.
///
/// Example Usage:
/// ```dart
/// Container(
///   color: AppTheme.colors.background,
///   child: Text('Hello', style: AppTheme.typography.body),
/// )
/// ```
class AppTheme {
  // Private constructor to prevent instantiation.
  AppTheme._();

  // ---------------------------------------------------------------------------
  // --- COLOR PALETTE (from SSOT 12.2) ----------------------------------------
  // ---------------------------------------------------------------------------
  static const _colors = _AppColors(
    background: Color(0xFF121216),
    surface: Color(0xFF1E1E24),
    surfaceAlt: Color(0xFF18181C),
    textPrimary: Color(0xFFEEF0F3),
    textSecondary: Color(0xFFB9BEC8),
    textMuted: Color(0xFF8C919B),
    accent: Color(0xFFBA39FF),
    accentPressed: Color(0xFFA02DDC),
    chipInfo: Color(0xFF231E2D),
    warning: Color(0xFFFFC857),
    danger: Color(0xFFF06272),
    infoBlue: Color(0xFF2AA1E9),
  );

  // ---------------------------------------------------------------------------
  // --- TYPOGRAPHY (from SSOT 12.3) -------------------------------------------
  // ---------------------------------------------------------------------------
  static final _typography = _AppTypography(
    display: TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w600, // Semibold
      color: _colors.textPrimary,
    ),
    title: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500, // Medium
      color: _colors.textPrimary,
    ),
    body: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400, // Regular
      color: _colors.textSecondary,
    ),
    caption: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400, // Regular
      color: _colors.textMuted,
    ),
    // Specialty style for large numbers like weights, reps, timers.
    number: TextStyle(
      fontSize: 34, // Using a value between 28-40
      fontWeight: FontWeight.w600, // Semibold
      color: _colors.textPrimary,
    ),
  );

  // ---------------------------------------------------------------------------
  // --- COMPONENTS & SIZING (from SSOT 12.4 & 12.7) ---------------------------
  // ---------------------------------------------------------------------------
  static const _sizing = _AppSizing(
    cardRadius: 16.0,
    buttonRadius: 20.0,
    chipRadius: 14.0,
    touchTargetMinimum: 44.0,
    baseGrid: 8.0,
    verticalRhythm: 24.0,
  );

  // ---------------------------------------------------------------------------
  // --- PUBLIC ACCESSORS ------------------------------------------------------
  // ---------------------------------------------------------------------------
  // These are the public getters that the rest of the app will use.
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
  });

  // Backgrounds
  final Color background;
  final Color surface;
  final Color surfaceAlt;

  // Text
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;

  // Accent
  final Color accent;
  final Color accentPressed;

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