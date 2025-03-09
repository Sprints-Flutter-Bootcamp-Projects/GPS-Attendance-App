import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class Input extends StatefulWidget {
  final String? title;
  final String hintText;
  final IconData? icon;
  final String? supportText;
  final bool isPassword;
  final TextEditingController? controller;
  final bool disabled;
  final String? Function(String?)? validator;
  final int? maxLines;
  final TextInputType keyboardType;

  const Input({
    super.key,
    this.title,
    required this.hintText,
    this.icon,
    this.supportText,
    this.isPassword = false,
    this.controller,
    this.disabled = false,
    this.validator,
    this.maxLines,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    isPasswordVisible = widget.isPassword;
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
         
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines ?? 1,
          enabled: !widget.disabled,
          controller: widget.controller,
          style: Theme.of(context).textTheme.bodySmall,
          cursorColor: TrackSyncColors.highlightDarkest,
          obscureText: widget.isPassword && isPasswordVisible,
          validator: widget.validator,
          decoration: InputDecoration(
            enabled: !widget.disabled,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.error,
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
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).disabledColor,
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
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      !isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: widget.disabled
                          ? Theme.of(context).disabledColor
                          : Theme.of(context).dividerColor,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : Icon(
                    widget.icon,
                    color: widget.disabled
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).dividerColor,
                    size: 16,
                  ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ),
        if (widget.supportText != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(widget.supportText!,
                style: Theme.of(context).textTheme.bodySmall),
          ),
      ],
    );
  }
}
