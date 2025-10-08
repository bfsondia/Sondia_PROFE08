import '../models/car.dart';

class CarService {
  // Mock data for demonstration
  static List<Car> getAllCars() {
    return [
      Car(
        id: '1',
        name: 'Model S',
        brand: 'Tesla',
        type: 'Sedan',
        pricePerDay: 120.0,
        seats: 5,
        transmission: 'Automatic',
        fuelType: 'Electric',
        rating: 4.8,
        reviews: 245,
        imageUrl:
            'https://media.ed.edmunds-media.com/tesla/model-s/2025/oem/2025_tesla_model-s_sedan_plaid_fq_oem_1_1600.jpg',
        features: ['Autopilot', 'Premium Sound', 'Heated Seats', 'GPS'],
      ),
      Car(
        id: '2',
        name: 'Camry',
        brand: 'Toyota',
        type: 'Sedan',
        pricePerDay: 65.0,
        seats: 5,
        transmission: 'Automatic',
        fuelType: 'Hybrid',
        rating: 4.6,
        reviews: 189,
        imageUrl: '/placeholder.svg?height=200&width=300',
        features: ['Bluetooth', 'Backup Camera', 'Cruise Control', 'USB Ports'],
      ),
      Car(
        id: '3',
        name: 'Wrangler',
        brand: 'Jeep',
        type: 'SUV',
        pricePerDay: 95.0,
        seats: 5,
        transmission: 'Manual',
        fuelType: 'Gasoline',
        rating: 4.7,
        reviews: 156,
        imageUrl: '/placeholder.svg?height=200&width=300',
        features: ['4WD', 'Off-Road Package', 'Removable Top', 'Winch'],
      ),
      Car(
        id: '4',
        name: 'Accord',
        brand: 'Honda',
        type: 'Sedan',
        pricePerDay: 70.0,
        seats: 5,
        transmission: 'Automatic',
        fuelType: 'Gasoline',
        rating: 4.5,
        reviews: 203,
        imageUrl: '/placeholder.svg?height=200&width=300',
        features: ['Apple CarPlay', 'Lane Assist', 'Sunroof', 'Leather Seats'],
      ),
      Car(
        id: '5',
        name: 'X5',
        brand: 'BMW',
        type: 'SUV',
        pricePerDay: 150.0,
        seats: 7,
        transmission: 'Automatic',
        fuelType: 'Gasoline',
        rating: 4.9,
        reviews: 178,
        imageUrl: '/placeholder.svg?height=200&width=300',
        features: ['Premium Package', 'Panoramic Roof', 'Massage Seats', 'HUD'],
      ),
      Car(
        id: '6',
        name: 'Mustang',
        brand: 'Ford',
        type: 'Sports',
        pricePerDay: 110.0,
        seats: 4,
        transmission: 'Manual',
        fuelType: 'Gasoline',
        rating: 4.7,
        reviews: 167,
        imageUrl: '/placeholder.svg?height=200&width=300',
        features: [
          'Sport Mode',
          'Performance Exhaust',
          'Track Apps',
          'Brembo Brakes'
        ],
      ),
    ];
  }

  static List<Car> searchCars(String query) {
    final allCars = getAllCars();
    if (query.isEmpty) return allCars;

    return allCars.where((car) {
      return car.name.toLowerCase().contains(query.toLowerCase()) ||
          car.brand.toLowerCase().contains(query.toLowerCase()) ||
          car.type.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  static List<Car> filterByType(String type) {
    if (type == 'All') return getAllCars();
    return getAllCars().where((car) => car.type == type).toList();
  }

  static Car? getCarById(String id) {
    try {
      return getAllCars().firstWhere((car) => car.id == id);
    } catch (e) {
      return null;
    }
  }
}
