import 'package:flutter/material.dart';
import 'package:gift_planner/provider/uersprovider.dart';
import 'package:gift_planner/utils/design_components.dart';
import 'package:gift_planner/utils/validators.dart';
import 'package:gift_planner/widget/custom_text_filed.dart'; // تأكد من استيراد ملف AppStyles إذا كان موجودًا
import 'package:provider/provider.dart';

class LastNameScreen extends StatefulWidget {
  const LastNameScreen({super.key});

  @override
  _LastNameScreenState createState() => _LastNameScreenState();
}

class _LastNameScreenState extends State<LastNameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true; // التحكم في إخفاء/إظهار كلمة المرور
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

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
                    "Welcome back",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "Glad to see you again!",
                    style: Theme.of(context).textTheme.bodyMedium!,
                  ),
                  const SizedBox(height: 20.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          hintText: 'Email',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          initialValue:
                              user.email, // القيمة الافتراضية للبريد الإلكتروني
                          validator: ValidationUtils.validateEmail,
                          onSaved: (value) {
                            email = value!;
                          },
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
                          initialValue: user.password,
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              userProvider.updateUser(
                                firstName: userProvider.user.firstName,
                                lastName: userProvider.user.lastName,
                                username: userProvider.user.username,
                                phoneNumber: userProvider.user.phoneNumber,
                                email: email,
                                password: password,
                                profileImage: userProvider.user.profileImage,
                              );
                              Navigator.pushNamed(context, '/home');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: AppStyles.seconderyColor,
                            foregroundColor: AppStyles.foregroundColor,
                            minimumSize: const Size(double.infinity, 48),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text("Login"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/password');
                    },
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: Colors.grey),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/sigin');
                    },
                    child: Text.rich(
                      const TextSpan(
                        text: "Don’t have an account? ",
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(color: AppStyles.primaryColor),
                          ),
                        ],
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: AppStyles.textStyle),
                    ),
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
            );
          },
        ),
      ),
    );
  }
}
