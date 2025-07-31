import 'package:flutter/material.dart';
import 'car_spot_details.dart';
import 'event_details.dart';
import 'quest_details.dart';

class UserProfileScreen extends StatefulWidget {
  final String userId;
  final String username;
  final String userAvatar;

  const UserProfileScreen({
    super.key,
    required this.userId,
    required this.username,
    required this.userAvatar,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample user data with details
  final List<Map<String, dynamic>> userSpots = [
    {
      'id': 'spot_1',
      'image':
          'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'carMake': 'Toyota',
      'carModel': 'Mark II',
      'carYear': '1995',
      'description':
          'Beautiful JZX90 spotted downtown! Love the stance and wheels setup.',
      'location': 'KN 4 Avenue, Kigali',
      'timeAgo': '2 hours ago',
      'likes': 24,
      'comments': 8,
      'isLiked': false,
    },
    {
      'id': 'spot_2',
      'image':
          'https://images.unsplash.com/photo-1583121274602-3e2820c69888?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'carMake': 'Subaru',
      'carModel': 'WRX STI',
      'carYear': '2018',
      'description':
          'Rally-bred beast spotted at the mall. That Subaru rumble! 🔥',
      'location': 'Kigali City Tower',
      'timeAgo': '4 hours ago',
      'likes': 31,
      'comments': 12,
      'isLiked': true,
    },
    {
      'id': 'spot_3',
      'image':
          'https://images.unsplash.com/photo-1494905998402-395d579af36f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'carMake': 'BMW',
      'carModel': 'M3',
      'carYear': '2020',
      'description':
          'M3 Competition in perfect condition. The sound when it started up! 😍',
      'location': 'Remera, Kigali',
      'timeAgo': '1 day ago',
      'likes': 45,
      'comments': 18,
      'isLiked': false,
    },
  ];

  final List<Map<String, dynamic>> userEvents = [
    {
      'id': 'event_1',
      'title': 'Toyota Meet Kigali',
      'description':
          'Monthly Toyota owners meetup. Bring your ride and meet fellow Toyota enthusiasts! Food, music, and great vibes.',
      'organizer': 'Current User',
      'organizerAvatar':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'eventImage':
          'https://images.unsplash.com/photo-1542362567-b07e54358753?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'eventType': 'Car Meet',
      'location': 'Amahoro Stadium Parking',
      'eventDate': 'Jan 20, 2025',
      'startTime': '10:00 AM',
      'endTime': '4:00 PM',
      'attendees': 45,
      'maxAttendees': 100,
      'entryFee': 5000,
      'isAttending': true,
    },
    {
      'id': 'event_2',
      'title': 'Sunday Cruise to Nyanza',
      'description':
          'Scenic drive to Nyanza with stops at beautiful viewpoints. Perfect for photography and bonding with fellow car lovers.',
      'organizer': 'Current User',
      'organizerAvatar':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'eventImage':
          'https://images.unsplash.com/photo-1605559424843-9e4c228bf1c2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'eventType': 'Road Trip',
      'location': 'Starting from Kimisagara',
      'eventDate': 'Jan 28, 2025',
      'startTime': '7:00 AM',
      'endTime': '5:00 PM',
      'attendees': 15,
      'maxAttendees': 25,
      'entryFee': 10000,
      'isAttending': false,
    },
  ];

  final List<Map<String, dynamic>> userQuests = [
    {
      'id': 'quest_1',
      'title': 'Need help with turbo installation',
      'description':
          'Looking for an experienced mechanic to help install a turbo kit on my Toyota Mark II. Have all the parts, just need skilled hands.',
      'author': 'Current User',
      'authorAvatar':
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      'questType': 'Help Request',
      'skillRequired': 'Turbo Installation',
      'location': 'Kimisagara, Kigali',
      'payment': 50000,
      'urgency': 'Medium',
      'timeAgo': '2 hours ago',
      'responses': 3,
      'status': 'Open',
      'carMake': 'Toyota',
      'carModel': 'Mark II',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.username,
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_horiz,
              color: Theme.of(context).appBarTheme.foregroundColor,
            ),
            onPressed: () {
              // Show more options
            },
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  // Profile header section
                  Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        // Profile picture and info
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(widget.userAvatar),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildStatColumn(
                                    userSpots.length.toString(),
                                    'spots',
                                  ),
                                  _buildStatColumn(
                                    userEvents.length.toString(),
                                    'events',
                                  ),
                                  _buildStatColumn(
                                    userQuests.length.toString(),
                                    'quests',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Username and bio
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.username,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Car enthusiast from Kigali 🚗',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? Colors.grey[400]
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),

                  // Tab bar
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                    child: TabBar(
                      controller: _tabController,
                      tabs: const [
                        Tab(icon: Icon(Icons.location_on_outlined)),
                        Tab(icon: Icon(Icons.event_outlined)),
                        Tab(icon: Icon(Icons.help_outline)),
                      ],
                      labelColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor:
                          Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Car Spots Tab
            _buildGridView(userSpots, 'No car spots'),
            // Events Tab
            _buildGridView(userEvents, 'No events'),
            // Quests Tab
            _buildGridView(userQuests, 'No quests'),
          ],
        ),
      ),
    );
  }

  void _navigateToItem(int index) {
    final currentTab = _tabController.index;
    switch (currentTab) {
      case 0: // Car Spots
        if (index < userSpots.length) {
          final spot = userSpots[index];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CarSpotDetailsScreen(
                spotId: spot['id']!,
                username: widget.username,
                userAvatar: widget.userAvatar,
                carImage: spot['image']!,
                carMake: spot['carMake']!,
                carModel: spot['carModel']!,
                carYear: spot['carYear']!,
                description: spot['description']!,
                location: spot['location']!,
                timeAgo: spot['timeAgo']!,
                initialLikes: spot['likes']!,
                comments: spot['comments']!,
                initialIsLiked: spot['isLiked']!,
              ),
            ),
          );
        }
        break;
      case 1: // Events
        if (index < userEvents.length) {
          final event = userEvents[index];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EventDetailsScreen(
                eventId: event['id']!,
                title: event['title']!,
                description: event['description']!,
                organizer: event['organizer']!,
                organizerAvatar: event['organizerAvatar']!,
                eventImage: event['eventImage']!,
                eventType: event['eventType']!,
                location: event['location']!,
                eventDate: event['eventDate']!,
                startTime: event['startTime']!,
                endTime: event['endTime']!,
                attendees: event['attendees']!,
                maxAttendees: event['maxAttendees']!,
                entryFee: event['entryFee']!,
                isAttending: event['isAttending']!,
              ),
            ),
          );
        }
        break;
      case 2: // Quests
        if (index < userQuests.length) {
          final quest = userQuests[index];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => QuestDetailsScreen(
                questId: quest['id']!,
                title: quest['title']!,
                description: quest['description']!,
                author: quest['author']!,
                authorAvatar: quest['authorAvatar']!,
                questType: quest['questType']!,
                skillRequired: quest['skillRequired']!,
                location: quest['location']!,
                payment: quest['payment']!,
                urgency: quest['urgency']!,
                timeAgo: quest['timeAgo']!,
                responses: quest['responses']!,
                status: quest['status']!,
                carMake: quest['carMake']!,
                carModel: quest['carModel']!,
              ),
            ),
          );
        }
        break;
    }
  }

  Widget _buildGridView(List<Map<String, dynamic>> items, String emptyMessage) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.photo_library_outlined,
              size: 64,
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[600]
                  : Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              emptyMessage,
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.grey[400]
                    : Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
        childAspectRatio: 1.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigate to specific item based on tab
            _navigateToItem(index);
          },
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_getImageForTab(items[index])),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  String _getImageForTab(Map<String, dynamic> item) {
    final currentTab = _tabController.index;
    switch (currentTab) {
      case 0: // Car Spots
        return item['image'] ?? '';
      case 1: // Events
        return item['eventImage'] ?? '';
      case 2: // Quests
        return item['image'] ??
            'https://images.unsplash.com/photo-1571068316344-75bc76f77890?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80';
      default:
        return '';
    }
  }

  Widget _buildStatColumn(String number, String label) {
    return Column(
      children: [
        Text(
          number,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[400]
                : Colors.grey,
          ),
        ),
      ],
    );
  }
}
