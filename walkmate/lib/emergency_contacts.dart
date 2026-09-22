import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'chats.dart';
import 'profile_page.dart';

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({super.key});

  @override
  State<EmergencyContactsPage> createState() =>
      _EmergencyContactsPageState();
}

class _EmergencyContactsPageState
    extends State<EmergencyContactsPage> {

  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference get contactsCollection {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .collection('emergencyContacts');
  }

  void openContactForm({
    DocumentSnapshot? contact,
  }) {

    TextEditingController nameController =
    TextEditingController(
      text: contact == null
          ? ""
          : contact['name'].toString(),
    );

    TextEditingController phoneController =
    TextEditingController(
      text: contact == null
          ? ""
          : contact['phone'].toString(),
    );

    showDialog(
      context: context,

      builder: (dialogContext) {

        return AlertDialog(

          backgroundColor: Colors.grey[900],

          title: Text(
            contact == null
                ? "Add Contact"
                : "Edit Contact",

            style: const TextStyle(
              color: Colors.white,
            ),
          ),

          content: Column(

            mainAxisSize: MainAxisSize.min,

            children: [

              TextField(

                controller: nameController,

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration: const InputDecoration(
                  labelText: "Name",

                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              TextField(

                controller: phoneController,

                keyboardType:
                TextInputType.phone,

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration: const InputDecoration(
                  labelText: "Phone",

                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),

          actions: [

            TextButton(

              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text(
                "Cancel",

                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),

            TextButton(

              onPressed: () async {

                String name =
                nameController.text.trim();

                String phone =
                phoneController.text.trim();

                if (name.isEmpty ||
                    phone.isEmpty) {
                  return;
                }

                Navigator.pop(dialogContext);

                if (contact == null) {

                  await contactsCollection.add({
                    'name': name,
                    'phone': phone,
                  });

                } else {

                  await contactsCollection
                      .doc(contact.id)
                      .update({
                    'name': name,
                    'phone': phone,
                  });
                }
              },

              child: const Text(
                "Save",

                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void deleteContact(String id) async {

    await contactsCollection
        .doc(id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {

    if (user == null) {

      return const Scaffold(

        backgroundColor: Colors.black,

        body: Center(

          child: Text(
            "Please login first",

            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Scaffold(

      backgroundColor: Colors.black,

      appBar: AppBar(

        backgroundColor: Colors.black,

        elevation: 0,

        leading: IconButton(

          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),

          onPressed: () {
            Navigator.pop(context);
          },
        ),

        title: const Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            Text(
              "Emergency Contacts",

              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              "Manage your emergency contacts",

              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          children: [

            ElevatedButton(

              onPressed: () {
                openContactForm();
              },

              style: ElevatedButton.styleFrom(

                backgroundColor:
                Colors.green.shade700,
              ),

              child: const Text(
                "Add Contact",

                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Expanded(

              child: StreamBuilder<QuerySnapshot>(

                stream:
                contactsCollection.snapshots(),

                builder:
                    (context, snapshot) {

                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {

                    return const Center(

                      child:
                      CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {

                    return const Center(

                      child: Text(
                        "Something went wrong",

                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData ||
                      snapshot.data!.docs.isEmpty) {

                    return const Center(

                      child: Text(
                        "No contacts added yet.",

                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  var contacts =
                      snapshot.data!.docs;

                  return ListView.builder(

                    itemCount:
                    contacts.length,

                    itemBuilder:
                        (context, index) {

                      var contact =
                      contacts[index];

                      return ListTile(

                        title: Text(
                          contact['name'].toString(),

                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        subtitle: Text(
                          contact['phone'].toString(),

                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),

                        trailing: Row(

                          mainAxisSize:
                          MainAxisSize.min,

                          children: [

                            IconButton(

                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),

                              onPressed: () {

                                openContactForm(
                                  contact: contact,
                                );
                              },
                            ),

                            IconButton(

                              icon: const Icon(
                                Icons.delete,
                                color:
                                Colors.redAccent,
                              ),

                              onPressed: () {

                                deleteContact(
                                  contact.id,
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
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

        currentIndex: 1,

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

          if (index == 2) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(
                builder: (context) =>
                const ChatsPage(),
              ),
            );
          }

          if (index == 3) {

            Navigator.pushReplacement(

              context,

              MaterialPageRoute(
                builder: (context) =>
                const ProfilePage(),
              ),
            );
          }
        },
      ),
    );
  }
}