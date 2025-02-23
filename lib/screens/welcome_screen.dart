import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';  // Correct import for fluttertoast
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final t = languageProvider.translate;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.white],  // Adjust gradient as needed
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: 1.0,
                  duration: Duration(milliseconds: 500),
                  child: AnimatedScale(
                    scale: 1.0,
                    duration: Duration(milliseconds: 500),
                    child: Image.asset(
                      'assets/paper.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  t('welcome'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 45,  // Increased font size
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  t('tagline'),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    t('description'),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _handleNavigation(context, '/signup', t);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),  // Adjust button width and height
                        backgroundColor: Colors.blue,  // Button background color
                        minimumSize: Size(150, 60),  // Set minimum size for width and height
                      ),
                      child: Text(
                        t('signUp'),
                        style: TextStyle(
                          color: Colors.white,  // Change text color
                          fontSize: 20,  // Adjust font size
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    OutlinedButton(
                      onPressed: () {
                        _handleNavigation(context, '/signin', t);
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),  // Adjust button width and height
                        side: BorderSide(color: Colors.blue),  // Border color
                        minimumSize: Size(150, 60),  // Set minimum size for width and height
                      ),
                      child: Text(
                        t('signIn'),
                        style: TextStyle(
                          color: Colors.blue,  // Change text color
                          fontSize: 20,  // Adjust font size
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                TextButton(
                  onPressed: () {
                    languageProvider.setLanguage(
                      languageProvider.language == 'en' ? 'ar' : 'en',
                    );
                  },
                  child: Text(
                    languageProvider.language == 'en'
                        ? t('switchToArabic')
                        : t('switchToEnglish'),
                    style: TextStyle(color: Colors.grey[600], fontSize: 20),  // Adjust font size
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleNavigation(BuildContext context, String path, Function t) {
    String toastMessage = path == '/signup'
        ? t('creatingAccount')
        : t('accessingAccount');

    Fluttertoast.showToast(
      msg: toastMessage,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );

    Navigator.pushNamed(context, path);  // Navigate to the respective screen
  }
}

