import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  final String btnText;
  final Size size;
  final void Function()? onPressed;
  final Color backgroundColor;

  const PrimaryBtn({
    super.key,
    required this.btnText,
    required this.size,
    this.onPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: size,
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        btnText,
        style: const TextStyle(
          color: Color(0xffFFFFFF),
        ),
      ),
    );
  }
}
