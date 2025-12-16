import 'package:flutter/material.dart';
import 'package:koperasitenantapp/themes/colors.dart';

class PrimaryButton extends StatelessWidget {
  PrimaryButton({
    super.key,
    required this.onPress,
    required this.label,
    this.icon,
    this.style = const ButtonStyle(),
  });

  final Function onPress;
  final String label;
  final Widget? icon;
  final ButtonStyle? style;

  final ButtonStyle defaultButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(CustomColor.primaryColor),
    foregroundColor: WidgetStateProperty.all(CustomColor.whiteColor),
  );

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () => onPress(),
      style: defaultButtonStyle.copyWith(maximumSize: style?.maximumSize),
      icon: icon,
      label: Text(label),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  SecondaryButton({
    super.key,
    required this.onPress,
    required this.label,
    this.icon,
    this.style = const ButtonStyle(),
  });

  final Function onPress;
  final String label;
  final Widget? icon;
  final ButtonStyle? style;

  final defaultButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(CustomColor.whiteColor),
    foregroundColor: WidgetStateProperty.all(CustomColor.primaryColor),
    side: WidgetStateProperty.all(BorderSide(color: CustomColor.primaryColor)),
  );

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => onPress(),
      style: defaultButtonStyle.copyWith(maximumSize: style?.maximumSize),
      icon: icon,
      label: Text(label),
    );
  }
}
