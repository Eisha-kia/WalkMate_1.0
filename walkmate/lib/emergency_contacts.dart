import 'package:flutter/material.dart';

class Contact {
  String name;
  String phone;
  Contact(this.name, this.phone);
}

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({super.key});
  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  List<Contact> contacts = [];

  void addContact(String name, String phone) {
    setState(() => contacts.add(Contact(name, phone)));
  }

  void editContact(int index, String name, String phone) {
    setState(() => contacts[index] = Contact(name, phone));
  }

  void deleteContact(int index) {
    setState(() => contacts.removeAt(index));
  }

  void openContactForm({Contact? existingContact, int? index}) {
    var nameController = TextEditingController(text: existingContact?.name ?? "");
    var phoneController = TextEditingController(text: existingContact?.phone ?? "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          existingContact == null ? "Add Contact" : "Edit Contact",
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          TextField(
            controller: nameController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: "Name",
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
          TextField(
            controller: phoneController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: "Phone",
              labelStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ]),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(onPressed: () {
            String name = nameController.text;
            String phone = phoneController.text;
            if (name.isEmpty || phone.isEmpty) return;

            if (existingContact == null) {
              addContact(name, phone);
            } else {
              editContact(index!, name, phone);
            }
            Navigator.pop(context);
          }, child: const Text("Save", style: TextStyle(color: Colors.green))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: const Text("Emergency Contacts"), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(onPressed: () => openContactForm(), child: const Text("Add Contact")),
            const SizedBox(height: 16),
            Expanded(
              child: contacts.isEmpty
                  ? const Center(child: Text("No contacts added yet.", style: TextStyle(color: Colors.grey)))
                  : ListView.builder(
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  Contact contact = contacts[index];
                  return ListTile(
                    title: Text(contact.name, style: const TextStyle(color: Colors.white)),
                    subtitle: Text(contact.phone, style: const TextStyle(color: Colors.grey)),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () => openContactForm(existingContact: contact, index: index),
                      ),
                      IconButton(icon: const Icon(Icons.delete, color: Colors.redAccent), onPressed: () => deleteContact(index)),
                    ]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}