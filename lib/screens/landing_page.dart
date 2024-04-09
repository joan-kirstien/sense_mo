
import 'package:flutter/material.dart';
import 'package:ui_sensemo/screens/create_account.dart';
import 'package:ui_sensemo/screens/home_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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

  Widget _buildEmail() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: const Color(0xFF404040),
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: const Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.grey),
              decoration: InputDecoration(
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
      child: const Row(
        children: [
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              style: TextStyle(color: Colors.grey),
              decoration: InputDecoration(
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
                  navigateToHomePage(context);
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