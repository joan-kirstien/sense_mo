import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
        ),
        ),
    );
  }
}