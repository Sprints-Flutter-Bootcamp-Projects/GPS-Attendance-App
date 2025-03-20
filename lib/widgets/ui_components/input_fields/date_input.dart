import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/text_styles.dart';

class DateInput extends StatefulWidget {
  final String? title;
  final String hintText;
  final String? supportText;
  final bool disabled;
  final TextEditingController? controller;

  const DateInput({
    super.key,
    this.title,
    required this.hintText,
    this.supportText,
    this.disabled = false,
    this.controller,
  });

  @override
  State<DateInput> createState() => _DateInputState();
}

class _DateInputState extends State<DateInput> {
  final DateFormat _dateFormat = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    if (widget.disabled) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).brightness == Brightness.dark
              ? ThemeData.dark().copyWith(
                  colorScheme: const ColorScheme.dark(
                    primary: TrackSyncColors
                        .highlightDarkest, // Header background color
                    onPrimary: TrackSyncColors.darkDarkest, // Header text color
                    onSurface: TrackSyncColors.lightLightest, // Body text color
                  ),
                  dividerColor: TrackSyncColors.darkMedium,
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          TrackSyncColors.lightLightest, // Button text color
                      backgroundColor: TrackSyncColors
                          .highlightDarkest, // Button background color
                    ),
                  ),
                )
              : ThemeData.light().copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: TrackSyncColors
                        .highlightDarkest, // Header background color
                    onPrimary:
                        TrackSyncColors.lightLightest, // Header text color
                    onSurface: TrackSyncColors.darkDarkest, // Body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          TrackSyncColors.lightLightest, // Button text color
                      backgroundColor: TrackSyncColors
                          .highlightDarkest, // Button background color
                    ),
                  ),
                ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        widget.controller!.text = _dateFormat.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(widget.title!,
                style: Theme.of(context).textTheme.labelMedium),
          ),
        TextFormField(
          enabled: !widget.disabled,
          controller: widget.controller,
          style: Theme.of(context).textTheme.bodySmall,
          cursorColor: TrackSyncColors.highlightDarkest,
          decoration: InputDecoration(
            enabled: !widget.disabled,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).disabledColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            border: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor, width: 1.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            hintText: widget.hintText,
            suffixIcon: IconButton(
              icon: Icon(
                FontAwesomeIcons.calendar,
                color: widget.disabled
                    ? Theme.of(context).disabledColor
                    : Theme.of(context).dividerColor,
              ),
              onPressed: () => _selectDate(context),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: TrackSyncColors.highlightDarkest, width: 1.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
          readOnly: true,
          onTap: () => _selectDate(context),
        ),
        if (widget.supportText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child:
                Text(widget.supportText!, style: TrackSyncTextStyles.bodyS()),
          ),
      ],
    );
  }
}
