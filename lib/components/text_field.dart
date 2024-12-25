import 'package:flutter/material.dart';

class GlassmorphicTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final int maxLines;
  final Widget? prefixIcon;
  final Function(String)? onChanged; // Add this line to accept the callback
  final String? Function(String?)? validator;

  const GlassmorphicTextField({
    super.key,
    required this.controller,
    required this.labelText,
    this.maxLines = 1,
    this.onChanged,
    this.prefixIcon,
    this.validator,
    // Make onChanged an optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white.withAlpha((0.1 * 255).toInt()),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.2 * 255).toInt()),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: Colors.white),
        onChanged: onChanged, // Set the onChanged callback
        validator: validator,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 18),
          prefixIcon: prefixIcon,
          hintStyle: TextStyle(color: Colors.white, fontSize: 16.5),
          hintText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
