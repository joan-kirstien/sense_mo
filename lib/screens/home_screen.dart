import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF000000),
        body: Stack(
          children: [
            _buildCamera(),
          ],
        ),
      ),
    );
  }

  Widget _buildCamera() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment
          .start, // Align content to the start (left) horizontally
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Align content to the start (left) horizontally
            children: [
              SizedBox(height: 50),
              Text(
                'Live Camera',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPhoneCamera(),
                  _buildBodyCamera(),
                ],
              ),
              _buildUpload(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneCamera() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xFF404040),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child:
                Icon(Icons.phone_android, color: Color(0xFF00BF62), size: 70),
          ),
          SizedBox(height: 10), // Add space between the icon and text
          Center(
            // Center the text horizontally
            child: Text(
              'Phone',
              style: TextStyle(
                color: Color(0xFF8D8D8D),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyCamera() {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Color(0xFF404040),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Icon(Icons.camera_alt_outlined,
                color: Color(0xFF00BF62), size: 70),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Body Camera',
              style: TextStyle(
                color: Color(0xFF8D8D8D),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpload() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment
          .start, // Align content to the start (left) horizontally
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start, // Align content to the start (left) horizontally
            children: [
              SizedBox(height: 10),
              Text(
                'Upload',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}
