import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../providers/car_provider.dart';
import '../providers/cart_provider.dart';
import '../models/cart_item.dart';

class ProductDetail extends StatefulWidget {
  final String carId;

  const ProductDetail({super.key, required this.carId});

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _pickupTime;
  bool _insurance = false;
  bool _gps = false;
  bool _childSeat = false;

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final car = carProvider.getCarById(widget.carId);

    if (car == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Car Not Found')),
        body: const Center(child: Text('Car not found')),
      );
    }

    final dateFormat = DateFormat('MMM dd, yyyy');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(car.name),
              background: Image.network(
                car.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.directions_car, size: 100),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${car.pricePerDay}/day',
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text(
                            '${car.rating} (${car.reviewCount})',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Car Details
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _buildDetailRow(
                              Icons.calendar_today, 'Year', '${car.year}'),
                          const Divider(),
                          _buildDetailRow(Icons.airline_seat_recline_normal,
                              'Seats', '${car.seats}'),
                          const Divider(),
                          _buildDetailRow(
                              Icons.settings, 'Transmission', car.transmission),
                          const Divider(),
                          _buildDetailRow(Icons.local_gas_station, 'Fuel Type',
                              car.fuelType),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Features
                  Text(
                    'Features',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: car.features.map((feature) {
                      return Chip(
                        label: Text(feature),
                        avatar: const Icon(Icons.check_circle, size: 16),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),

                  // Rental Dates
                  Text(
                    'Rental Period',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              setState(() => _startDate = date);
                            }
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: Text(_startDate == null
                              ? 'Start Date'
                              : dateFormat.format(_startDate!)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: _startDate ?? DateTime.now(),
                              firstDate: _startDate ?? DateTime.now(),
                              lastDate:
                                  DateTime.now().add(const Duration(days: 365)),
                            );
                            if (date != null) {
                              setState(() => _endDate = date);
                            }
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: Text(_endDate == null
                              ? 'End Date'
                              : dateFormat.format(_endDate!)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Pickup Time
                  OutlinedButton.icon(
                    onPressed: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (time != null) {
                        setState(() => _pickupTime = time);
                      }
                    },
                    icon: const Icon(Icons.access_time),
                    label: Text(_pickupTime == null
                        ? 'Select Pickup Time'
                        : 'Pickup: ${_pickupTime!.format(context)}'),
                  ),
                  const SizedBox(height: 24),

                  // Extras
                  Text(
                    'Add Extras',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    title: const Text('Insurance'),
                    subtitle: const Text('\$15/day'),
                    value: _insurance,
                    onChanged: (value) => setState(() => _insurance = value),
                  ),
                  SwitchListTile(
                    title: const Text('GPS Navigation'),
                    subtitle: const Text('\$10/day'),
                    value: _gps,
                    onChanged: (value) => setState(() => _gps = value),
                  ),
                  SwitchListTile(
                    title: const Text('Child Seat'),
                    subtitle: const Text('\$5/day'),
                    value: _childSeat,
                    onChanged: (value) => setState(() => _childSeat = value),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: _startDate == null || _endDate == null
                ? null
                : () {
                    final cartItem = CartItem(
                      id: const Uuid().v4(),
                      car: car,
                      startDate: _startDate!,
                      endDate: _endDate!,
                      insurance: _insurance,
                      gps: _gps,
                      childSeat: _childSeat,
                    );
                    cartProvider.addItem(cartItem);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Added to cart')),
                    );
                    Navigator.pop(context);
                  },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Add to Cart'),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const Spacer(),
        Text(value, style: TextStyle(color: Colors.grey[600])),
      ],
    );
  }
}
