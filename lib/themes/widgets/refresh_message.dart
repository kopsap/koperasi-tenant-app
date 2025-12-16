import 'package:flutter/material.dart';
import 'package:koperasitenantapp/themes/widgets/buttons.dart';

class RefreshMessage extends StatelessWidget {
  const RefreshMessage({
    super.key,
    required this.onPress,
    required this.message,
  });

  final Function onPress;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(message, style: Theme.of(context).textTheme.labelLarge),
          PrimaryButton(
            onPress: () => onPress(),
            label: "Refresh",
            icon: Icon(Icons.refresh),
            style: ButtonStyle(
              maximumSize: WidgetStateProperty.all(Size(120.0, 40.0)),
            ),
          ),
        ],
      ),
    );
  }
}
