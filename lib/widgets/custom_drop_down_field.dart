import 'package:flutter/material.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:votechain/utils/validator.dart';

class CustomDropDownField extends StatelessWidget {
  const CustomDropDownField({
    super.key,
    required this.items,
    this.value,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.fillColor,
    this.borderColor,
    required this.borderWidth,
    required this.isRequired,
    this.validator,
    this.onChanged,
    this.style,
    this.icon,
    this.iconColor,
  });

  final List<DropdownMenuItem<String>> items;
  final String? value;
  final String? hintText;
  final String? label;
  final IconData? prefixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final double borderWidth;
  final bool isRequired;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final TextStyle? style;
  final IconData? icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        Styles.defaultBorder,
      ),
      borderSide: BorderSide(
        color: borderColor ??
            (borderWidth == 0 ? Colors.transparent : ColorValues.grey10),
        width: borderWidth,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: context.textTheme.titleMedium,
          ),
        if (label != null)
          const SizedBox(
            height: Styles.defaultSpacing,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Styles.biggerPadding),
          child: DropdownButtonFormField(
            icon: icon == null
                ? null
                : Icon(
                    icon,
                    size: 24,
                    color: iconColor,
                  ),
            iconEnabledColor: iconColor,
            value: value,
            items: items,
            onChanged: onChanged,
            validator: isRequired
                ? (validator ??
                    (value) => Validator(context: context)
                        .emptyValidator(value?.toString()))
                : validator,
            style: style ?? context.textTheme.bodyMedium,
            decoration: InputDecoration(
              isDense: true,
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
              filled: fillColor != null,
              fillColor: fillColor,
              hintStyle: context.textTheme.labelSmallThin,
              border: border,
              enabledBorder: border,
              focusedErrorBorder: border,
              focusedBorder: border,
              errorBorder: border,
              disabledBorder: border,
              prefixIconConstraints: prefixIcon == null
                  ? null
                  : const BoxConstraints(
                      minWidth: 58,
                    ),
              prefixIcon: prefixIcon == null
                  ? null
                  : Icon(
                      prefixIcon,
                      size: 24,
                      color: ColorValues.grey90,
                    ),
              prefixIconColor: MaterialStateColor.resolveWith(
                (states) => states.contains(MaterialState.focused)
                    ? Theme.of(context).primaryColor
                    : ColorValues.grey50,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
