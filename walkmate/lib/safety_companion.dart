import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SafetyCompanionPage extends StatelessWidget {
  const SafetyCompanionPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.black,

      body: Center(
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}