import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'signup_page.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController =
  TextEditingController();

  TextEditingController passwordController =
  TextEditingController();

  String errorMessage = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,

      body: SingleChildScrollView(
        reverse: true,

        child: Padding(
          padding: const EdgeInsets.all(24),

          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.stretch,

            children: [

              const SizedBox(height: 80),

              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 80,
                  width: 80,
                ),
              ),

              const SizedBox(height: 8),

              const Center(
                child: Text(
                  'Walkmate',

                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),

              const Center(
                child: Text(
                  'Your safety, our priority.',

                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              const Center(
                child: Text(
                  'Welcome Back',

                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 30),

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

                keyboardType:
                TextInputType.emailAddress,

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

                  String email =
                  emailController.text.trim();

                  String password =
                      passwordController.text;

                  if (email.isEmpty ||
                      password.isEmpty) {

                    setState(() {
                      errorMessage =
                      'Please fill in all fields';
                    });

                    return;
                  }

                  setState(() {
                    errorMessage = '';
                  });

                  try {

                    await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (context.mounted) {

                      Navigator.pushReplacement(
                        context,

                        MaterialPageRoute(
                          builder: (context) =>
                          const HomePage(),
                        ),
                      );
                    }

                  } on FirebaseAuthException catch (e) {

                    setState(() {

                      errorMessage =
                          e.message ?? e.code;
                    });
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.green.shade700,

                  padding:
                  const EdgeInsets.all(16),
                ),

                child: const Text(
                  'Log In',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton(

                onPressed: () {

                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (context) =>
                      const SignUpPage(),
                    ),
                  );
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor:
                  Colors.green.shade700,

                  padding:
                  const EdgeInsets.all(16),
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
      ),
    );
  }
}