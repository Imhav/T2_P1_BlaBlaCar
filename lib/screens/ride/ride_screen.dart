import 'package:flutter/material.dart';
import '../../model/ride/ride.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../theme/theme.dart';
import 'widget/ride_card.dart';

class RidesScreen extends StatelessWidget {
  final RidePref ridePref;
  final List<Ride> rides;

  const RidesScreen({
    super.key,
    required this.ridePref,
    required this.rides,
  });

  @override
  Widget build(BuildContext context) {
    // Filter rides based on matching departure, arrival, and requestedSeats
    List<Ride> matchingRides = rides.where((ride) {
      return ride.departureLocation == ridePref.departure &&
          ride.arrivalLocation == ridePref.arrival;
      // &&
      // ride.departureDate.isAtSameMomentAs(ridePref.departureDate);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Matching Rides",
          style: BlaTextStyles.heading.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        itemCount: matchingRides.length,
        itemBuilder: (context, index) {
          final ride = matchingRides[index];
          return RideCard(
            ride: ride,
          );
        },
      ),
    );
  }
}
