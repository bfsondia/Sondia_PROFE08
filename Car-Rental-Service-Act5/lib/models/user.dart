class User {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? licenseNumber;
  final DateTime? licenseExpiry;
  final String? profileImageUrl;
  final List<String> rentalHistory;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.licenseNumber,
    this.licenseExpiry,
    this.profileImageUrl,
    this.rentalHistory = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      licenseNumber: json['licenseNumber'],
      licenseExpiry: json['licenseExpiry'] != null
          ? DateTime.parse(json['licenseExpiry'])
          : null,
      profileImageUrl: json['profileImageUrl'],
      rentalHistory: List<String>.from(json['rentalHistory'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'licenseNumber': licenseNumber,
      'licenseExpiry': licenseExpiry?.toIso8601String(),
      'profileImageUrl': profileImageUrl,
      'rentalHistory': rentalHistory,
    };
  }
}
