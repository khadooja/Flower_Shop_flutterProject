import 'package:flutter/material.dart';
import 'package:gift_planner/provider/uersprovider.dart';
import 'package:gift_planner/utils/design_components.dart';
import 'package:gift_planner/utils/validators.dart';
import 'package:gift_planner/widget/custom_text_filed.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String firstName, lastName, username, phoneNumber, email;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // العودة إلى صفحة الملف الشخصي
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Edit Your Profile",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // First Name
                    CustomTextField(
                      hintText: "First Name",
                      prefixIcon: Icons.person,
                      validator: ValidationUtils.validateName,
                      onSaved: (value) => lastName = value!,
                    ),
                    const SizedBox(height: 10.0),

                    // Last Name
                    CustomTextField(
                      hintText: "Last Name",
                      prefixIcon: Icons.person,
                      validator: ValidationUtils.validateName,
                      onSaved: (value) => lastName = value!,
                    ),
                    const SizedBox(height: 10.0),

                    // Username
                    CustomTextField(
                      hintText: "Username",
                      prefixIcon: Icons.account_circle,
                      validator: ValidationUtils.validateName,
                      onSaved: (value) => username = value!,
                    ),
                    const SizedBox(height: 10.0),

                    // Phone Number
                    CustomTextField(
                      hintText: "Phone Number",
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidationUtils.validatePhoneNumber,
                      onSaved: (value) => email = value!,
                    ),
                    const SizedBox(height: 10.0),

                    // Location
                    CustomTextField(
                      hintText: "Email",
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: ValidationUtils.validateEmail,
                      onSaved: (value) => email = value!,
                    ),
                    const SizedBox(height: 20.0),

                    // Save Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            userProvider.updateUser(
                              firstName: firstName,
                              lastName: lastName,
                              username: username,
                              phoneNumber: phoneNumber,
                              password: '',
                              email: email,
                              profileImage: '',
                            );
                            Navigator.pop(
                                context); // العودة إلى صفحة الملف الشخصي
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppStyles.seconderyColor,
                          foregroundColor:
                              AppStyles.foregroundColor, // لون النص
                          elevation: 5, // التحكم في الظل
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // جعل الحواف مستديرة
                          ),
                        ),
                        child: const Text("Save Changes"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
