import 'package:flutter/material.dart';
import 'package:votechain/core/styles.dart';

class CustomButtonDashboard extends StatelessWidget {
  const CustomButtonDashboard({
    super.key,
    this.onPressed,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.prefixIcon,
    this.width,
    this.height,
    this.padding,
  });

  final VoidCallback? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOutlined = false;
  final bool isTextButton = false;
  final IconData? prefixIcon;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final bool isDense = false;
  final bool isCompact = false;

  @override
  Widget build(BuildContext context) {
    var widget = _buildElevatedButton();
    if (isOutlined) {
      widget = _buildOutlinedButton();
    }

    if (isTextButton) {
      widget = _buildTextButton();
    }

    return Container(
      constraints: const BoxConstraints(
        minHeight: 50,
      ),
      width: width,
      height: height,
      child: widget,
    );
  }

  Widget _buildElevatedButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: padding,
      ),
      onPressed: onPressed,
      child: _buildContentWidget(),
    );
  }

  Widget _buildOutlinedButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        padding: padding,
        side: textColor == null ? null : BorderSide(color: textColor!),
      ),
      onPressed: onPressed,
      child: _buildContentWidget(),
    );
  }

  Widget _buildTextButton() {
    return TextButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        padding: padding,
      ),
      onPressed: onPressed,
      child: _buildContentWidget(),
    );
  }

  Widget _buildContentWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isCompact)
          SizedBox(
            width: isDense ? Styles.mediumSpacing : Styles.biggerPadding,
          ),
        if (prefixIcon != null)
          Icon(
            prefixIcon,
            color: textColor,
          ),
        const SizedBox(
          height: Styles.defaultSpacing,
        ),
        if (prefixIcon != null)
          const SizedBox(
            width: Styles.defaultSpacing,
          ),
        Flexible(
          child: Text(
            text,
            style: TextStyle(color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
        if (!isCompact)
          SizedBox(
            width: isDense ? Styles.mediumSpacing : Styles.biggerPadding,
          ),
      ],
    );
  }
}
