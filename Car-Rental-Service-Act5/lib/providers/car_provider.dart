import 'package:flutter/foundation.dart';
import '../models/car.dart';

class CarProvider extends ChangeNotifier {
  List<Car> _cars = [];
  String _searchQuery = '';
  String _selectedCategory = 'All';
  double _minPrice = 0;
  double _maxPrice = 500;

  List<Car> get cars {
    return _cars.where((car) {
      final matchesSearch =
          car.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              car.brand.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || car.category == _selectedCategory;
      final matchesPrice =
          car.pricePerDay >= _minPrice && car.pricePerDay <= _maxPrice;

      return matchesSearch && matchesCategory && matchesPrice;
    }).toList();
  }

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  double get minPrice => _minPrice;
  double get maxPrice => _maxPrice;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setPriceRange(double min, double max) {
    _minPrice = min;
    _maxPrice = max;
    notifyListeners();
  }

  void loadCars() {
    // Sample data - replace with API call
    _cars = [
      Car(
        id: '1',
        name: 'Tesla Model 3',
        brand: 'Tesla',
        model: 'Model 3',
        year: 2024,
        pricePerDay: 120,
        imageUrl: 'https://images.unsplash.com/photo-1560958089-b8a1929cea89',
        category: 'Electric',
        seats: 5,
        transmission: 'Automatic',
        fuelType: 'Electric',
        rating: 4.8,
        reviewCount: 245,
        features: ['Autopilot', 'Premium Audio', 'Glass Roof'],
      ),
      Car(
        id: '2',
        name: 'BMW X5',
        brand: 'BMW',
        model: 'X5',
        year: 2023,
        pricePerDay: 150,
        imageUrl: 'https://images.unsplash.com/photo-1555215695-3004980ad54e',
        category: 'SUV',
        seats: 7,
        transmission: 'Automatic',
        fuelType: 'Diesel',
        rating: 4.7,
        reviewCount: 189,
        features: ['4WD', 'Leather Seats', 'Sunroof'],
      ),
      Car(
        id: '3',
        name: 'Mercedes C-Class',
        brand: 'Mercedes',
        model: 'C-Class',
        year: 2024,
        pricePerDay: 130,
        imageUrl:
            'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8',
        category: 'Luxury',
        seats: 5,
        transmission: 'Automatic',
        fuelType: 'Petrol',
        rating: 4.9,
        reviewCount: 312,
        features: ['Premium Sound', 'Ambient Lighting', 'Massage Seats'],
      ),
      Car(
        id: '4',
        name: 'Toyota Camry',
        brand: 'Toyota',
        model: 'Camry',
        year: 2023,
        pricePerDay: 80,
        imageUrl:
            'https://images.unsplash.com/photo-1621007947382-bb3c3994e3fb',
        category: 'Sedan',
        seats: 5,
        transmission: 'Automatic',
        fuelType: 'Hybrid',
        rating: 4.6,
        reviewCount: 156,
        features: ['Hybrid Engine', 'Apple CarPlay', 'Backup Camera'],
      ),
    ];
    notifyListeners();
  }

  Car? getCarById(String id) {
    try {
      return _cars.firstWhere((car) => car.id == id);
    } catch (e) {
      return null;
    }
  }

  void addCar(Car car) {
    _cars.add(car);
    notifyListeners();
  }

  void updateCar(String id, Car updatedCar) {
    final index = _cars.indexWhere((car) => car.id == id);
    if (index != -1) {
      _cars[index] = updatedCar;
      notifyListeners();
    }
  }

  void deleteCar(String id) {
    _cars.removeWhere((car) => car.id == id);
    notifyListeners();
  }
}
