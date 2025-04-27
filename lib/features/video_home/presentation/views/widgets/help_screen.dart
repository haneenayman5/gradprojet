import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      appBar: AppBar(
        title: const Text(
          'Help & Support',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            _buildSectionTitle('👋 Welcome!'),
            _buildParagraph(
                'This app is designed to empower deaf and hard of hearing individuals by enhancing communication and learning experiences.'),

            _buildSectionTitle('💬 Real-time Chat with Sign Support'),
            _buildParagraph(
                'Our chat feature lets you send and receive messages seamlessly. It also includes sign language detection from camera input, converting signs into text and voice.'),

            _buildSectionTitle('📚 Learn Sign Language'),
            _buildParagraph(
                'Explore a built-in Sign Language Dictionary with short videos and animations to help you learn new signs and phrases at your own pace.'),

            _buildSectionTitle('🎥 Video Calling with Sign Detection'),
            _buildParagraph(
                'Connect with others using video calls. Our app uses advanced AI to detect signs and display the meaning in real-time to the other participant.'),

            _buildSectionTitle('❓Need More Help?'),
            _buildParagraph(
                'If you need technical support, have feedback, or want to request a feature, please reach out to our support team from the settings page or email us at support@signchatapp.com.'),

            const SizedBox(height: 30),
            const Text(
              'Thank you for using our app 💙',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black54,
        height: 1.4,
      ),
    );
  }
}

