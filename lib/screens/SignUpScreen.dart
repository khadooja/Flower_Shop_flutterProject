import 'package:flutter/material.dart';
import 'package:gift_planner/utils/design_components.dart';
import 'package:gift_planner/utils/validators.dart';
import 'package:gift_planner/widget/custom_text_filed.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String firstName = '';
  String lastName = '';
  String username = '';
  String email = '';
  String password = '';
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),

                // Logo
                Image.asset(
                  "images/logo1.jpg",
                  height: 100,
                ),
                const SizedBox(height: 40),

                // Title
                const Text(
                  "Let's create your account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  "Glad to see you here! Create an account to get started.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // First Name
                CustomTextField(
                  hintText: "First Name",
                  prefixIcon: Icons.person_outline,
                  validator: ValidationUtils.validateName,
                  onSaved: (value) => firstName = value!,
                ),
                const SizedBox(height: 16),

                // Last Name
                CustomTextField(
                  hintText: "Last Name",
                  prefixIcon: Icons.person,
                  validator: ValidationUtils.validateName,
                  onSaved: (value) => lastName = value!,
                ),
                const SizedBox(height: 16),

                // Username
                CustomTextField(
                  hintText: "Username",
                  prefixIcon: Icons.account_circle,
                  validator: ValidationUtils.validateName,
                  onSaved: (value) => username = value!,
                ),
                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  hintText: "Email",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidationUtils.validateEmail,
                  onSaved: (value) => email = value!,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: "Phone Number",
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: ValidationUtils.validatePhoneNumber,
                  onSaved: (value) => email = value!,
                ),
                const SizedBox(height: 16),

                // Password
                CustomTextField(
                  hintText: "Password",
                  prefixIcon: Icons.lock,
                  obscureText: !_passwordVisible,
                  validator: ValidationUtils.validatePassword,
                  onSaved: (value) => password = value!,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Create Account Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      // Perform signup logic here
                      Navigator.pushNamed(context, '/login');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.seconderyColor,
                    foregroundColor: AppStyles.foregroundColor,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const StadiumBorder(),
                  ),
                  child: const Text("Create Account"),
                ),
                const SizedBox(height: 20),

                // Social Media Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialMediaButton(
                      imagePath: "images/google.png",
                      onPressed: () {
                        // Handle Google sign-up logic
                      },
                    ),
                    const SizedBox(width: 20),
                    SocialMediaButton(
                      imagePath: "images/facebook.png",
                      onPressed: () {
                        // Handle Facebook sign-up logic
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const SocialMediaButton({
    super.key,
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
        icon: Image.asset(imagePath, width: 20, height: 20),
        onPressed: onPressed,
      ),
    );
  }
}
