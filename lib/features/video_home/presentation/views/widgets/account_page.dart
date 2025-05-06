import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:untitled3/core/constants/constants.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  // User data
  String firstName = "John";
  String lastName = "Doe";
  String email = "johndoe@example.com";
  String password = "********";
  String phone = "+123456789";
  String dob = "1990-01-01";
  File? profileImage;

  void _showEditDialog(
      BuildContext context,
      String title,
      String currentValue,
      void Function(String) onSave,
      ) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Edit $title'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: 'Enter new $title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        profileImage = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: kPrimarycolor,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Section
          Center(
            child: Column(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: profileImage != null
                        ? FileImage(profileImage!)
                        : const AssetImage("assets/images/default_profile.png")
                    as ImageProvider,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  "$firstName $lastName",
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(email, style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),

          // Editable Fields
          ListTile(
            leading: const Icon(Icons.person, color: kPrimarycolor),
            title: const Text("First Name"),
            subtitle: Text(firstName),
            trailing: const Icon(Icons.edit),
            onTap: () {
              _showEditDialog(context, "First Name", firstName, (value) {
                setState(() => firstName = value);
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person, color: kPrimarycolor),
            title: const Text("Last Name"),
            subtitle: Text(lastName),
            trailing: const Icon(Icons.edit),
            onTap: () {
              _showEditDialog(context, "Last Name", lastName, (value) {
                setState(() => lastName = value);
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.email, color: kPrimarycolor),
            title: const Text("Email"),
            subtitle: Text(email),
            trailing: const Icon(Icons.edit),
            onTap: () {
              _showEditDialog(context, "Email", email, (value) {
                setState(() => email = value);
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.lock, color: kPrimarycolor),
            title: const Text("Password"),
            subtitle: Text(password),
            trailing: const Icon(Icons.edit),
            onTap: () {
              _showEditDialog(context, "Password", "", (value) {
                setState(() => password = "********");
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.phone, color: kPrimarycolor),
            title: const Text("Phone Number"),
            subtitle: Text(phone),
            trailing: const Icon(Icons.edit),
            onTap: () {
              _showEditDialog(context, "Phone Number", phone, (value) {
                setState(() => phone = value);
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.calendar_today, color: kPrimarycolor),
            title: const Text("Date of Birth"),
            subtitle: Text(dob),
            trailing: const Icon(Icons.edit),
            onTap: () {
              _showEditDialog(context, "Date of Birth", dob, (value) {
                setState(() => dob = value);
              });
            },
          ),
          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              // Handle logout logic
            },
          ),
        ],
      ),
    );
  }
}









