import 'package:flutter/material.dart';
import '../../../model/ride/ride.dart';
import '../../../theme/theme.dart';

class RideCard extends StatelessWidget {
  final Ride ride;

  const RideCard({super.key, required this.ride});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Departure: ${ride.departureLocation.name}",
              style: BlaTextStyles.body,
            ),
            SizedBox(height: 8.0),
            Text(
              "Departure: ${ride.arrivalLocation.name}",
              style: BlaTextStyles.body,
            ),
            SizedBox(height: 8.0),
            Text(
              "Available seats: ${ride.remainingSeats}",
              style: BlaTextStyles.body,
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
