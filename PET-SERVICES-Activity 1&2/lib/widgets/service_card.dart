// Step 8: Refactored smaller reusable widgets
import 'package:flutter/material.dart';
import '../models/pet_service.dart';
import '../views/service_detail_screen.dart';
import 'custom_button.dart';

class ServiceCard extends StatelessWidget {
  final PetService service;

  const ServiceCard({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ServiceDetailScreen(service: service),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ServiceHeader(service: service),
              SizedBox(height: 12),
              ServiceDescription(description: service.description),
              SizedBox(height: 16),
              ServiceFooter(service: service),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceHeader extends StatelessWidget {
  final PetService service;

  const ServiceHeader({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              service.icon,
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                '₱${service.price.toStringAsFixed(2)} • ${service.duration}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ServiceDescription extends StatelessWidget {
  final String description;

  const ServiceDescription({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey[600],
            height: 1.4,
          ),
    );
  }
}

class ServiceFooter extends StatelessWidget {
  final PetService service;

  const ServiceFooter({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: 'Book Now',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceDetailScreen(service: service),
                ),
              );
            },
            icon: Icons.calendar_today,
          ),
        ),
        SizedBox(width: 12),
        IconButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${service.name} added to favorites!'),
                duration: Duration(seconds: 2),
              ),
            );
          },
          icon: Icon(Icons.favorite_border),
          style: IconButton.styleFrom(
            backgroundColor: Colors.grey[100],
            foregroundColor: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}
