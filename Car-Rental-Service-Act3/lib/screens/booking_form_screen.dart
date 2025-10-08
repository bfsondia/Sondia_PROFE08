import 'package:flutter/material.dart';
import '../models/car.dart';
import '../models/booking.dart';
import '../services/validation_service.dart';
import '../theme/app_theme.dart';
import 'booking_confirmation_screen.dart';

class BookingFormScreen extends StatefulWidget {
  final Car car;

  const BookingFormScreen({super.key, required this.car});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  DateTime? _pickupDate;
  DateTime? _returnDate;
  String? _pickupLocation;
  String? _returnLocation;

  final List<String> _locations = [
    'Downtown Office',
    'Airport Terminal',
    'North Station',
    'South Mall',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isPickup) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppTheme.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isPickup) {
          _pickupDate = picked;
        } else {
          _returnDate = picked;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_pickupDate == null || _returnDate == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select pickup and return dates'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (_pickupLocation == null || _returnLocation == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select pickup and return locations'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final dateValidation = ValidationService.validateDateRange(
        _pickupDate,
        _returnDate,
      );

      if (dateValidation != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(dateValidation),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final rentalDays = _returnDate!.difference(_pickupDate!).inDays;
      final totalPrice = widget.car.pricePerDay * rentalDays;

      final booking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        carId: widget.car.id,
        userName: _nameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        pickupDate: _pickupDate!,
        returnDate: _returnDate!,
        pickupLocation: _pickupLocation!,
        returnLocation: _returnLocation!,
        totalPrice: totalPrice,
        additionalNotes:
            _notesController.text.isEmpty ? null : _notesController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BookingConfirmationScreen(
            booking: booking,
            car: widget.car,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Car'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Car Summary
            _buildCarSummary(),
            const SizedBox(height: 32),

            // Personal Information Section
            _buildSectionTitle('Personal Information'),
            const SizedBox(height: 16),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
              validator: ValidationService.validateName,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: ValidationService.validateEmail,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                prefixIcon: Icon(Icons.phone),
              ),
              keyboardType: TextInputType.phone,
              validator: ValidationService.validatePhone,
            ),
            const SizedBox(height: 32),

            // Rental Details Section
            _buildSectionTitle('Rental Details'),
            const SizedBox(height: 16),

            // Pickup Date
            InkWell(
              onTap: () => _selectDate(context, true),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Pickup Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _pickupDate == null
                      ? 'Select date'
                      : '${_pickupDate!.day}/${_pickupDate!.month}/${_pickupDate!.year}',
                  style: TextStyle(
                    color: _pickupDate == null
                        ? AppTheme.textSecondary
                        : AppTheme.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Return Date
            InkWell(
              onTap: () => _selectDate(context, false),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Return Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                child: Text(
                  _returnDate == null
                      ? 'Select date'
                      : '${_returnDate!.day}/${_returnDate!.month}/${_returnDate!.year}',
                  style: TextStyle(
                    color: _returnDate == null
                        ? AppTheme.textSecondary
                        : AppTheme.textPrimary,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Pickup Location
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Pickup Location',
                prefixIcon: Icon(Icons.location_on),
              ),
              value: _pickupLocation,
              items: _locations.map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _pickupLocation = value;
                });
              },
              validator: (value) =>
                  ValidationService.validateRequired(value, 'Pickup location'),
            ),
            const SizedBox(height: 16),

            // Return Location
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Return Location',
                prefixIcon: Icon(Icons.location_on),
              ),
              value: _returnLocation,
              items: _locations.map((location) {
                return DropdownMenuItem(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _returnLocation = value;
                });
              },
              validator: (value) =>
                  ValidationService.validateRequired(value, 'Return location'),
            ),
            const SizedBox(height: 16),

            // Additional Notes
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Additional Notes (Optional)',
                prefixIcon: Icon(Icons.note),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 32),

            // Price Summary
            if (_pickupDate != null && _returnDate != null)
              _buildPriceSummary(),

            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Confirm Booking',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              widget.car.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.directions_car),
                );
              },
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.car.brand} ${widget.car.name}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.car.type,
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${widget.car.pricePerDay.toStringAsFixed(0)}/day',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppTheme.textPrimary,
      ),
    );
  }

  Widget _buildPriceSummary() {
    final rentalDays = _returnDate!.difference(_pickupDate!).inDays;
    final totalPrice = widget.car.pricePerDay * rentalDays;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rental Days:',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '$rentalDays days',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price per day:',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '\$${widget.car.pricePerDay.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Total Price:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
