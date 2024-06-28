import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(250, 50),
        backgroundColor: const Color(0xff358C7C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
      onPressed: () {},
      child: const Text(
        "Login",
        style: TextStyle(
          color: Color(0xffFFFFFF),
        ),
      ),
    );
  }
}
