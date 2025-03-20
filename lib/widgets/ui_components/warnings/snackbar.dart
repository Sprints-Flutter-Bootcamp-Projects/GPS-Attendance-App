import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gps_attendance/core/constants/colors.dart';


enum SnackbarType { info, warning, error, success }

class TrackSyncSnackbar {
  static void show(BuildContext context, dynamic message, SnackbarType type) {
    Color backgroundColor;
    IconData icon;
    Color iconColor;

    switch (type) {
      case SnackbarType.info:
        backgroundColor = TrackSyncColors.highlightLightest;
        icon = FontAwesomeIcons.circleInfo;
        iconColor = TrackSyncColors.highlightDarkest;
        break;
      case SnackbarType.warning:
        backgroundColor = TrackSyncColors.warningLight;
        icon = FontAwesomeIcons.triangleExclamation;
        iconColor = TrackSyncColors.warningDark;
        break;
      case SnackbarType.error:
        backgroundColor = TrackSyncColors.errorLight;
        icon = FontAwesomeIcons.circleExclamation;
        iconColor = TrackSyncColors.errorDark;
        break;
      case SnackbarType.success:
        backgroundColor = TrackSyncColors.successLight;
        icon = FontAwesomeIcons.solidCircleCheck;
        iconColor = TrackSyncColors.successDark;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        margin: const EdgeInsets.all(8),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        showCloseIcon: true,
        closeIconColor: iconColor,
        backgroundColor: backgroundColor.withValues(alpha: 0.95),
        elevation: 0.25,
        content: Row(
          spacing: 8,
          children: [
            Icon(icon, color: iconColor),
            Expanded(
              child: Text(
                message.toString(),
                style: TextStyle(
                  color: iconColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
