class User {
  String firstName;
  String lastName;
  String username;
  String phoneNumber;
  String email;
  String profileImage;

  User({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.phoneNumber,
    required this.email,
    required this.profileImage,
  });

  get password => null;
}
