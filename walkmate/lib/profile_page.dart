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
    loadUser();
  }

  void loadUser() {

    User? user =
        FirebaseAuth.instance.currentUser;

    setState(() {
      name = user?.displayName ?? 'User';
      email = user?.email ?? '';
    });
  }

  void editName() {

    nameController.text = name;

    showDialog(
      context: context,

      builder: (dialogContext) {

        return AlertDialog(

          backgroundColor: Colors.black,

          title: const Text(
            'Edit Name',

            style: TextStyle(
              color: Colors.white,
            ),
          ),

          content: TextField(

            controller: nameController,

            style: const TextStyle(
              color: Colors.white,
            ),

            decoration: const InputDecoration(
              hintText: 'Enter new name',

              hintStyle: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text(
                'Cancel',

                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            ElevatedButton(

              onPressed: () async {

                String newName =
                nameController.text.trim();

                if (newName.isEmpty) {
                  return;
                }

                User? user =
                    FirebaseAuth.instance.currentUser;

                if (user == null) {
                  return;
                }

                await user.updateDisplayName(
                  newName,
                );

                await user.reload();

                User? updatedUser =
                    FirebaseAuth.instance.currentUser;

                if (mounted) {
                  setState(() {
                    name =
                        updatedUser?.displayName ?? 'User';
                  });
                }

                Navigator.pop(dialogContext);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor:
                Colors.green.shade700,
              ),

              child: const Text(
                'Save',

                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
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

      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          children: [

            const SizedBox(height: 30),

            const CircleAvatar(

              radius: 55,

              backgroundColor: Colors.green,

              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              name,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              email,

              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 40),

            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(

                color: Colors.white10,

                borderRadius:
                BorderRadius.circular(15),

                border: Border.all(
                  color: Colors.green,
                  width: 1.5,
                ),
              ),

              child: Row(

                children: [

                  const Icon(
                    Icons.person_outline,
                    color: Colors.green,
                    size: 30,
                  ),

                  const SizedBox(width: 15),

                  Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      const Text(
                        'Name',

                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        name,

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {
                  editName();
                },

                style: ElevatedButton.styleFrom(

                  backgroundColor:
                  Colors.green.shade700,

                  padding:
                  const EdgeInsets.all(16),

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                ),

                child: const Text(
                  'Edit Profile',

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            SizedBox(

              width: double.infinity,

              child: OutlinedButton(

                onPressed: () async {

                  await FirebaseAuth.instance
                      .signOut();

                  if (context.mounted) {

                    Navigator.pushAndRemoveUntil(
                      context,

                      MaterialPageRoute(
                        builder: (context) =>
                        const LoginPage(),
                      ),

                          (route) => false,
                    );
                  }
                },

                style: OutlinedButton.styleFrom(

                  padding:
                  const EdgeInsets.all(16),

                  side: const BorderSide(
                    color: Colors.red,
                  ),

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(15),
                  ),
                ),

                child: const Text(
                  'Logout',

                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar:
      BottomNavigationBar(

        backgroundColor: Colors.black,

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