import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AboutHeaderSection(),
          SizedBox(height: 32),
          AboutContentSection(),
          SizedBox(height: 32),
          ContactSection(),
          SizedBox(height: 32),
          TestimonialsSection(),
        ],
      ),
    );
  }
}

class AboutHeaderSection extends StatelessWidget {
  const AboutHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Nard\'s Pet Services',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.pets,
                  size: 64,
                  color: Colors.white,
                ),
                SizedBox(height: 16),
                Text(
                  'Professional Pet Care Since 2020',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AboutContentSection extends StatelessWidget {
  const AboutContentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Story',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 16),
        Text(
          'Nard\'s Pet Services was founded with a simple mission: to provide the highest quality pet care services while treating every pet as if they were our own family members.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
              ),
        ),
        SizedBox(height: 16),
        Text(
          'Our team of certified professionals brings years of experience in veterinary care, animal behavior, and pet grooming. We understand that your pets are more than just animals – they\'re beloved family members who deserve the best care possible.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.6,
              ),
        ),
        SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(context, '500+', 'Happy Pets'),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(context, '4.9★', 'Rating'),
            ),
            SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(context, '3+', 'Years'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String number, String label) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            number,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Us',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 16),
        _buildContactItem(
          context,
          Icons.phone,
          'Phone',
          '09816135823',
        ),
        SizedBox(height: 12),
        _buildContactItem(
          context,
          Icons.email,
          'Email',
          'bsondia28@gmail.com',
        ),
        SizedBox(height: 12),
        _buildContactItem(
          context,
          Icons.location_on,
          'Address',
          'E. B. Magalona, Negros Occidental',
        ),
        SizedBox(height: 24),
        CustomButton(
          text: 'Get In Touch',
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Contact Us'),
                content: Text(
                    'Thank you for your interest! Please call us at 09816135823 or email us at bsondia28@gmail.com'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('OK'),
                  ),
                ],
              ),
            );
          },
          icon: Icons.contact_mail,
        ),
      ],
    );
  }

  Widget _buildContactItem(
      BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Text(
              value,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'What Our Customers Say',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 16),
        _buildTestimonialCard(
          context,
          'Vince Villanueva',
          'Dog Walking Service',
          'Nard\'s team has been amazing with my Golden Retriever, Max. They\'re reliable, caring, and Max is always excited to see them!',
          5,
        ),
        SizedBox(height: 16),
        _buildTestimonialCard(
          context,
          'Alvin Cango',
          'Pet Grooming',
          'Professional grooming service that made my cat look and feel amazing. The staff is gentle and experienced.',
          5,
        ),
      ],
    );
  }

  Widget _buildTestimonialCard(BuildContext context, String name,
      String service, String review, int rating) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Text(
                    name[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                      ),
                      Text(
                        service,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: List.generate(
                    rating,
                    (index) => Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              review,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.4,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
