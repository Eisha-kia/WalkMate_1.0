import 'package:flutter/material.dart';
import 'login_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              SizedBox(height: 80),

              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: 80,
                  width: 80,
                ),
              ),

              SizedBox(height: 8),

              Center(
                child: Text(
                  'Walkmate',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ),

              Center(
                child: Text(
                  'Your safety, our priority.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),

              SizedBox(height: 30),

              Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 30),

              Text(
                'Name',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),

              SizedBox(height: 8),

              TextField(
                controller: nameController,
                autofocus: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter your name',
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Email',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),

              SizedBox(height: 8),

              TextField(
                controller: emailController,
                autofocus: false,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                ),
              ),

              SizedBox(height: 20),

              Text(
                'Password',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),

              SizedBox(height: 8),

              TextField(
                controller: passwordController,
                autofocus: false,
                obscureText: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                ),
              ),

              SizedBox(height: 10),

              Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  String name = nameController.text;
                  String email = emailController.text;
                  String password = passwordController.text;

                  if (name.isEmpty || email.isEmpty || password.isEmpty) {
                    setState(() {
                      errorMessage = 'Please fill in all fields';
                    });
                    return;
                  }

                  setState(() {
                    errorMessage = '';
                  });

                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  padding: EdgeInsets.all(16),
                ),
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              SizedBox(height: 40),

            ],
          ),
        ),
      ),
    );
  }
}