import 'package:flutter/material.dart';
import 'package:votechain/core/color_values.dart';
import 'package:votechain/core/styles.dart';
import 'package:votechain/widgets/custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    required this.title,
    super.key,
    this.description,
    this.descriptionWidget,
    this.proceedText,
    this.proceedAction,
    this.proceedButtonColor,
    this.cancelText,
  });

  final String title;
  final String? description;
  final Widget? descriptionWidget;
  final String? proceedText;
  final String? cancelText;
  final void Function()? proceedAction;
  final Color? proceedButtonColor;

  @override
  Widget build(BuildContext context) {
    final Widget proceedButton = CustomButton(
      backgroundColor: proceedButtonColor,
      isCompact: true,
      onPressed: () {
        Navigator.of(context).pop();
        proceedAction?.call();
      },
      text: proceedText ?? 'Ya',
    );

    final Widget cancelButton = CustomButton(
      onPressed: () => Navigator.of(context).pop(),
      text: cancelText ?? 'Tidak',
      isOutlined: true,
      isCompact: true,
      textColor: ColorValues.primary50,
    );

    final alert = Center(
      child: SingleChildScrollView(
        child: AlertDialog(
          surfaceTintColor: ColorValues.white,
          backgroundColor: ColorValues.white,
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              descriptionWidget ??
                  Text(
                    description ?? '',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
              const SizedBox(
                height: Styles.bigSpacing,
              ),
              Row(
                children: [
                  if (proceedAction != null) Expanded(child: cancelButton),
                  if (proceedAction != null)
                    const SizedBox(
                      width: Styles.defaultSpacing,
                    ),
                  Expanded(child: proceedButton),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return alert;
  }
}
