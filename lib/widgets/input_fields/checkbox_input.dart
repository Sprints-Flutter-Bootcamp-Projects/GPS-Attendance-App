import 'package:flutter/cupertino.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/text_styles.dart';

class CheckboxInput extends StatefulWidget {
  final String? text;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const CheckboxInput({
    super.key,
    this.text,
    this.value = false,
    this.onChanged,
  });

  @override
  State<CheckboxInput> createState() => _CheckboxInputState();
}

class _CheckboxInputState extends State<CheckboxInput> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Transform.scale(
          scale: 1.25,
          child: SizedBox(
            height: 24,
            width: 24,
            child: CupertinoCheckbox(
              activeColor: TrackSyncColors.highlightDarkest,
              value: isChecked,
              onChanged: (bool? newValue) {
                setState(() {
                  isChecked = newValue ?? false;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(isChecked);
                }
              },
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            widget.text ?? '',
            style: TrackSyncTextStyles.bodyM(color: TrackSyncColors.darkLight),
          ),
        ),
      ],
    );
  }
}
