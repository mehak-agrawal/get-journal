import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

import '../constants/colors.dart';
import '../utilities/size_helper.dart';

class ReusableButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const ReusableButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(
        milliseconds: 200,
      ),
      onPressed: () {
        onTap();
      },
      child: Container(
        width: SizeHelper(context).width * 0.75,
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: kPrimaryBlue,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}
