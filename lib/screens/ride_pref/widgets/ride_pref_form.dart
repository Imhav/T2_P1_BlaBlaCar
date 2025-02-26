import 'package:flutter/material.dart';
import '../../../dummy_data/dummy_data.dart';
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../widgets/actions/blabutton.dart';
import '../../../widgets/display/bla_divider.dart';
// Import dummy data for initial locations

// This is a StatefulWidget that creates a reusable form for displaying ride preferences,
class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref; // Optional initial ride preferences

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  late Location departure; // Departure location, initialized later
  late DateTime departureDate; // Departure date, initialized later
  late Location arrival; // Arrival location, initialized later
  late int requestedSeats; // Number of requested seats, initialized later

  // Sets up the initial state of the form, using provided RidePref or defaults from dummy data.
  @override
  void initState() {
    super.initState();
    _initializeRidePreferences();
  }

  // Initializes ride preferences with defaults or from initRidePref.
  void _initializeRidePreferences() {
    final initialPref = widget.initRidePref ??
        RidePref(
          // Default preferences if none provided
          departure:
              fakeLocations[0], // Default to first location (e.g., London)
          departureDate: DateTime(2025, 2, 22), // Default to Sat 22 Feb 2025
          arrival:
              fakeLocations[1], // Default to second location (e.g., Manchester)
          requestedSeats: 1, // Default to 1 seat
        );

    departure = initialPref.departure; // Assign departure location
    departureDate = initialPref.departureDate; // Assign departure date
    arrival = initialPref.arrival; // Assign arrival location
    requestedSeats = initialPref.requestedSeats; // Assign requested seats
  }

  // Swaps the departure and arrival locations when triggered.
  void _switchLocations() {
    setState(() {
      final temp = departure; // Temporary variable to hold departure
      departure = arrival; // Swap departure with arrival
      arrival = temp; // Swap arrival with temporary value
    });
  }

  // Checks if locations are selected and creates a RidePref object for search.
  // Currently a placeholder, printing the result for demonstration.
  void _onSearchPressed() {
    if (departure != null && arrival != null) {
      // Check if both locations are valid
      RidePref ridePref = RidePref(
        // Create RidePref object
        departure: departure,
        arrival: arrival,
        departureDate: departureDate,
        requestedSeats: requestedSeats,
      );
      print('Search with preferences: $ridePref'); // Output for testing
    }
  }

  // Constructs the form UI with a card layout, custom tiles, and a search button.
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BlaSpacings.m),
      child: Container(
        decoration: _containerDecoration(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(BlaSpacings.m),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTile(
                  title: 'Departure City',
                  subtitle: departure.name,
                  icon: Icons.radio_button_unchecked,
                  trailingIcon: Icons.swap_vert,
                  onTrailingPressed: _switchLocations,
                ),
                BlaDivider(),
                _buildTile(
                  title: 'Arrival City',
                  subtitle: arrival.name,
                  icon: Icons.radio_button_unchecked,
                ),
                BlaDivider(),
                _buildTile(
                  title: 'Date',
                  subtitle: 'Today',
                  icon: Icons.calendar_today,
                ),
                BlaDivider(),
                _buildTile(
                  title: 'Travelers',
                  subtitle: '$requestedSeats',
                  icon: Icons.person,
                ),
                SizedBox(height: BlaSpacings.m),
                Center(
                  child: BlaButton(
                    text: 'Search',
                    type: ButtonType.primary,
                    onPressed: _onSearchPressed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Creates a custom tile for each form field, including an icon, title, subtitle,
  Widget _buildTile({
    required String title,
    required String subtitle,
    required IconData icon,
    IconData? trailingIcon,
    VoidCallback? onTrailingPressed,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey),
      title: Text(title, style: BlaTextStyles.body),
      subtitle: Text(subtitle, style: BlaTextStyles.body),
      trailing: trailingIcon != null
          ? IconButton(
              icon: Icon(trailingIcon, color: BlaColors.primary),
              onPressed: onTrailingPressed,
            )
          : null,
      contentPadding: EdgeInsets.symmetric(horizontal: BlaSpacings.m),
    );
  }

  BoxDecoration _containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(BlaSpacings.radius),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ],
    );
  }
}
