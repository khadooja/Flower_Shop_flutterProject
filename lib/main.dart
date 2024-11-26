import 'package:flutter/material.dart';
import 'package:gift_planner/provider/CartProvider.dart'; // تأكد من استيراد FavoriteProvider
import 'package:gift_planner/provider/FavoritesProvide.dart';
import 'package:gift_planner/screens/Profile.dart';
import 'package:gift_planner/screens/Registration_option.dart';
import 'package:gift_planner/screens/allProductsPage.dart';
import 'package:gift_planner/screens/cart_screen.dart';
import 'package:gift_planner/screens/editprofile.dart';
import 'package:gift_planner/screens/favorit_screen.dart';
import 'package:gift_planner/screens/forgetpass.dart';
import 'package:gift_planner/screens/home_screen.dart';
import 'package:gift_planner/screens/login_page.dart';
import 'package:gift_planner/screens/onboarding_screen.dart';
import 'package:gift_planner/screens/password.dart';
import 'package:gift_planner/provider/uersprovider.dart';
import 'package:gift_planner/screens/welcom.dart';
import 'package:provider/provider.dart';

import 'screens/SignUpScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Manager',
      initialRoute: '/welcome',
      debugShowCheckedModeBanner: false,
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/onboarding': (context) => const SplashScreens(),
        '/signorlog': (context) => const SigninOrSignupScreen(),
        '/login': (context) => LastNameScreen(),
        '/password': (context) => const ForgotPasswordScreen(),
        '/ChangePassword': (context) => ChangePasswordScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/editProfile': (context) => const EditProfileScreen(),
        '/sigin': (context) => const SignUpPage(),
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(
              cartItems: [],
            ),
        '/favorites': (context) => const FavoriteScreen(),
        '/prodect': (context) => const ProductsScreen(),
      },
    );
  }
}
