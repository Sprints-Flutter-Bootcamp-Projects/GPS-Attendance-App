import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LocationInput extends StatelessWidget {
  final void Function()? onTap;
  final String? title;
  final String text;
  final IconData icon;
  const LocationInput({
    super.key,
    required this.text,
    this.title,
    this.onTap,
    this.icon = FontAwesomeIcons.locationDot,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(title!, style: Theme.of(context).textTheme.labelMedium),
          ),
        InkWell(
          borderRadius: BorderRadius.circular(12.0),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            constraints: const BoxConstraints(minHeight: 52.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Icon(icon, color: Theme.of(context).dividerColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
