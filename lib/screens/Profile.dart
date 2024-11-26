import 'package:flutter/material.dart';
import 'package:gift_planner/provider/uersprovider.dart';
import 'package:gift_planner/utils/design_components.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'dart:io';
import 'package:provider/provider.dart'; // For File handling

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    return Scaffold(
      backgroundColor: AppStyles.background,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: AppStyles.primaryColor,
        foregroundColor: AppStyles.foregroundColor,
        title: const Text("Profile"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            ProfilePic(
                image: user.profileImage ??
                    'default_image_url'), // Default image URL if profileImage is null
            Text(
              user.username ?? 'Username',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 16.0 * 2),
            Info(infoKey: "First Name", info: user.username ?? "First Name"),
            Info(infoKey: "Last Name", info: user.username ?? 'Last Name'),
            Info(infoKey: "Phone", info: user.phoneNumber ?? 'Phone Number'),
            Info(infoKey: "Email Address", info: user.email ?? 'Email Address'),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 160,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppStyles.primaryColor,
                    foregroundColor: AppStyles.foregroundColor,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/editProfile');
                  },
                  child: const Text("Edit profile"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfilePic extends StatefulWidget {
  final String image;

  const ProfilePic({
    super.key,
    required this.image,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  late String _image;

  @override
  void initState() {
    super.initState();
    _image = widget.image;
  }

  Future<void> _pickImage() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Pick from gallery
    );

    if (pickedFile != null) {
      setState(() {
        _image = pickedFile.path; // Update with selected image path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
              Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.08),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: _image.isEmpty
                ? const AssetImage(
                    'images/user.png') // Default image if no profile picture
                : FileImage(File(_image)) as ImageProvider,
          ),
          Positioned(
            right: -8, // Position the "+" icon on the right side
            bottom: -8,
            child: GestureDetector(
              onTap: _pickImage,
              child: const CircleAvatar(
                radius: 18,
                backgroundColor: AppStyles.background,
                child: Icon(
                  Icons.add,
                  color: AppStyles.favoritIconColor,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.infoKey,
    required this.info,
  });

  final String infoKey, info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoKey,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withOpacity(0.8),
            ),
          ),
          Text(info),
        ],
      ),
    );
  }
}
