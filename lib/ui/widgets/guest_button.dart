import 'package:flutter/material.dart';

class GuestButton extends StatelessWidget {
  const GuestButton({super.key});

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
      onPressed: () {},
      child: const Text(
        "Continue as guest",
        style: TextStyle(
          color: Color(0xff38403E),
        ),
      ),
    );
  }
}
