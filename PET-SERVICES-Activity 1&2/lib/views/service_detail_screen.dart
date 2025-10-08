import 'package:flutter/material.dart';
import '../models/pet_service.dart';
import '../widgets/custom_button.dart';

class ServiceDetailScreen extends StatelessWidget {
  final PetService service;

  const ServiceDetailScreen({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(service.name),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ServiceHeroSection(service: service),
            SizedBox(height: 24),
            ServiceDetailsSection(service: service),
            SizedBox(height: 24),
            ServiceFeaturesSection(service: service),
            SizedBox(height: 24),
            BookingSection(service: service),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class ServiceHeroSection extends StatelessWidget {
  final PetService service;

  const ServiceHeroSection({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                service.icon,
                style: TextStyle(fontSize: 40),
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            service.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            '₱${service.price.toStringAsFixed(2)} • ${service.duration}',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceDetailsSection extends StatelessWidget {
  final PetService service;

  const ServiceDetailsSection({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About This Service',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 12),
          Text(
            service.detailedDescription,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: Colors.grey[700],
                ),
          ),
        ],
      ),
    );
  }
}

class ServiceFeaturesSection extends StatelessWidget {
  final PetService service;

  const ServiceFeaturesSection({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'What\'s Included',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          SizedBox(height: 16),
          ...service.features.map((feature) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 20,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.4,
                            ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class BookingSection extends StatelessWidget {
  final PetService service;

  const BookingSection({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          CustomButton(
            text: 'Book ${service.name}',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Book ${service.name}'),
                  content: Text(
                      'Thank you for your interest! Our booking system will be available soon. Please call us at 09816135823 to schedule your appointment.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('OK'),
                    ),
                  ],
                ),
              );
            },
            icon: Icons.calendar_today,
          ),
          SizedBox(height: 12),
          CustomButton(
            text: 'Call Now: 09816135823',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Calling feature would open phone dialer'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: Icons.phone,
            backgroundColor: Colors.green[600],
          ),
        ],
      ),
    );
  }
}
