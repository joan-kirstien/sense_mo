import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:ui_sensemo/screens/home_screen.dart';
import 'package:ui_sensemo/screens/landing_page.dart';
import 'package:http/http.dart' as http;

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();


  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

    bool confirmPass(){
    if(passwordController.text.trim()== confirmpasswordController.text.trim()){
      return true;
    }else{
      return false;
    }
  }

 Future<void> sendUsersData() async {
  var url = Uri.parse('http://10.0.2.2:8000/api/signup/');
  
  try {
    var response = await http.post(url, body: {
      'full_name': fullNameController.text,
      'phone_num': phoneController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });

    if (response.statusCode == 201) {
      print('User data added successfully');
      // Navigate to the new page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      );
    } else {
      print('Failed to add user data. Status Code: ${response.statusCode}');
    }
  } catch (error) {
    print('Failed to add user data. Error: $error');
    // You can handle the error here
  }
}


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
            Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35.0),
                child: TextFormField(
                  controller: fullNameController,
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
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: TextFormField(
                controller: phoneController,
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
                controller: emailController,
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
                controller: passwordController,
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
                controller: confirmpasswordController,
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
                onPressed: ()async{
                  if(_formkey.currentState!.validate()){
                  if(confirmPass()){
                    sendUsersData();
                }else{
                    QuickAlert.show(
                    context: context,
                    type: QuickAlertType.error,
                    title: 'Incorrect password',
                    text: 'Password and confrim password dont match',
                  );
                }}else{
                  QuickAlert.show(
                  context: context,
                  type: QuickAlertType.error,
                  title: 'Unfilled Form',
                  text: 'Please enter all the information required',
                );
                }
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