import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeNavBar extends StatelessWidget {
  final void Function(int)? onTabChange;

  const HomeNavBar({Key? key, required this.onTabChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        color: Colors.black,
        activeColor: Colors.grey.shade700,
        tabActiveBorder: Border.all(color: Colors.white),
        tabBackgroundColor: Colors.grey.shade100,
        mainAxisAlignment: MainAxisAlignment.center,
        tabBorderRadius: 16,
        iconSize: 20, // Adjust the icon size here
        textSize: 14, // Adjust the text size here
        onTabChange: (value) => onTabChange!(value),
        tabs: const [
          GButton(icon: Icons.home, text: 'Shop'),
          GButton(
            icon: Icons.shopping_bag_rounded,
            text: 'Cart',
          ),
        ],
      ),
    );
  }
}
