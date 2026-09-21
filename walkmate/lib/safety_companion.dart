import 'package:flutter/material.dart';
import 'sos_page.dart';

class SafetyCompanionPage extends StatefulWidget {
  const SafetyCompanionPage({super.key});

  @override
  State<SafetyCompanionPage> createState() => _SafetyCompanionPageState();
}

class _SafetyCompanionPageState extends State<SafetyCompanionPage> {
  double _dragOffset = 0.0;
  bool _hasNavigated = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
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
                    _isPressed = true;
                  });
                },
                onVerticalDragStart: (details) {
                  setState(() {
                    _dragOffset = 0.0;
                    _hasNavigated = false;
                  });
                },
                onVerticalDragUpdate: (details) {
                  setState(() {
                    if (_dragOffset + details.delta.dy <= 0) {
                      _dragOffset += details.delta.dy;
                    }
                  });

                  if (_dragOffset < -150 && !_hasNavigated) {
                    _hasNavigated = true;
                    setState(() {
                      _isPressed = false;
                      _dragOffset = 0.0;
                    });
                    Navigator.pop(context);
                  }
                },
                onVerticalDragEnd: (details) {
                  setState(() {
                    _isPressed = false;
                    _dragOffset = 0.0;
                  });

                  if (!_hasNavigated) {
                    _hasNavigated = true;
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
                    _isPressed = false;
                    _dragOffset = 0.0;
                  });

                  if (!_hasNavigated) {
                    _hasNavigated = true;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SOSPage(),
                      ),
                    );
                  }
                },
                child: Transform.translate(
                  offset: Offset(0, _dragOffset),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    width: _isPressed ? 210 : 250,
                    height: _isPressed ? 210 : 250,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: _dragOffset < -20
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