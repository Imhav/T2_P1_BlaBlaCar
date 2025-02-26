import 'package:flutter/material.dart';
import '../../theme/theme.dart';

// Enum to define button types
enum ButtonType { primary, secondary }

// This is a helper class that defines reusable button styles for the BlaButton widget.
// It provides a centralized way to configure button appearance (e.g., colors, borders, padding)
// using a private base style method and public methods for primary/secondary styles.
class BlaButtonStyle {
  // Private method to create a base button style with shared properties
  static ButtonStyle _baseStyle(
      Color background, Color foreground, BorderSide? border) {
    return ElevatedButton.styleFrom(
      backgroundColor: background,
      foregroundColor: foreground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(BlaSpacings.radius),
        side: border ??
            BorderSide.none, // Optional border (used for secondary type)
      ),
      elevation: 0, // Flat design with no shadow
      padding:
          EdgeInsets.symmetric(vertical: BlaSpacings.m), // Vertical padding
      minimumSize:
          const Size(double.infinity, 50), // Full-width, fixed-height button
    );
  }

  // Primary style: blue background, white text, no border
  static ButtonStyle primary(BuildContext context) =>
      _baseStyle(BlaColors.primary, BlaColors.white, null);

  // Secondary style: white background, blue text, blue border
  static ButtonStyle secondary(BuildContext context) => _baseStyle(
      BlaColors.white,
      BlaColors.primary,
      BorderSide(color: BlaColors.primary, width: 1.0));
}

// This is a reusable stateless widget that creates a styled button based on the ButtonType.
// It takes text, type, and an onPressed callback as parameters.
class BlaButton extends StatelessWidget {
  final String text;
  final ButtonType type;
  final VoidCallback onPressed;

  const BlaButton({
    super.key,
    required this.text,
    required this.type,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // - If type is ButtonType.primary, it uses BlaButtonStyle.primary (blue background, white text).
    // - Otherwise, it uses BlaButtonStyle.secondary (white background, blue text/border).

    return ElevatedButton(
      onPressed: onPressed,
      style: type == ButtonType.primary
          ? BlaButtonStyle.primary(context)
          : BlaButtonStyle.secondary(context),
      child: Text(text, style: BlaTextStyles.button),
    );
  }
}

// Demo page to showcase BlaButton usage
class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(BlaSpacings.m), // Margin around content
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Vertically center buttons
          children: [
            BlaButton(
              text: 'Contact Volodia',
              type: ButtonType.secondary,
              onPressed: () => print('Contact Volodia clicked!'),
            ),
            const SizedBox(height: BlaSpacings.m), // Spacing between buttons
            BlaButton(
              text: 'Request to book',
              type: ButtonType.primary,
              onPressed: () => print('Request to book clicked!'),
            ),
          ],
        ),
      ),
    );
  }
}

// App entry point
void main() {
  runApp(MaterialApp(
    theme: appTheme, // Apply consistent app styling
    home: const ButtonPage(), // Display the demo page
  ));
}
