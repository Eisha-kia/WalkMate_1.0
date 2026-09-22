import 'package:flutter/material.dart';
import 'login_page.dart';
import 'auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String errorMessage = '';

  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Name',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: nameController,
              autofocus: false,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter your name',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: emailController,
              autofocus: false,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: passwordController,
              autofocus: false,
              obscureText: true,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: const InputDecoration(
                hintText: 'Enter your password',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                String name = nameController.text.trim();
                String email = emailController.text.trim();
                String password = passwordController.text;

                if (name.isEmpty ||
                    email.isEmpty ||
                    password.isEmpty) {
                  setState(() {
                    errorMessage = 'Please fill in all fields';
                  });
                  return;
                }

                if (!email.contains('@')) {
                  setState(() {
                    errorMessage = 'Please enter a valid email';
                  });
                  return;
                }

                if (password.length < 6) {
                  setState(() {
                    errorMessage =
                    'Password must be at least 6 characters';
                  });
                  return;
                }

                try {
                  await authService.createAccount(
                    email: email,
                    password: password,
                  );

                  await authService.updateUsername(
                    username: name,
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } catch (e) {
                  setState(() {
                    errorMessage = e.toString();
                  });
                }
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                padding: const EdgeInsets.all(16),
              ),

              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}