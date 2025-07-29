import 'package:flutter/material.dart';
import '../components/bottom_navigation.dart';
import '../components/navigation_handler.dart';
import '../components/comments_bottom_sheet.dart';
import 'user_profile.dart';
import 'car_spot_details.dart';

class CarSpotsScreen extends StatefulWidget {
  const CarSpotsScreen({super.key});

  @override
  State<CarSpotsScreen> createState() => _CarSpotsScreenState();
}

class _CarSpotsScreenState extends State<CarSpotsScreen> {
  int _selectedIndex = 0; // Spots tab is selected

  // Sample car spots data
  final List<CarSpot> _carSpots = [
    CarSpot(
      id: '1',
      username: 'John Doe',
      userAvatar:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      carImage:
          'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      carMake: 'Toyota',
      carModel: 'Mark II',
      carYear: '1995',
      description:
          'Beautiful JZX90 spotted downtown! Love the stance and wheels setup.',
      location: 'KN 4 Avenue, Kigali',
      timeAgo: '2 hours ago',
      likes: 24,
      comments: 8,
      isLiked: false,
    ),
    CarSpot(
      id: '2',
      username: 'Sarah Wilson',
      userAvatar:
          'https://images.unsplash.com/photo-1494790108755-2616b72b6698?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      carImage:
          'https://images.unsplash.com/photo-1583121274602-3e2820c69888?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      carMake: 'Subaru',
      carModel: 'WRX STI',
      carYear: '2018',
      description:
          'Rally-bred beast spotted at the mall. That Subaru rumble! 🔥',
      location: 'Kigali City Tower',
      timeAgo: '4 hours ago',
      likes: 31,
      comments: 12,
      isLiked: true,
    ),
    CarSpot(
      id: '3',
      username: 'Mike Johnson',
      userAvatar:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      carImage:
          'https://images.unsplash.com/photo-1494905998402-395d579af36f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      carMake: 'BMW',
      carModel: 'M3',
      carYear: '2020',
      description:
          'M3 Competition in perfect condition. The sound when it started up! 😍',
      location: 'Remera, Kigali',
      timeAgo: '1 day ago',
      likes: 45,
      comments: 18,
      isLiked: false,
    ),
    CarSpot(
      id: '4',
      username: 'Emma Davis',
      userAvatar:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      carImage:
          'https://images.unsplash.com/photo-1542362567-b07e54358753?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      carMake: 'Mercedes',
      carModel: 'AMG GT',
      carYear: '2021',
      description: 'Rare AMG GT spotted! The exhaust note was incredible.',
      location: 'Nyarutarama, Kigali',
      timeAgo: '2 days ago',
      likes: 67,
      comments: 23,
      isLiked: true,
    ),
  ];

  void _addNewSpot() {
    Navigator.pushNamed(context, '/add_spot');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Car Spots',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black, size: 28),
            onPressed: _addNewSpot,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate refresh
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
          itemCount: _carSpots.length,
          itemBuilder: (context, index) {
            return CarSpotWidget(
              carSpot: _carSpots[index],
              onLikeToggle: (spotId) {
                setState(() {
                  final spot = _carSpots.firstWhere((s) => s.id == spotId);
                  spot.isLiked = !spot.isLiked;
                  if (spot.isLiked) {
                    spot.likes++;
                  } else {
                    spot.likes--;
                  }
                });
              },
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
          NavigationHandler.handleNavigation(context, index);
        },
      ),
    );
  }
}

class CarSpot {
  final String id;
  final String username;
  final String userAvatar;
  final String carImage;
  final String carMake;
  final String carModel;
  final String carYear;
  final String description;
  final String location;
  final String timeAgo;
  int likes;
  final int comments;
  bool isLiked;

  CarSpot({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.carImage,
    required this.carMake,
    required this.carModel,
    required this.carYear,
    required this.description,
    required this.location,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.isLiked,
  });
}

class CarSpotWidget extends StatelessWidget {
  final CarSpot carSpot;
  final Function(String) onLikeToggle;

  const CarSpotWidget({
    super.key,
    required this.carSpot,
    required this.onLikeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CarSpotDetailsScreen(
              spotId: carSpot.id,
              username: carSpot.username,
              userAvatar: carSpot.userAvatar,
              carImage: carSpot.carImage,
              carMake: carSpot.carMake,
              carModel: carSpot.carModel,
              carYear: carSpot.carYear,
              description: carSpot.description,
              location: carSpot.location,
              timeAgo: carSpot.timeAgo,
              initialLikes: carSpot.likes,
              comments: carSpot.comments,
              initialIsLiked: carSpot.isLiked,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with user info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserProfileScreen(
                            userId: carSpot.id,
                            username: carSpot.username,
                            userAvatar: carSpot.userAvatar,
                          ),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(carSpot.userAvatar),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserProfileScreen(
                                  userId: carSpot.id,
                                  username: carSpot.username,
                                  userAvatar: carSpot.userAvatar,
                                ),
                              ),
                            );
                          },
                          child: Text(
                            carSpot.username,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              carSpot.location,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '• ${carSpot.timeAgo}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_horiz, color: Colors.black),
                    onPressed: () {
                      // Show menu options
                    },
                  ),
                ],
              ),
            ),

            // Car details banner
            Container(
              width: double.infinity,
              color: Colors.blue.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.directions_car,
                    color: Colors.blue.shade700,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${carSpot.carYear} ${carSpot.carMake} ${carSpot.carModel}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ],
              ),
            ),

            // Car image
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(carSpot.carImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Action buttons and stats
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Action buttons
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => onLikeToggle(carSpot.id),
                        child: Row(
                          children: [
                            Icon(
                              carSpot.isLiked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: carSpot.isLiked
                                  ? Colors.red
                                  : Colors.black,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              carSpot.likes.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          showCommentsBottomSheet(
                            context,
                            carSpot.id,
                            carSpot.comments,
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.black,
                              size: 24,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              carSpot.comments.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Description
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        TextSpan(
                          text: carSpot.username,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: ' ${carSpot.description}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
