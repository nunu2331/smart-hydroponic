import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary
  static const Color primary = Color(0xFF16A34A);
  static const Color primary2 = Color(0xFF16A34A);
  static const Color primary3 = Color(0xFF4ADE80);
  static const Color primary4 = Color(0xFFDCFCE7);

  // Secondary
  static const Color secondary = Color(0xFFCBD5F5);
  static const Color secondary2 = Color(0xFFE2E8F0);
  static const Color secondary3 = Color(0xFFF1F5F9);
  static const Color secondary4 = Color(0xFFFFFFFF);

  // Button
  static const Color btnPrimary = Color(0xFF22C55E);
  static const Color btnHover = Color(0xFF16A34A);
  static const Color btnDisable = Color(0xFF94A3B8);
  static const Color btnDanger = Color(0xFFEF4444);

  // Text
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);

  // Semantic / chart (existing screens)
  static const Color phBlue = Color(0xFF3498DB);
  static const Color tdsPurple = Color(0xFF9B59B6);
  static const Color uvOrange = Color(0xFFF39C12);

  // Aliases — map lama ke token baru
  static const Color primaryDark = btnHover;
  static const Color mint = primary4;
  static const Color background = secondary3;
  static const Color card = secondary2;
  static const Color white = secondary4;
  static const Color danger = btnDanger;
  static const Color border = secondary2;
}
