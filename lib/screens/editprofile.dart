import 'package:flutter/material.dart';
import 'package:gift_planner/provider/uersprovider.dart';
import 'package:gift_planner/utils/validators.dart';
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
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // First Name
                    TextFormField(
                      initialValue: user.firstName,
                      decoration: const InputDecoration(
                        labelText: "First Name",
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      onSaved: (value) => firstName = value!,
                      validator: ValidationUtils.validateName,
                    ),
                    const SizedBox(height: 10.0),

                    // Last Name
                    TextFormField(
                      initialValue: user.lastName,
                      decoration: const InputDecoration(
                        labelText: "Last Name",
                        prefixIcon: Icon(Icons.person),
                      ),
                      onSaved: (value) => lastName = value!,
                      validator: ValidationUtils.validateName,
                    ),
                    const SizedBox(height: 10.0),

                    // Username
                    TextFormField(
                      initialValue: user.username,
                      decoration: const InputDecoration(
                        labelText: "Username",
                        prefixIcon: Icon(Icons.account_circle),
                      ),
                      onSaved: (value) => username = value!,
                      validator: ValidationUtils.validateName,
                    ),
                    const SizedBox(height: 10.0),

                    // Phone Number
                    TextFormField(
                      initialValue: user.phoneNumber,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Icons.phone),
                      ),
                      onSaved: (value) => phoneNumber = value!,
                      validator: ValidationUtils.validatePhoneNumber,
                    ),
                    const SizedBox(height: 10.0),

                    // Location
                    TextFormField(
                      initialValue: user.email,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                      ),
                      onSaved: (value) => email = value!,
                      validator: ValidationUtils.validateEmail,
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
