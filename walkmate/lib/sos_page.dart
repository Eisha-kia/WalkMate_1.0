import 'package:flutter/material.dart';
import 'dart:async';

class SOSPage extends StatefulWidget {
  const SOSPage({super.key});

  @override
  State<SOSPage> createState() => _SOSPageState();
}

class _SOSPageState extends State<SOSPage> {
  int countdown = 5;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (countdown > 0) {
        setState(() => countdown--);
      } else {
        timer?.cancel();
      }
    });
  }

  void cancelSOS() {
    timer?.cancel();
    Navigator.pop(context);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool sent = countdown == 0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: sent ? _sentPage() : _countdownPage(),
          ),
        ),
      ),
    );
  }

  Widget _countdownPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.warning_rounded, color: Colors.red, size: 80),

        const SizedBox(height: 20),

        Text(
          'SOS ACTIVATING\n$countdown',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 35),

        ElevatedButton(
          onPressed: cancelSOS,
          child: const Text('CANCEL SOS'),
        ),
      ],
    );
  }

  Widget _sentPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.warning_rounded, color: Colors.red, size: 75),

        const SizedBox(height: 15),

        const Text(
          'SOS SENT',
          style: TextStyle(
            color: Colors.red,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 10),

        const Text(
          'Your emergency contacts have been notified.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),

        const SizedBox(height: 15),

        const Text(
          '📍 Location sharing: ACTIVE',
          style: TextStyle(color: Colors.green, fontSize: 16),
        ),

        const SizedBox(height: 35),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _button(Icons.local_police, 'Police'),
            _button(Icons.local_hospital, 'Ambulance'),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _button(Icons.local_fire_department, 'Fire Service'),
            _button(Icons.people, 'Contacts'),
          ],
        ),

        const SizedBox(height: 35),

        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.phone),
            label: const Text('CALL EMERGENCY CONTACT'),
          ),
        ),
      ],
    );
  }

  Widget _button(IconData icon, String text) {
    return SizedBox(
      width: 145,
      height: 65,
      child: ElevatedButton.icon(
        onPressed: () {},
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}