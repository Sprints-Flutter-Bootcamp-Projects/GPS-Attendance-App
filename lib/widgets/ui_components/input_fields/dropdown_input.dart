import 'package:flutter/material.dart';
import '../../../core/constants/text_styles.dart';

class DropdownInput extends StatefulWidget {
  final String? title;
  final String hintText;
  final List<String> items;
  final String? supportText;
  final bool disabled;
  final TextEditingController controller;
  final void Function(String?)? onSelected;

  const DropdownInput({
    super.key,
    this.title,
    required this.hintText,
    required this.items,
    this.supportText,
    this.disabled = false,
    required this.controller,
    this.onSelected,
  });

  @override
  State<DropdownInput> createState() => _DropdownInputState();
}

class _DropdownInputState extends State<DropdownInput> {
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem =
        widget.controller.text.isNotEmpty ? widget.controller.text : null;
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
        DropdownMenu(
          onSelected: widget.onSelected,
          width: MediaQuery.of(context).size.width * 0.5,
          expandedInsets: EdgeInsets.zero,
          selectedTrailingIcon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).primaryColor,
          ),
          trailingIcon: Icon(
            Icons.keyboard_arrow_down,
            color: Theme.of(context).dividerColor,
          ),
          inputDecorationTheme: InputDecorationTheme(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            constraints: BoxConstraints(
              minHeight: 0,
              maxHeight: 48.0,
            ),
            isDense: true,
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
          ),
          menuStyle: MenuStyle(
            padding: const WidgetStatePropertyAll(EdgeInsets.all(0.0)),
            elevation: const WidgetStatePropertyAll(2.0),
            shadowColor: WidgetStatePropertyAll(Theme.of(context).dividerColor),
            alignment: Alignment.bottomCenter,
            side: WidgetStatePropertyAll(BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.5,
            )),
            backgroundColor: WidgetStatePropertyAll(Theme.of(context)
                .scaffoldBackgroundColor
                .withValues(alpha: 0.95)),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
          controller: widget.controller,
          textStyle: Theme.of(context).textTheme.bodySmall,
          hintText: widget.hintText,
          enabled: !widget.disabled,
          dropdownMenuEntries: [
            for (var item in widget.items)
              DropdownMenuEntry(
                style: ButtonStyle(
                  textStyle: WidgetStatePropertyAll(
                    Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                label: item,
                value: item,
              )
          ],
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
