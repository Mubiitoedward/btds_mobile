import 'package:flutter/material.dart';

class Aboutsystem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About System', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Our App',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // SizedBox(height: 10),
            // Image.asset('assets/images/app_intro.png'), 
            SizedBox(height: 20),
            Text(
              'What We Do',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Our app is designed to provide instant diagnosis of brain images using advanced machine learning algorithms. Whether you are a healthcare professional or an individual looking for quick and accurate results, our app is tailored to meet your needs.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Text(
              'Features',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            _buildFeature(
              icon: Icons.camera_alt,
              title: 'Instant Image Analysis',
              description:
                  'Upload a brain image from your gallery or take a new one using your camera. Get results within seconds.',
            ),
            _buildFeature(
              icon: Icons.security,
              title: 'Secure and Confidential',
              description:
                  'Your data is secure with us. We ensure confidentiality and privacy for all your uploads and results.',
            ),
            _buildFeature(
              icon: Icons.cloud_upload,
              title: 'Cloud Storage',
              description:
                  'All your results are stored securely in the cloud, accessible anytime and anywhere.',
            ),
            _buildFeature(
              icon: Icons.insights,
              title: 'High Accuracy',
              description:
                  'Our app uses state-of-the-art machine learning models to ensure high accuracy in diagnostics.',
            ),
            SizedBox(height: 20),
            Text(
              'Benefits',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '• Quick and reliable brain image analysis.\n'
              '• Easy-to-use interface suitable for all users.\n'
              '• Accessible and secure cloud storage for your results.\n'
              '• Enhances the diagnostic process for healthcare professionals.',
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Get Started'),
                style: ElevatedButton.styleFrom(
                  iconColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature({required IconData icon, required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 40, color: Colors.black),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
