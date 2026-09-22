import 'package:flutter/material.dart';
import 'sos_page.dart';
import 'dart:async';

class SafetyCompanionPage extends StatefulWidget {
  const SafetyCompanionPage({super.key});

  @override
  State<SafetyCompanionPage> createState() => _SafetyCompanionPageState();
}

class _SafetyCompanionPageState extends State<SafetyCompanionPage> {
  double dragOffset = 0.0;
  bool hasNavigated = false;
  bool isPressed = false;
  bool isSafe=false;

  @override
  Widget build(BuildContext context) {

    if(isSafe){
      return const Scaffold(
          backgroundColor: Colors.green,
          body: Center(
            child: Text(
              'You are Safe',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'serif',
              ),
            ),
          )
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Press and hold the button when you start your journey',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                  fontFamily: 'serif',
                ),
              ),

              const SizedBox(height: 40),

              GestureDetector(
                onVerticalDragDown: (details) {
                  setState(() {
                    isPressed = true;
                  });
                },
                onVerticalDragStart: (details) {
                  setState(() {
                    dragOffset = 0.0;
                    hasNavigated = false;
                  });
                },
                onVerticalDragUpdate: (details) {
                  setState(() {
                    if(dragOffset + details.delta.dy <=0){
                      dragOffset+= details.delta.dy;
                    }
                  });
                  if(dragOffset<-150 && !hasNavigated){
                    hasNavigated=true;
                    setState(() {
                      isPressed=false;
                      isSafe= true;
                    });
                    Timer(const Duration(seconds: 2), () {
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    });
                  }
                },
                onVerticalDragEnd: (details) {
                  setState(() {
                    isPressed = false;
                    dragOffset = 0.0;
                  });

                  if (!hasNavigated) {
                    hasNavigated = true;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SOSPage(),
                      ),
                    );
                  }
                },
                onVerticalDragCancel: () {
                  setState(() {
                    isPressed = false;
                    dragOffset = 0.0;
                  });

                  if (!hasNavigated) {
                    hasNavigated = true;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SOSPage(),
                      ),
                    );
                  }
                },
                child: Transform.translate(
                  offset: Offset(0, dragOffset),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: isPressed ? 210 : 250,
                    height: isPressed ? 210 : 250,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: dragOffset < -20
                          ? const SizedBox.shrink()
                          : const Text(
                        'PUSH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 120),

              const Text(
                'Slide Up to Close',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 25,
                  fontFamily: 'serif',
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}