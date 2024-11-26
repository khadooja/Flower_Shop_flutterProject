import 'package:flutter/material.dart';
import 'package:gift_planner/provider/uersprovider.dart';
import 'package:gift_planner/utils/design_components.dart';
import 'package:gift_planner/utils/validators.dart';
import 'package:provider/provider.dart';
// Make sure you have this provider setup

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  // Variables to store form data
  String firstName = '';
  String lastName = '';
  String username = '';
  String email = '';
  String phoneNumber = '';
  String password = '';

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
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'First Name',
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 245, 234, 237),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0 * 1.5, vertical: 16.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  prefixIcon: Icon(Icons.person_outline),
                                ),
                                validator: ValidationUtils.validateName,
                                onSaved: (value) => firstName = value!,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Last Name',
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 245, 234, 237),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0 * 1.5, vertical: 16.0),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                  prefixIcon: Icon(Icons.person),
                                ),
                                validator: ValidationUtils.validateName,
                                onSaved: (value) => lastName = value!,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Username',
                            filled: true,
                            fillColor: Color.fromARGB(255, 245, 234, 237),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            prefixIcon: Icon(Icons.account_circle),
                          ),
                          onSaved: (value) => username = value!,
                          validator: ValidationUtils.validateName,
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: Color.fromARGB(255, 245, 234, 237),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          onSaved: (value) => email = value!,
                          validator: ValidationUtils.validateEmail,
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: const Color.fromARGB(255, 245, 234, 237),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16.0 * 1.5, vertical: 16.0),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                            prefixIcon: const Icon(Icons.lock),
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
                          obscureText: !_passwordVisible,
                          onSaved: (value) => password = value!,
                          validator: ValidationUtils.validatePassword,
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
