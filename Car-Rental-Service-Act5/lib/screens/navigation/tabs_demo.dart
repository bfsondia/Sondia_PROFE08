import 'package:flutter/material.dart';

class TabsDemo extends StatelessWidget {
  const TabsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tabs Demo'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car), text: 'Cars'),
              Tab(icon: Icon(Icons.favorite), text: 'Favorites'),
              Tab(icon: Icon(Icons.history), text: 'History'),
              Tab(icon: Icon(Icons.person), text: 'Profile'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildCarsTab(),
            _buildFavoritesTab(),
            _buildHistoryTab(),
            _buildProfileTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarsTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.directions_car, size: 80, color: Colors.blue[300]),
          const SizedBox(height: 20),
          const Text(
            'Browse Cars',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('Explore our wide range of rental cars'),
        ],
      ),
    );
  }

  Widget _buildFavoritesTab() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite, size: 80, color: Colors.red[300]),
          const SizedBox(height: 20),
          const Text(
            'Your Favorites',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text('Save your favorite cars here'),
        ],
      ),
    );
  }

  Widget _buildHistoryTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              child: Icon(Icons.directions_car, color: Colors.blue[700]),
            ),
            title: Text('Rental #${index + 1}'),
            subtitle: Text(
                'Completed on ${DateTime.now().subtract(Duration(days: index * 7)).toString().split(' ')[0]}'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      },
    );
  }

  Widget _buildProfileTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 60, color: Colors.white),
              ),
              SizedBox(height: 16),
              Text(
                'John Doe',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text('john@example.com'),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const ListTile(
          leading: Icon(Icons.email),
          title: Text('Email'),
          subtitle: Text('john@example.com'),
        ),
        const ListTile(
          leading: Icon(Icons.phone),
          title: Text('Phone'),
          subtitle: Text('+1 234 567 8900'),
        ),
        const ListTile(
          leading: Icon(Icons.badge),
          title: Text('License Number'),
          subtitle: Text('DL123456'),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Edit Profile'),
        ),
      ],
    );
  }
}
