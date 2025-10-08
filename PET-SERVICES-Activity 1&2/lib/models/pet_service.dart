// Step 1: Models folder organization
class PetService {
  final String id;
  final String name;
  final String description;
  final String detailedDescription;
  final String icon;
  final double price;
  final String duration;
  final List<String> features;

  const PetService({
    required this.id,
    required this.name,
    required this.description,
    required this.detailedDescription,
    required this.icon,
    required this.price,
    required this.duration,
    required this.features,
  });
}

// Service data
class PetServiceData {
  static const List<PetService> services = [
    PetService(
      id: '1',
      name: 'Dog Walking',
      description:
          'Daily or scheduled walks to keep dogs active, healthy, and happy.',
      detailedDescription:
          'Our professional dog walking service ensures your furry friend gets the exercise and attention they need. We provide daily or scheduled walks tailored to your dog\'s energy level and needs. Each walk includes playtime, basic training reinforcement, and lots of love and attention.',
      icon: '🐕',
      price: 150.00,
      duration: '30-60 minutes',
      features: [
        'Customized walk routes',
        'GPS tracking updates',
        'Photo updates during walks',
        'Basic training reinforcement',
        'Weather-appropriate gear provided'
      ],
    ),
    PetService(
      id: '2',
      name: 'Pet Grooming',
      description:
          'Bathing, haircut, nail trimming, and ear cleaning for cats and dogs.',
      detailedDescription:
          'Complete grooming services to keep your pet looking and feeling their best. Our experienced groomers provide gentle, stress-free grooming in a comfortable environment. We use high-quality, pet-safe products and techniques.',
      icon: '✂️',
      price: 600.00,
      duration: '2-3 hours',
      features: [
        'Full bath with premium shampoo',
        'Professional haircut and styling',
        'Nail trimming and filing',
        'Ear cleaning and inspection',
        'Teeth brushing (optional)'
      ],
    ),
    PetService(
      id: '3',
      name: 'Pet Sitting',
      description:
          'Taking care of pets at home while the owner is away (feeding, playtime, monitoring).',
      detailedDescription:
          'Reliable in-home pet sitting services that allow your pets to stay comfortable in their familiar environment. Our sitters provide feeding, playtime, companionship, and monitoring to ensure your pet\'s wellbeing while you\'re away.',
      icon: '🏠',
      price: 450.00,
      duration: 'Per visit/day',
      features: [
        'In-home care in familiar environment',
        'Feeding and fresh water',
        'Playtime and exercise',
        'Medication administration',
        'Daily photo and text updates'
      ],
    ),
    PetService(
      id: '4',
      name: 'Veterinary Home Visit',
      description:
          'A vet comes to your house for checkups, vaccinations, or minor treatments.',
      detailedDescription:
          'Convenient veterinary care brought directly to your home. Our licensed veterinarians provide comprehensive health checkups, vaccinations, and minor treatments in the comfort of your pet\'s familiar environment, reducing stress for both you and your pet.',
      icon: '🩺',
      price: 400.00,
      duration: '45-90 minutes',
      features: [
        'Licensed veterinarian visit',
        'Complete health examination',
        'Vaccinations and boosters',
        'Minor treatments and procedures',
        'Health records and recommendations'
      ],
    ),
    PetService(
      id: '5',
      name: 'Pet Training',
      description:
          'Basic obedience training, potty training, and behavior correction.',
      detailedDescription:
          'Professional pet training services to help your pet become a well-behaved family member. Our certified trainers use positive reinforcement techniques to teach basic obedience, address behavioral issues, and strengthen the bond between you and your pet.',
      icon: '🎓',
      price: 700.00,
      duration: '1 hour sessions',
      features: [
        'Basic obedience commands',
        'Potty training assistance',
        'Behavior correction techniques',
        'Positive reinforcement methods',
        'Owner training and guidance'
      ],
    ),
    PetService(
      id: '6',
      name: 'Pet Boarding',
      description:
          'Temporary accommodation for pets when owners are traveling.',
      detailedDescription:
          'Safe and comfortable boarding facilities for when you need to travel. Our boarding service provides a home-away-from-home experience with spacious accommodations, regular exercise, socialization, and 24/7 care from our trained staff.',
      icon: '🏨',
      price: 800.00,
      duration: 'Per night',
      features: [
        'Spacious, clean accommodations',
        'Regular exercise and playtime',
        'Socialization with other pets',
        '24/7 supervision and care',
        'Special dietary accommodations'
      ],
    ),
  ];
}
