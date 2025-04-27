import 'package:flutter/material.dart';
import 'package:untitled3/core/constants/constants.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  void _showEditDialog(BuildContext context, String title, String currentValue, void Function(String) onSave) {
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

  @override
  Widget build(BuildContext context) {
    // Replace these with your real user values
    String userName = "John Doe";
    String email = "johndoe@example.com";
    String password = "********";

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
          // Profile section
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage("assets/images/default_profile.png"), // Replace with NetworkImage if needed
                ),
                const SizedBox(height: 12),
                Text(
                  userName,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Divider(),

          // Editable Account Info
          ListTile(
            leading: const Icon(Icons.person, color: kPrimarycolor),
            title: const Text("Name"),
            subtitle: Text(userName),
            trailing: const Icon(Icons.edit),
            onTap: () {
              _showEditDialog(context, "Name", userName, (value) {
                // Handle save logic here
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
                // Handle save logic here
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
                // Handle password update logic
              });
            },
          ),
          const Divider(),

          // Additional Account Settings
          const ListTile(
            leading: Icon(Icons.language, color: kPrimarycolor),
            title: Text("Language"),
            subtitle: Text("Choose your preferred language"),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.notifications, color: kPrimarycolor),
            title: Text("Notifications"),
            subtitle: Text("Manage notification preferences"),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.dark_mode, color: kPrimarycolor),
            title: Text("Dark Mode"),
            subtitle: Text("Customize your theme"),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info_outline, color: kPrimarycolor),
            title: Text("App Info"),
            subtitle: Text("Version, privacy policy, etc."),
          ),
          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () {
              // Handle logout logic
              // context.go(AppRoute.welcomePath);
            },
          ),
        ],
      ),
    );
  }
}








