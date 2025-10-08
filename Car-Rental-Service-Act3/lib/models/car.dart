class Car {
  final String id;
  final String name;
  final String brand;
  final String type;
  final double pricePerDay;
  final int seats;
  final String transmission;
  final String fuelType;
  final String imageUrl;
  final double rating;
  final bool available;

  Car({
    required this.id,
    required this.name,
    required this.brand,
    required this.type,
    required this.pricePerDay,
    required this.seats,
    required this.transmission,
    required this.fuelType,
    required this.imageUrl,
    required this.rating,
    this.available = true,
  });

  static List<Car> getSampleCars() {
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
        imageUrl: '/placeholder.svg?height=200&width=300',
        rating: 4.8,
      ),
      Car(
        id: '2',
        name: 'Mustang',
        brand: 'Ford',
        type: 'Sports',
        pricePerDay: 150.0,
        seats: 4,
        transmission: 'Manual',
        fuelType: 'Petrol',
        imageUrl: '/placeholder.svg?height=200&width=300',
        rating: 4.7,
      ),
      Car(
        id: '3',
        name: 'X5',
        brand: 'BMW',
        type: 'SUV',
        pricePerDay: 180.0,
        seats: 7,
        transmission: 'Automatic',
        fuelType: 'Diesel',
        imageUrl: '/placeholder.svg?height=200&width=300',
        rating: 4.9,
      ),
    ];
  }
}
