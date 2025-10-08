import 'package:flutter/material.dart';
import '../models/car.dart';
import '../widgets/car_card.dart';
import '../theme/app_theme.dart';

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final List<Car> cars = Car.getSampleCars();
  String selectedType = 'All';

  @override
  Widget build(BuildContext context) {
    final filteredCars = selectedType == 'All'
        ? cars
        : cars.where((car) => car.type == selectedType).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Cars'),
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredCars.length,
              itemBuilder: (context, index) {
                return CarCard(car: filteredCars[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    final types = ['All', 'Sedan', 'SUV', 'Sports'];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: types.map((type) {
            final isSelected = selectedType == type;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: FilterChip(
                label: Text(type),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    selectedType = type;
                  });
                },
                backgroundColor: AppTheme.surfaceColor,
                selectedColor: AppTheme.primaryColor,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
