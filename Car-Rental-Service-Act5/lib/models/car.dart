class Car {
  final String id;
  final String name;
  final String brand;
  final String model;
  final int year;
  final double pricePerDay;
  final String imageUrl;
  final String category;
  final int seats;
  final String transmission;
  final String fuelType;
  final double rating;
  final int reviewCount;
  final List<String> features;
  final bool available;

  Car({
    required this.id,
    required this.name,
    required this.brand,
    required this.model,
    required this.year,
    required this.pricePerDay,
    required this.imageUrl,
    required this.category,
    required this.seats,
    required this.transmission,
    required this.fuelType,
    required this.rating,
    required this.reviewCount,
    required this.features,
    this.available = true,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      model: json['model'],
      year: json['year'],
      pricePerDay: json['pricePerDay'].toDouble(),
      imageUrl: json['imageUrl'],
      category: json['category'],
      seats: json['seats'],
      transmission: json['transmission'],
      fuelType: json['fuelType'],
      rating: json['rating'].toDouble(),
      reviewCount: json['reviewCount'],
      features: List<String>.from(json['features']),
      available: json['available'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'model': model,
      'year': year,
      'pricePerDay': pricePerDay,
      'imageUrl': imageUrl,
      'category': category,
      'seats': seats,
      'transmission': transmission,
      'fuelType': fuelType,
      'rating': rating,
      'reviewCount': reviewCount,
      'features': features,
      'available': available,
    };
  }
}
