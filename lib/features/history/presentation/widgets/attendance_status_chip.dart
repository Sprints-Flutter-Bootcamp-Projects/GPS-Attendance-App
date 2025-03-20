import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gps_attendance/core/constants/colors.dart';
import 'package:gps_attendance/widgets/ui_components/chip.dart';

enum AttendanceStatusEnum { regular, overtime, pending, absent }

class AttendanceStatusChip extends StatelessWidget {
  final AttendanceStatusEnum attendanceStatus;

  const AttendanceStatusChip({
    super.key,
    required this.attendanceStatus,
  });

  @override
  Widget build(BuildContext context) {
    switch (attendanceStatus) {
      case AttendanceStatusEnum.regular:
        return CustomChip(
          text: 'REGULAR',
          backgroundColor: TrackSyncColors.approved,
          icon: FontAwesomeIcons.check,
          padding: 5,
        );
      case AttendanceStatusEnum.overtime:
        return CustomChip(
          text: 'OVERTIME',
          backgroundColor: TrackSyncColors.pending,
          icon: FontAwesomeIcons.bolt,
          padding: 5,
        );
      case AttendanceStatusEnum.pending:
        return CustomChip(
          text: 'PENDING',
          backgroundColor: TrackSyncColors.darkLight,
          icon: FontAwesomeIcons.clock,
          padding: 5,
        );
      case AttendanceStatusEnum.absent:
        return CustomChip(
          text: 'ABSENT',
          backgroundColor: TrackSyncColors.errorMedium,
          icon: FontAwesomeIcons.xmark,
          padding: 5,
        );
    }
  }
}
