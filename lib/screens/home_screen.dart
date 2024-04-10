import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ui_sensemo/screens/camera_section.dart';
import 'package:ui_sensemo/screens/settings.dart';
import 'package:ui_sensemo/widgets/navbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

   @override
  Widget build(BuildContext context) {
    _pages = [
      _buildCamera(context),
      const Settings(),
    ];
    
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 160, vertical: 80),
          child: NavBar(
            selectedIndex: _selectedIndex,
            onTabChange: _onTabChange,
          ),
        ),
      ),
    );
  }

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildCamera(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start,
            children: [
              const SizedBox(height: 50),
              const Padding(
                padding: EdgeInsets.only(left: 25.0, top: 20),
                child: Text(
                  'Live Camera',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPhoneCamera(context),
                  _buildBodyCamera(context),
                ],
              ),
              _buildUpload(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneCamera(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const PhoneCamera()));
            },
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color(0xFF404040),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:
                  const Icon(Icons.phone_android, color: Color(0xFF00BF62), size: 70),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Phone Camera ',
              style: TextStyle(
                color: Color(0xFF8D8D8D),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyCamera(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          InkWell(
            onTap: (){},
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color(0xFF404040),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Icon(Icons.camera_alt,
                  color: Color(0xFF00BF62), size: 70),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Body Camera',
              style: TextStyle(
                color: Color(0xFF8D8D8D),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUpload(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment
          .start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment
                .start,
            children: [
              const SizedBox(height: 25),
              const Padding(
                padding: EdgeInsets.only(left: 25.0),
                child: Text(
                  'Upload',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildUploadImage(context),
                  _buildUploadVideo(context),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildUploadImage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              _pickImageFromGallery(context);
            },
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color(0xFF404040),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:
                  const Icon(Icons.image, color: Color(0xFF00BF62), size: 70),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Image',
              style: TextStyle(
                color: Color(0xFF8D8D8D),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

    Future<void> _pickImageFromGallery(BuildContext context) async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageUpload(imageFile: File(pickedImage.path)),
        ),
      );
    }
  }

  Widget _buildUploadVideo(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          InkWell(
            onTap: (){
              _pickVideo(context);
            },
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: const Color(0xFF404040),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child:
                  const Icon(Icons.movie, color: Color(0xFF00BF62), size: 70),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Video',
              style: TextStyle(
                color: Color(0xFF8D8D8D),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

    Future<void> _pickVideo(BuildContext context) async{
      final pickedvideo = await ImagePicker().pickVideo(source: ImageSource.gallery);
      if (pickedvideo == null) {
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VideoUpload(videoFile: File(pickedvideo.path)),
        ),
      );
    }
  }