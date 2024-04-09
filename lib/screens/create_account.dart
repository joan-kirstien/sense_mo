import 'package:flutter/material.dart';
import 'package:ui_sensemo/screens/landing_page.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon (
                      Icons.arrow_back_ios_new,
                      size: 24,
                      color: Colors.white,
                    )
                  ),
                ]
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
                )
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  hintStyle: const TextStyle(
                    color: Colors.grey
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  filled: true,
                  fillColor: const Color(0xFF404040),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  hintStyle: const TextStyle(
                    color: Colors.grey
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  filled: true,
                  fillColor: const Color(0xFF404040),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  hintStyle: const TextStyle(
                    color: Colors.grey
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  filled: true,
                  fillColor: const Color(0xFF404040),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    color: Colors.grey
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  filled: true,
                  fillColor: const Color(0xFF404040),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: const TextStyle(
                    color: Colors.grey
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  filled: true,
                  fillColor: const Color(0xFF404040),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  )
                ),
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: (){
                  navigateToLandingPage(context);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color(0xFF00BF62),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)
                  )
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: Text('Register',
                  style: TextStyle(
                    fontSize: 15
                  )),
                )
              ),
            ), 
            const SizedBox(height: 80),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Already have an account?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF8D8D8D),
                      fontWeight: FontWeight.w200
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: InkWell(
                      onTap: () {},
                      child: InkWell(
                        onTap: () {
                          navigateToLandingPage(context);
                        },
                        child: const Text('Log in',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF00BF62),
                        ),),
                      ),
                    ),
                  )
                  
                ],
              ),
            )
          ],
          ),
      )
    );
  }
}