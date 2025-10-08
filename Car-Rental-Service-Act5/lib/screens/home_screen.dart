import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/car_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/category_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _categories = [
    'All',
    'Sedan',
    'SUV',
    'Luxury',
    'Electric'
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CarProvider>(context, listen: false).loadCars();
    });
  }

  @override
  Widget build(BuildContext context) {
    final carProvider = Provider.of<CarProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Car Rental Services'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () => Navigator.pushNamed(context, '/cart'),
              ),
              if (cartProvider.itemCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cartProvider.itemCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'drawer':
                  Navigator.pushNamed(context, '/drawer-demo');
                  break;
                case 'tabs':
                  Navigator.pushNamed(context, '/tabs-demo');
                  break;
                case 'video':
                  Navigator.pushNamed(context, '/video-demo');
                  break;
                case 'audio':
                  Navigator.pushNamed(context, '/audio-demo');
                  break;
                case 'register':
                  Navigator.pushNamed(context, '/registration');
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'drawer', child: Text('Drawer Demo')),
              const PopupMenuItem(value: 'tabs', child: Text('Tabs Demo')),
              const PopupMenuItem(value: 'video', child: Text('Video Demo')),
              const PopupMenuItem(value: 'audio', child: Text('Audio Demo')),
              const PopupMenuItem(value: 'register', child: Text('Register')),
            ],
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Colors.blue[300]!],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, size: 40, color: Color(0xFF1976D2)),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    authProvider.currentUser?.name ?? 'Guest',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    authProvider.currentUser?.email ?? '',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('My Cart'),
              trailing: cartProvider.itemCount > 0
                  ? CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${cartProvider.itemCount}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    )
                  : null,
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.video_library),
              title: const Text('Car Videos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/video-demo');
              },
            ),
            ListTile(
              leading: const Icon(Icons.audiotrack),
              title: const Text('Car Sounds'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/audio-demo');
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/image-demo');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.app_registration),
              title: const Text('Register'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/registration');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Logout'),
                    content: const Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          authProvider.logout();
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/',
                            (route) => false,
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search cars...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          carProvider.setSearchQuery('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => carProvider.setSearchQuery(value),
            ),
          ),

          // Category Chips
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                return CategoryChip(
                  label: _categories[index],
                  isSelected:
                      carProvider.selectedCategory == _categories[index],
                  onSelected: () => carProvider.setCategory(_categories[index]),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Price Range Slider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Price Range: \$${carProvider.minPrice.toInt()} - \$${carProvider.maxPrice.toInt()}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                RangeSlider(
                  values:
                      RangeValues(carProvider.minPrice, carProvider.maxPrice),
                  min: 0,
                  max: 500,
                  divisions: 50,
                  labels: RangeLabels(
                    '\$${carProvider.minPrice.toInt()}',
                    '\$${carProvider.maxPrice.toInt()}',
                  ),
                  onChanged: (values) {
                    carProvider.setPriceRange(values.start, values.end);
                  },
                ),
              ],
            ),
          ),

          // Car Grid
          Expanded(
            child: carProvider.cars.isEmpty
                ? const Center(
                    child: Text('No cars found'),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: carProvider.cars.length,
                    itemBuilder: (context, index) {
                      return ProductCard(car: carProvider.cars[index]);
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/car-form'),
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
