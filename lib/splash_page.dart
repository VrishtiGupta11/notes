import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  navigateToHome(BuildContext context) {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/editor');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('notes.png'),
          ],
        ),
      ),
    );
  }
}