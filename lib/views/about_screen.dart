import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quran_recite_app/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppScreen extends StatelessWidget {

    Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          'About This App',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/icon/icon.png'), 
              ),
            ),
            SizedBox(height: 20),

            Center(
              child: Text(
                'Quran Recite App',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            SizedBox(height: 10),

            Center(
              child: Text(
                'Version 1.0.0',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 30),

            Text(
              'About the App:',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Quran Recite App is designed to provide a seamless experience for reading and understanding the Quran. It includes features like bookmarking, translations, and audio recitation to enhance your Quran learning journey.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Developer:',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Developed by Sami Malik. Feel free to reach out for feedback or suggestions.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Icon(Icons.code, color: Colors.blueAccent),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                  _launchURL('https://github.com/samimalikdev');
                  },
                  child: Text(
                  "github.com/samimalikdev",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Text(
              'Contact Us:',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.email, color: Colors.blueAccent),
                SizedBox(width: 10),
                Text(
                  'memelordsamimalik@gmail.com',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.language, color: Colors.blueAccent),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    _launchURL("https://t.me/SamiGaming");
                  },
                  child: Text(
                    't.me/SamiGaming',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
