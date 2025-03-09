import 'package:flutter/material.dart';
import 'package:gps_attendance/core/constants/colors.dart';
import 'package:gps_attendance/core/constants/text_styles.dart';
import 'package:gps_attendance/core/themes/light_theme.dart';
import 'package:gps_attendance/core/themes/text_theme.dart';


ThemeData darkTheme() {
  const colorScheme = ColorScheme.dark(
    primary: TrackSyncColors.highlightDark,
    secondary: TrackSyncColors.darkLight,
    secondaryContainer: TrackSyncColors.highlightDark,
    onSecondaryContainer: TrackSyncColors.highlightMedium,
    surface: TrackSyncColors.darkDarkest,
    surfaceTint: TrackSyncColors.darkDark,
    error: TrackSyncColors.errorDark,
    onPrimary: TrackSyncColors.lightLightest,
    onSecondary: TrackSyncColors.darkMedium,
    onSurface: TrackSyncColors.darkLight,
    outline: TrackSyncColors.darkLight,
    onError: TrackSyncColors.lightLightest,
  );

  return ThemeData(
    shadowColor: Colors.white12,
    iconTheme: const IconThemeData(
      color: TrackSyncColors.highlightDark,
      size: 24,
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => CustomBackIcon(),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: TrackSyncColors.darkDarkest,
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStatePropertyAll(
        TrackSyncTextStyles.actionM(color: TrackSyncColors.darkDark),
      ),
      backgroundColor: Colors.black,
      indicatorColor: Colors.transparent,
      elevation: 5,
      shadowColor: TrackSyncColors.lightDarkest,
    ),
    dividerTheme: const DividerThemeData(
      color: TrackSyncColors.darkDark,
      thickness: 0.5,
    ),
    disabledColor: TrackSyncColors.darkDark,
    splashColor: TrackSyncColors.highlightDarkest,
    dividerColor: TrackSyncColors.darkDark,
    brightness: Brightness.dark,
    primaryColor: TrackSyncColors.highlightDarkest,
    cardColor: TrackSyncColors.darkDarkest,
    fontFamily: 'Inter',
    textTheme: customTextTheme(colorScheme),
    colorScheme: colorScheme,
    highlightColor: Colors.deepOrangeAccent[700]!.withAlpha(50),
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: TrackSyncColors.highlightDarkest),
      elevation: 1,
      shadowColor: TrackSyncColors.darkMedium,
      centerTitle: true,
      backgroundColor: Colors.black87,
      titleTextStyle: TrackSyncTextStyles.h3(color: TrackSyncColors.lightLight),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.black,
      selectedItemColor: TrackSyncColors.highlightDark,
      unselectedItemColor: TrackSyncColors.darkMedium,
    ),
    navigationRailTheme: NavigationRailThemeData(
      labelType: NavigationRailLabelType.selected,
      useIndicator: true,
      minWidth: 120,
      selectedIconTheme: const IconThemeData(
        color: TrackSyncColors.highlightDark,
      ),
      unselectedIconTheme: const IconThemeData(
        color: TrackSyncColors.darkLightest,
      ),
      selectedLabelTextStyle: TrackSyncTextStyles.actionM(
        color: TrackSyncColors.darkLight,
      ),
      unselectedLabelTextStyle: TrackSyncTextStyles.actionM(
        color: TrackSyncColors.darkLightest,
      ),
      backgroundColor: Colors.black,
      indicatorColor: Colors.transparent,
      elevation: 5,
    ),
    dialogTheme: DialogThemeData(backgroundColor: TrackSyncColors.darkDarkest),
  );
}
