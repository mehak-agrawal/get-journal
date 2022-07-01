import 'package:flutter/material.dart';

import '../../../global/constants/colors.dart';

class ProfileAction extends StatelessWidget {
  final IconData leadingIcon;
  final Widget trailingIcon;
  final String text;
  final Function action;

  const ProfileAction({
    Key? key,
    required this.leadingIcon,
    required this.trailingIcon,
    required this.text,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(
          leadingIcon,
          color: kPrimaryBlue,
          size: 50.0,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 40.0,
          ),
        ),
        GestureDetector(
          child: trailingIcon,
          onTap: () {
            action();
          },
        ),
      ],
    );
  }
}
