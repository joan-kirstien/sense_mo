
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_sensemo/model/user.dart';
import 'package:ui_sensemo/screens/create_account.dart';
import 'package:ui_sensemo/screens/home_screen.dart';
import 'package:http/http.dart' as http;
import 'package:ui_sensemo/model/user.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();

}


class _LandingPageState extends State<LandingPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

    Widget _buildEmail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF404040),
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: emailController,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                hintText: 'Enter Email/Username',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF404040),
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: passwordController,
              style: const TextStyle(color: Colors.grey),
              decoration: const InputDecoration(
                hintText: 'Enter Password',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loginUser() async {
    var url = Uri.parse('http://10.0.2.2:8000/api/login/');
    var response = await http.post(
      url,
      body: {
        'email': emailController.text,
        'password': passwordController.text,
      },
    );

    print('Sent email: ${emailController.text}');
    print('Sent password: ${passwordController.text}');

    if (response.statusCode == 200) {
      // Login successful
      var data = json.decode(response.body);
      print('Data received: $data');

      final fullName = data['full_name'] ?? '';
      final phoneNumber = data['phone_num'] ?? '';

      Provider.of<UserProvider>(context, listen: false).setUser(
        email: emailController.text,
        fullName: fullName,
        phoneNumber: phoneNumber,
      );

      // Print to check if the user information is updated properly
      final user = Provider.of<UserProvider>(context, listen: false);
      print('User Info: ${user.fullName}, ${user.email}, ${user.phoneNumber}');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      // Login failed
      print('Login failed: ${response.body}');
    }
  }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: Stack(
        children: [
          _buildEnter(),
        ],
      ),
    ));
  }

  Widget _buildEnter() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/icon.png',
                    color: const Color(0xFF00BF62),
                  ),
                  _buildEmail(),
                  _buildPassword(),
                  _buildForgotPassword(),
                  const SizedBox(height: 30),
                  _buildLogin(),
                  _buildRegister(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(1.0),
          child: Column(
            children: [
              Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Color(0xFF00BF62),
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

  Widget _buildLogin() {
    return InkWell(
      onTap: () {
        navigateToHomePage(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        decoration: BoxDecoration(
          color: const Color(0xFF00BF62),
          borderRadius: BorderRadius.circular(50.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  loginUser();
                },
                child: const TextField(
                  enabled: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Login',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegister() {
    return InkWell(
      onTap: () {
        navigateToCreateAccount(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50.0),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  navigateToCreateAccount(context);
                },
                child: const TextField(
                  enabled: false,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: 'Register',
                    hintStyle: TextStyle(color: Colors.black),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void navigateToHomePage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const HomePage()));
}

void navigateToCreateAccount(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const CreateAccount()));
}

void navigateToLandingPage(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LandingPage()));
}