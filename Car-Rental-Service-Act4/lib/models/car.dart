class Car {
  final String id;
  final String name;
  final String brand;
  final String type;
  final double pricePerDay;
  final int seats;
  final String transmission;
  final String fuelType;
  final double rating;
  final int reviews;
  final String imageUrl;
  final List<String> features;
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
    required this.rating,
    required this.reviews,
    required this.imageUrl,
    required this.features,
    this.available = true,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      type: json['type'],
      pricePerDay: json['pricePerDay'].toDouble(),
      seats: json['seats'],
      transmission: json['transmission'],
      fuelType: json['fuelType'],
      rating: json['rating'].toDouble(),
      reviews: json['reviews'],
      imageUrl: json['imageUrl'],
      features: List<String>.from(json['features']),
      available: json['available'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'type': type,
      'pricePerDay': pricePerDay,
      'seats': seats,
      'transmission': transmission,
      'fuelType': fuelType,
      'rating': rating,
      'reviews': reviews,
      'imageUrl': imageUrl,
      'features': features,
      'available': available,
    };
  }
}
