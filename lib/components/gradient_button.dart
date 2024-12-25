import 'package:flutter/material.dart';

class GradientButton extends StatefulWidget {
  final VoidCallback onpressed;
  final String text;
  final String? icon;
  const GradientButton(
      {super.key, required this.onpressed, required this.text, this.icon});

  @override
  GradientButtonState createState() => GradientButtonState();
}

class GradientButtonState extends State<GradientButton> {
  // To create the infinite moving gradient effect
  final double _gradientPosition = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the gradient animation
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // Apply gradient animation to the container
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [0.0, 0.5, 1.0],
          colors: [
            Colors.purple.withAlpha((0.8 * 255).toInt()),
            Colors.blue.withAlpha((0.8 * 255).toInt()),
            Colors.pink.withAlpha((0.8 * 255).toInt()),
          ],
          transform: GradientRotation(
              _gradientPosition), // Animate the gradient position
        ),
      ),
      height: 50,
      child: ElevatedButton(
        onPressed: widget.onpressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
              side: BorderSide(
                width: 2.0,
                color: Colors
                    .transparent, // Border is transparent, only the gradient is visible
              ),
            ),
          ),
          elevation: WidgetStateProperty.all(0), // Remove shadow
        ),
        child: Container(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(children: [
                TextSpan(text: widget.icon, style: TextStyle(fontSize: 25.0)),
                TextSpan(text: widget.text, style: TextStyle(fontSize: 16.0)),
              ]),
            )),
      ),
    );
  }
}
