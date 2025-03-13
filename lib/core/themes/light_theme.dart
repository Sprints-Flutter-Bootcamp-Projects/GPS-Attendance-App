import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gps_attendance/core/constants/colors.dart';
import 'package:gps_attendance/core/constants/text_styles.dart';
import 'package:gps_attendance/core/themes/text_theme.dart';

ThemeData lightTheme() {
  const colorScheme = ColorScheme.light(
    primary: TrackSyncColors.highlightDarkest,
    secondary: TrackSyncColors.darkDark,
    secondaryContainer: TrackSyncColors.highlightLightest,
    onSecondaryContainer: TrackSyncColors.highlightDarkest,
    surface: TrackSyncColors.lightLight,
    surfaceTint: TrackSyncColors.lightMedium,
    error: TrackSyncColors.errorDark,
    onPrimary: TrackSyncColors.darkDarkest,
    onSecondary: TrackSyncColors.lightMedium,
    onSurface: TrackSyncColors.darkLight,
    outline: TrackSyncColors.darkLightest,
    onError: TrackSyncColors.lightLightest,
  );

  return ThemeData(
    shadowColor: Colors.black12,
    dividerTheme: const DividerThemeData(
      color: TrackSyncColors.lightDarkest,
      thickness: 0.5,
    ),
    iconTheme: const IconThemeData(
      color: TrackSyncColors.highlightDarkest,
      size: 24,
    ),
    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (context) => const CustomBackIcon(),
    ),
    navigationBarTheme: NavigationBarThemeData(
      labelTextStyle: WidgetStatePropertyAll(
        TrackSyncTextStyles.actionM(color: TrackSyncColors.darkLight),
      ),
      backgroundColor: Colors.white,
      indicatorColor: Colors.transparent,
      elevation: 5,
      shadowColor: TrackSyncColors.lightLight,
    ),
    navigationRailTheme: NavigationRailThemeData(
      labelType: NavigationRailLabelType.selected,
      useIndicator: true,
      minWidth: 120,
      selectedIconTheme: IconThemeData(color: TrackSyncColors.highlightDarkest),
      unselectedIconTheme: IconThemeData(color: TrackSyncColors.darkLightest),
      selectedLabelTextStyle: TrackSyncTextStyles.actionM(
        color: TrackSyncColors.darkLight,
      ),
      unselectedLabelTextStyle: TrackSyncTextStyles.actionM(
        color: TrackSyncColors.darkLightest,
      ),
      backgroundColor: Colors.white,
      indicatorColor: Colors.transparent,
      elevation: 5,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: TrackSyncColors.lightLightest,
    ),
    disabledColor: TrackSyncColors.lightDark,
    splashColor: TrackSyncColors.highlightDark,
    dividerColor: TrackSyncColors.lightDarkest,
    cardColor: TrackSyncColors.lightLight,
    brightness: Brightness.light,
    primaryColor: TrackSyncColors.highlightDarkest,
    fontFamily: 'Inter',
    textTheme: customTextTheme(colorScheme),
    scaffoldBackgroundColor: TrackSyncColors.lightLightest,
    colorScheme: colorScheme,
    highlightColor: TrackSyncColors.highlightLightest,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: TrackSyncColors.highlightDarkest),
      elevation: 1,
      shadowColor: TrackSyncColors.lightLight,
      centerTitle: true,
      backgroundColor: Colors.white,
      titleTextStyle: TrackSyncTextStyles.h3(color: TrackSyncColors.darkDark),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: TrackSyncColors.highlightDarkest,
      unselectedItemColor: TrackSyncColors.darkLightest,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: TrackSyncColors.lightLightest,
    ),
  );
}

class CustomBackIcon extends StatelessWidget {
  const CustomBackIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(FontAwesomeIcons.chevronLeft);
  }
}
