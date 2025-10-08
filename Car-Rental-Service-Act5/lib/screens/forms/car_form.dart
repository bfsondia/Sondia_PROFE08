import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../../providers/car_provider.dart';
import '../../models/car.dart';

class CarForm extends StatefulWidget {
  const CarForm({super.key});

  @override
  State<CarForm> createState() => _CarFormState();
}

class _CarFormState extends State<CarForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _brandController = TextEditingController();
  final _modelController = TextEditingController();
  final _yearController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageUrlController = TextEditingController();

  String _category = 'Sedan';
  int _seats = 5;
  String _transmission = 'Automatic';
  String _fuelType = 'Petrol';
  final List<String> _selectedFeatures = [];

  final List<String> _availableFeatures = [
    'Air Conditioning',
    'Bluetooth',
    'GPS Navigation',
    'Backup Camera',
    'Sunroof',
    'Leather Seats',
    'Heated Seats',
    'Apple CarPlay',
    'Android Auto',
    'Cruise Control',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Car'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Car Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter car name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _brandController,
                    decoration: const InputDecoration(
                      labelText: 'Brand',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _modelController,
                    decoration: const InputDecoration(
                      labelText: 'Model',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _yearController,
                    decoration: const InputDecoration(
                      labelText: 'Year',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _priceController,
                    decoration: const InputDecoration(
                      labelText: 'Price per Day',
                      prefixText: '\$',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _imageUrlController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter image URL';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: ['Sedan', 'SUV', 'Luxury', 'Electric']
                  .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                  .toList(),
              onChanged: (value) => setState(() => _category = value!),
            ),
            const SizedBox(height: 16),
            Text('Number of Seats: $_seats',
                style: Theme.of(context).textTheme.titleMedium),
            Slider(
              value: _seats.toDouble(),
              min: 2,
              max: 8,
              divisions: 6,
              label: '$_seats seats',
              onChanged: (value) => setState(() => _seats = value.toInt()),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _transmission,
              decoration: const InputDecoration(
                labelText: 'Transmission',
                border: OutlineInputBorder(),
              ),
              items: ['Automatic', 'Manual']
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (value) => setState(() => _transmission = value!),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _fuelType,
              decoration: const InputDecoration(
                labelText: 'Fuel Type',
                border: OutlineInputBorder(),
              ),
              items: ['Petrol', 'Diesel', 'Electric', 'Hybrid']
                  .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                  .toList(),
              onChanged: (value) => setState(() => _fuelType = value!),
            ),
            const SizedBox(height: 24),
            Text('Features', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _availableFeatures.map((feature) {
                final isSelected = _selectedFeatures.contains(feature);
                return FilterChip(
                  label: Text(feature),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedFeatures.add(feature);
                      } else {
                        _selectedFeatures.remove(feature);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Add Car'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final carProvider = Provider.of<CarProvider>(context, listen: false);

      final car = Car(
        id: const Uuid().v4(),
        name: _nameController.text,
        brand: _brandController.text,
        model: _modelController.text,
        year: int.parse(_yearController.text),
        pricePerDay: double.parse(_priceController.text),
        imageUrl: _imageUrlController.text,
        category: _category,
        seats: _seats,
        transmission: _transmission,
        fuelType: _fuelType,
        rating: 4.5,
        reviewCount: 0,
        features: _selectedFeatures,
      );

      carProvider.addCar(car);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Car added successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }
}
