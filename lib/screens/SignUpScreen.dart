import 'package:flutter/material.dart';
import 'package:gift_planner/provider/uersprovider.dart';
import 'package:gift_planner/utils/design_components.dart';
import 'package:gift_planner/utils/validators.dart';
import 'package:gift_planner/widget/custom_text_filed.dart';
import 'package:provider/provider.dart';

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
  String phoneNumber = "";
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyles.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Image.asset(
                    "images/logo1.jpg",
                    height: 100,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Text(
                    "Let's create your account",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Glad to see you here! Create an account to get started.",
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  const SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // First and Last Name fields
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextField(
                                hintText: "First Name",
                                prefixIcon: Icons.person_outline,
                                validator: ValidationUtils.validateName,
                                onSaved: (value) => firstName = value!,
                                initialValue: '',
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: CustomTextField(
                                hintText: "Last Name",
                                prefixIcon: Icons.person,
                                validator: ValidationUtils.validateName,
                                onSaved: (value) => lastName = value!,
                                initialValue: '',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          hintText: "Username",
                          prefixIcon: Icons.account_circle,
                          validator: ValidationUtils.validateName,
                          onSaved: (value) => username = value!,
                          initialValue: '',
                        ),
                        const SizedBox(height: 20.0),
                        CustomTextField(
                          hintText: "Email",
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: ValidationUtils.validateEmail,
                          onSaved: (value) => email = value!,
                          initialValue: '',
                        ),
                        const SizedBox(height: 16),

                        CustomTextField(
                          hintText: "Phone Number",
                          prefixIcon: Icons.phone_android_outlined,
                          keyboardType: TextInputType.phone,
                          validator: ValidationUtils.validatePhoneNumber,
                          onSaved: (value) => phoneNumber = value!,
                          initialValue: '',
                        ),
                        const SizedBox(height: 20.0),
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
                          initialValue: '',
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              // Update user data using Provider
                              Provider.of<UserProvider>(context, listen: false)
                                  .updateUser(
                                firstName: firstName,
                                lastName: lastName,
                                username: username,
                                email: email,
                                phoneNumber: phoneNumber,
                                password: password,
                                profileImage: '',
                              );
                              Navigator.pushNamed(context, '/login');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppStyles.seconderyColor,
                            foregroundColor: AppStyles.foregroundColor,
                            minimumSize: const Size(double.infinity, 48),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text("Create Account"),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppStyles.textStyle),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Image(
                                  width: 20,
                                  height: 20,
                                  image: AssetImage("images/google.png"),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppStyles.textStyle),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: IconButton(
                                onPressed: () {},
                                icon: const Image(
                                  width: 20,
                                  height: 20,
                                  image: AssetImage("images/facebook.png"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
