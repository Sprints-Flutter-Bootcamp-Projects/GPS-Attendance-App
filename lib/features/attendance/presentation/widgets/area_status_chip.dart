import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gps_attendance/core/constants/colors.dart';
import 'package:gps_attendance/widgets/ui_components/chip.dart';

enum UserWithinAreaStatus { withinArea, outsideArea, pending }

class AreaStatusChip extends StatelessWidget {
  final UserWithinAreaStatus userWithinAreaStatus;

  const AreaStatusChip({
    super.key,
    required this.userWithinAreaStatus,
  });

  @override
  Widget build(BuildContext context) {
    switch (userWithinAreaStatus) {
      case UserWithinAreaStatus.withinArea:
        return CustomChip(
          text: 'WITHIN AREA',
          backgroundColor: TrackSyncColors.approved,
          icon: FontAwesomeIcons.check,
          padding: 5,
        );
      case UserWithinAreaStatus.outsideArea:
        return CustomChip(
          text: 'OUTSIDE AREA',
          backgroundColor: TrackSyncColors.errorDark,
          icon: FontAwesomeIcons.xmark,
          padding: 5,
        );
      case UserWithinAreaStatus.pending:
        return CustomChip(
          text: 'PENDING',
          backgroundColor: TrackSyncColors.pending,
          icon: Icons.pending,
          padding: 5,
        );
    }
  }
}
