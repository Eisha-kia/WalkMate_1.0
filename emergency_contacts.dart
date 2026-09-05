import 'package:flutter/material.dart';

class Contact {
  String name;
  String phone;
  bool isPrimary;
  Contact({required this.name, required this.phone, this.isPrimary = false});
}

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({super.key});

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  final List<Contact> contacts = [];

  static const green = Color(0xFF3DDC5A);
  static const bg = Color(0xFF0B0F0C);
  static const card = Color(0xFF141A16);

  void _addOrEditContact({Contact? existing, int? index}) {
    final nameCtrl = TextEditingController(text: existing?.name ?? "");
    final phoneCtrl = TextEditingController(text: existing?.phone ?? "");

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: card,
        title: Text(existing == null ? "Add Contact" : "Edit Contact",
            style: const TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(labelText: "Name", labelStyle: TextStyle(color: Colors.grey)),
            ),
            TextField(
              controller: phoneCtrl,
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone", labelStyle: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: green),
            onPressed: () {
              if (nameCtrl.text.trim().isEmpty || phoneCtrl.text.trim().isEmpty) return;
              setState(() {
                if (existing == null) {
                  contacts.add(Contact(name: nameCtrl.text, phone: phoneCtrl.text));
                } else {
                  contacts[index!].name = nameCtrl.text;
                  contacts[index].phone = phoneCtrl.text;
                }
              });
              Navigator.pop(context);
            },
            child: const Text("Save", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  void _deleteContact(int index) {
    setState(() => contacts.removeAt(index));
  }

  void _callContact(String phone) {
    // Use url_launcher package: launchUrl(Uri.parse('tel:$phone'));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Calling $phone...")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: bg,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Emergency Contacts",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            Text("Manage your emergency contacts",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            // Add Contact button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _addOrEditContact(),
                icon: const Icon(Icons.add_circle_outline, color: green),
                label: const Text("Add Contact", style: TextStyle(color: green)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: green),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Contact list
            Expanded(
              child: contacts.isEmpty
                  ? const Center(
                child: Text(
                  "No contacts yet.\nTap 'Add Contact' to get started.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : ListView.separated(
                itemCount: contacts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final c = contacts[index];
                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: card,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: green.withOpacity(0.15),
                          child: Text(
                            c.name.isNotEmpty ? c.name[0].toUpperCase() : "?",
                            style: const TextStyle(color: green, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(c.name,
                                  style: const TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.w600)),
                              Text(c.phone, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                              if (c.isPrimary)
                                const Text("Primary Contact",
                                    style: TextStyle(color: green, fontSize: 12)),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.call, color: green),
                          onPressed: () => _callContact(c.phone),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.grey),
                          onPressed: () => _addOrEditContact(existing: c, index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                          onPressed: () => _deleteContact(index),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            // Footer note
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.verified_user, color: green, size: 16),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      "In case of emergency, you can quickly call your saved contacts.",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: bg,
        selectedItemColor: green,
        unselectedItemColor: Colors.grey,
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "Contacts"),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Profile"),
        ],
      ),
    );
  }
}

