import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:ui_sensemo/screens/home_screen.dart';
import 'package:ui_sensemo/screens/settings.dart';

class NavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChange;
  
  const NavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return GNav(
          selectedIndex: widget.selectedIndex,
          onTabChange: (index) {
            widget.onTabChange(index);
          },
          color: const Color(0xFF00BF62),
          activeColor: Colors.black,
          tabBackgroundColor: const Color(0xFF00BF62),
          padding: const EdgeInsets.all(15),
          gap: 8,
          tabs: const [
            GButton(
              icon: Icons.home,iconSize: 20,
              text: 'Home', textSize: 20,
            ), 
            GButton(
              icon: Icons.settings,iconSize: 20,
              text: 'Settings', textSize: 20,
            )
          ],
    );
  }
}
