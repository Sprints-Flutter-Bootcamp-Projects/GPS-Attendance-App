import 'package:flutter/material.dart';
import 'package:gps_attendance/core/constants/text_styles.dart';

TextTheme customTextTheme(ColorScheme colorScheme) {
  return TextTheme(
    displayLarge: TrackSyncTextStyles.h1(color: colorScheme.onPrimary),
    displayMedium: TrackSyncTextStyles.h2(color: colorScheme.onPrimary),
    displaySmall: TrackSyncTextStyles.h3(color: colorScheme.onPrimary),
    headlineLarge: TrackSyncTextStyles.h4(color: colorScheme.onPrimary),
    headlineMedium: TrackSyncTextStyles.h5(color: colorScheme.onPrimary),

    headlineSmall: TrackSyncTextStyles.bodyXL(color: colorScheme.onSurface),
    titleLarge: TrackSyncTextStyles.bodyL(color: colorScheme.onSurface),
    titleMedium: TrackSyncTextStyles.bodyM(color: colorScheme.onSurface),
    titleSmall: TrackSyncTextStyles.bodyS(color: colorScheme.onSurface),
    bodyLarge: TrackSyncTextStyles.bodyXL(color: colorScheme.onSurface),
    bodyMedium: TrackSyncTextStyles.bodyL(color: colorScheme.onSurface),
    bodySmall: TrackSyncTextStyles.bodyS(color: colorScheme.onSurface),

    labelLarge: TrackSyncTextStyles.actionL(color: colorScheme.secondary),
    labelMedium: TrackSyncTextStyles.actionM(color: colorScheme.secondary),
    labelSmall: TrackSyncTextStyles.actionS(color: colorScheme.secondary),
  );
}
