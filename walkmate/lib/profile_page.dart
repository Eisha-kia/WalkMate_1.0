import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'chats.dart';
import 'emergency_contacts.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  TextEditingController nameController =
  TextEditingController();

  String name = 'User';
  String email = '';

  @override
  void initState() {
    super.initState();

    User? user =
        FirebaseAuth.instance.currentUser;

    name = user?.displayName ?? 'User';
    email = user?.email ?? '';
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(

        backgroundColor:
        Colors.green.shade700,

        title: const Text(
          'Profile',

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        child: Padding(

          padding: const EdgeInsets.all(24),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.stretch,

            children: [

              const SizedBox(height: 40),

              const CircleAvatar(

                radius: 50,

                backgroundColor:
                Colors.green,

                child: Icon(
                  Icons.person,
                  size: 55,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                name,

                textAlign:
                TextAlign.center,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                email,

                textAlign:
                TextAlign.center,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'Name',

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 8),

              TextField(

                controller:
                nameController,

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration:
                const InputDecoration(

                  hintText:
                  'Enter your new name',

                  hintStyle:
                  TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(

                onPressed: () {

                  String newName =
                  nameController
                      .text
                      .trim();

                  if (newName.isEmpty) {
                    return;
                  }

                  User? user =
                      FirebaseAuth
                          .instance
                          .currentUser;

                  user!
                      .updateDisplayName(
                    newName,
                  )
                      .then((_) {

                    setState(() {
                      name = newName;
                    });

                    nameController.clear();
                  });
                },

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  Colors.green.shade700,

                  padding:
                  const EdgeInsets.all(16),
                ),

                child: const Text(
                  'Save Name',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(

                onPressed: () {

                  FirebaseAuth.instance
                      .signOut()
                      .then((_) {

                    Navigator.pushAndRemoveUntil(
                      context,

                      MaterialPageRoute(
                        builder: (context) =>
                        const LoginPage(),
                      ),

                          (route) => false,
                    );
                  });
                },

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  Colors.red,

                  padding:
                  const EdgeInsets.all(16),
                ),

                child: const Text(
                  'Logout',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar:
      BottomNavigationBar(

        backgroundColor:
        Colors.black,

        type:
        BottomNavigationBarType.fixed,

        selectedItemColor:
        Colors.green,

        unselectedItemColor:
        Colors.grey,

        currentIndex: 3,

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
            icon: Icon(
              Icons.chat_bubble_outline,
            ),
            label: 'Chat',
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
            ),
            label: 'Profile',
          ),
        ],

        onTap: (index) {

          if (index == 0) {

            Navigator.pop(context);
          }

          if (index == 1) {

            Navigator.pushReplacement(
              context,

              MaterialPageRoute(
                builder: (context) =>
                const EmergencyContactsPage(),
              ),
            );
          }

          if (index == 2) {

            Navigator.pushReplacement(
              context,

              MaterialPageRoute(
                builder: (context) =>
                const ChatsPage(),
              ),
            );
          }
        },
      ),
    );
  }
}