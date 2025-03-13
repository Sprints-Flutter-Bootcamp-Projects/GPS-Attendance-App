import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class TrackSyncButton extends StatelessWidget {
  final String? text;
  final Color textColor;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final bool isFilled;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool disabled;

  const TrackSyncButton({
    super.key,
    this.text,
    this.textColor = TrackSyncColors.lightLightest,
    this.backgroundColor = TrackSyncColors.highlightDarkest,
    this.onPressed,
    this.isFilled = true,
    this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
    this.borderRadius = 12.0,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return isFilled
        ? ElevatedButton(
            onPressed: disabled ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  disabled ? Theme.of(context).dividerColor : backgroundColor,
              padding: padding,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: Text(text ?? '',
                style: TrackSyncTextStyles.actionM(color: textColor)),
          )
        : OutlinedButton(
            onPressed: disabled ? null : onPressed,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                  color: disabled
                      ? Theme.of(context).dividerColor
                      : backgroundColor,
                  width: 1.5),
              padding: padding,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: Text(text ?? '',
                style: TrackSyncTextStyles.actionM(
                    color: disabled
                        ? Theme.of(context).dividerColor
                        : backgroundColor)),
          );
  }
}
