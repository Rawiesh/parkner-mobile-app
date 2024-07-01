import 'package:flutter/material.dart';

class PrimaryBtn extends StatelessWidget {
  final String btnText;
  final Size size;
  final void Function()? onPressed;
  const PrimaryBtn({
    super.key,
    required this.btnText,
    required this.size,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: size,
        backgroundColor: const Color(0xff358C7C),
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
