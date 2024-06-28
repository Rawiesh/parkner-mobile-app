import 'package:flutter/material.dart';

class GuestButton extends StatelessWidget {
  final VoidCallback onPress;
  const GuestButton({super.key, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(250, 50),
        backgroundColor: const Color(0xffD7E8E5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: onPress,
      child: const Text(
        "Continue as guest",
        style: TextStyle(
          color: Color(0xff38403E),
        ),
      ),
    );
  }
}
