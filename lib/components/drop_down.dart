import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlassmorphicDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;
  final List<DropdownMenuItem<String>> items;

  const GlassmorphicDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
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
      child: DropdownButtonFormField<String>(
        value: value,
        onChanged: onChanged,
        items: items,
        hint: Text("Subject",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.5,
                fontFamily: GoogleFonts.playfair().fontFamily)),
        style: TextStyle(color: Colors.white),
        dropdownColor: const Color.fromARGB(255, 37, 11, 83),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.only(top: 18),
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              "📚",
              style: TextStyle(fontSize: 30),
            ),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
