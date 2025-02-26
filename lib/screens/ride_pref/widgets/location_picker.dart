import 'package:flutter/material.dart';
import '../../../dummy_data/dummy_data.dart';
import '../../../model/ride/locations.dart';
import '../../../theme/theme.dart';
import '../../../utils/animations_util.dart';
import '../../../widgets/display/bla_divider.dart';
// Add this import

// LocationTile remains unchanged
class LocationTile extends StatelessWidget {
  final Location location;
  final VoidCallback onTap;

  const LocationTile({
    super.key,
    required this.location,
    required this.onTap,
  });

  @override
  Widget build(BuildContextContext) {
    return ListTile(
      leading: const Icon(Icons.location_on, color: Colors.grey),
      title: Text(location.name, style: BlaTextStyles.body),
      subtitle: Text(
        location.country.name,
        style: BlaTextStyles.body.copyWith(fontSize: 12, color: Colors.grey),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
          horizontal: BlaSpacings.m, vertical: BlaSpacings.s),
    );
  }
}

class LocationPicker extends StatefulWidget {
  final Function(Location) onLocationSelected;

  const LocationPicker({
    super.key,
    required this.onLocationSelected,
  });

  // Add this static method to create the animated route
  static Route<dynamic> route(Function(Location) onLocationSelected) {
    return AnimationUtils.createBottomToTopRoute(
      LocationPicker(onLocationSelected: onLocationSelected),
    );
  }

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

// _LocationPickerState remains largely unchanged
class _LocationPickerState extends State<LocationPicker> {
  final TextEditingController _searchController = TextEditingController();
  final List<Location> _allLocations = fakeLocations;
  List<Location> _filteredLocations = [];
  bool _isInitialState = true;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();
    setState(() {
      _isInitialState = query.isEmpty;
      _filterLocations(query);
    });
  }

  void _filterLocations(String query) {
    if (query.isEmpty) {
      _filteredLocations = [];
    } else {
      _filteredLocations = _allLocations.where((location) {
        final nameMatch =
            location.name.toLowerCase().contains(query.toLowerCase());
        final countryMatch =
            location.country.name.toLowerCase().contains(query.toLowerCase());
        return nameMatch || countryMatch;
      }).toList();
    }
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() {
      _filteredLocations = [];
      _isInitialState = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildSearchField(),
      ),
      body: _buildContent(),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search city or country',
        border: InputBorder.none,
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: _clearSearch,
              )
            : null,
      ),
    );
  }

  Widget _buildContent() {
    if (_isInitialState) {
      return const Center(
        child: Text(
          'Start typing to search locations',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    if (_filteredLocations.isEmpty) {
      return const Center(
        child: Text(
          'No locations found',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _filteredLocations.length,
      separatorBuilder: (context, index) => const BlaDivider(),
      itemBuilder: (context, index) => LocationTile(
        location: _filteredLocations[index],
        onTap: () {
          widget.onLocationSelected(_filteredLocations[index]);
          Navigator.pop(context, _filteredLocations[index]);
        },
      ),
    );
  }
}
