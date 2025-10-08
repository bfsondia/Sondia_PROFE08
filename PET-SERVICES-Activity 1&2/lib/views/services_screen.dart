import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/pet_service.dart';
import '../widgets/service_card.dart';

// Step 5: Material Design and Cupertino Widgets for the same UI
class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  bool _useCupertinoStyle = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle between Material and Cupertino styles
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Our Services',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Row(
                children: [
                  Text('iOS Style'),
                  SizedBox(width: 8),
                  _useCupertinoStyle
                      ? CupertinoSwitch(
                          value: _useCupertinoStyle,
                          onChanged: (value) {
                            setState(() {
                              _useCupertinoStyle = value;
                            });
                          },
                        )
                      : Switch(
                          value: _useCupertinoStyle,
                          onChanged: (value) {
                            setState(() {
                              _useCupertinoStyle = value;
                            });
                          },
                        ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: _useCupertinoStyle
              ? _buildCupertinoServicesList()
              : _buildMaterialServicesList(),
        ),
      ],
    );
  }

  Widget _buildMaterialServicesList() {
    return ListView.builder(
      itemCount: PetServiceData.services.length,
      itemBuilder: (context, index) {
        return ServiceCard(service: PetServiceData.services[index]);
      },
    );
  }

  Widget _buildCupertinoServicesList() {
    return CupertinoScrollbar(
      child: ListView.builder(
        itemCount: PetServiceData.services.length,
        itemBuilder: (context, index) {
          final service = PetServiceData.services[index];
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CupertinoListTile(
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: CupertinoColors.systemBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    service.icon,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              title: Text(
                service.name,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text(
                service.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '₱${service.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemBlue,
                    ),
                  ),
                  Text(
                    service.duration,
                    style: TextStyle(
                      fontSize: 12,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
              onTap: () {
                // Navigate to service detail
              },
            ),
          );
        },
      ),
    );
  }
}
