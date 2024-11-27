import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Widget? suffixIcon;
  final String? initialValue; // أضف خاصية initialValue هنا

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.suffixIcon,
    this.initialValue, // استدعاء initialValue هنا
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue, // تمرير initialValue إلى TextFormField
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color.fromARGB(255, 245, 234, 237),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
    );
  }
}
