import 'package:flutter/material.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/utils/extensions.dart';
import 'package:votechain/utils/validator.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    super.key,
    this.hintText,
    this.prefixIcon,
    this.fillColor,
    this.borderWidth = 1,
    this.label,
    this.isRequired = true,
    this.validator,
    this.onChanged,
    this.maxCharacter,
    this.maxLines = 1,
    this.style,
    this.autofocus = false,
    this.expands = false,
    this.enabled = true,
    this.focusNode,
    this.suffixIcon,
    this.borderColor, this.textInputType,
  });

  final TextEditingController controller;
  final String? hintText;
  final String? label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final double borderWidth;
  final bool isRequired;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final int? maxCharacter;
  final int? maxLines;
  final TextStyle? style;
  final bool autofocus;
  final bool expands;
  final bool enabled;
  final FocusNode? focusNode;
  final TextInputType? textInputType;

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
        enabled
            ? _buildBody(context, border)
            : AbsorbPointer(
                child: _buildBody(context, border),
              ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, OutlineInputBorder border) {
    return TextFormField(
      expands: expands,
      enabled: enabled,
      focusNode: focusNode,
      autofocus: autofocus,
      maxLength: maxCharacter,
      controller: controller,
      onChanged: onChanged,
      maxLines: maxLines,
      keyboardType: textInputType,
      validator: isRequired
          ? (validator ?? Validator(context: context).emptyValidator)
          : validator,
      style: style ?? context.textTheme.bodyMedium,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
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
        suffixIcon: suffixIcon == null
            ? null
            : Icon(
                suffixIcon,
                size: 24,
                color: ColorValues.grey90,
              ),
        suffixIconConstraints: suffixIcon == null
            ? null
            : const BoxConstraints(
                minWidth: 58,
              ),
      ),
    );
  }
}
