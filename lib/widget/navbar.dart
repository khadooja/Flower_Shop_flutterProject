import 'package:flutter/material.dart';
import 'package:gift_planner/utils/design_components.dart';

class HighEndNavbar extends StatefulWidget {
  const HighEndNavbar({super.key});

  @override
  _HighEndNavbarState createState() => _HighEndNavbarState();
}

class _HighEndNavbarState extends State<HighEndNavbar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 204, 204), // لون وردي فاتح
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(
                100, 255, 182, 193), // تأثير ظل خفيف باللون الوردي
            blurRadius: 12,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.white.withOpacity(0.8), // شفافية اللون الأبيض
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _navigateToPage(index);
          });
        },
        selectedItemColor:
            AppStyles.seconderyColor, // اللون الوردي للأيقونات المحددة
        unselectedItemColor: const Color.fromARGB(
            255, 160, 160, 160), // لون الأيقونات غير المحددة
        showSelectedLabels: true,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home, size: 28),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart, size: 28),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person, size: 28),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  void _navigateToPage(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/cart');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }
}
