import 'package:flutter/material.dart';
import '../components/bottom_navigation.dart';
import '../components/navigation_handler.dart';
import 'quest_details.dart';

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({super.key});

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  int _selectedIndex = 2; // Quests tab is selected

  // Sample quests data
  final List<Quest> _quests = [
    Quest(
      id: '1',
      title: 'Need help with turbo installation',
      description:
          'Looking for an experienced mechanic to help install a turbo kit on my Toyota Mark II. Have all the parts, just need skilled hands.',
      author: 'David Nshobozwa',
      authorAvatar:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      questType: 'Help Request',
      skillRequired: 'Turbo Installation',
      location: 'Kimisagara, Kigali',
      payment: 50000,
      urgency: 'Medium',
      timeAgo: '2 hours ago',
      responses: 3,
      status: 'Open',
      carMake: 'Toyota',
      carModel: 'Mark II',
    ),
    Quest(
      id: '2',
      title: 'Offering brake repair services',
      description:
          'Professional brake repair and maintenance services. 5+ years experience. Quality parts and warranty included.',
      author: 'AutoFix Garage',
      authorAvatar:
          'https://images.unsplash.com/photo-1494790108755-2616b72b6698?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      questType: 'Service Offer',
      skillRequired: 'Brake Repair',
      location: 'Nyamirambo, Kigali',
      payment: 25000,
      urgency: 'Low',
      timeAgo: '4 hours ago',
      responses: 8,
      status: 'Open',
      carMake: 'All Makes',
      carModel: 'All Models',
    ),
    Quest(
      id: '3',
      title: 'Electrical wiring issue - URGENT',
      description:
          'My car won\'t start and I suspect it\'s an electrical problem. Need someone who can diagnose and fix wiring issues.',
      author: 'Sarah Johnson',
      authorAvatar:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      questType: 'Help Request',
      skillRequired: 'Electrical Repair',
      location: 'Remera, Kigali',
      payment: 35000,
      urgency: 'High',
      timeAgo: '6 hours ago',
      responses: 12,
      status: 'In Progress',
      carMake: 'Honda',
      carModel: 'Civic',
    ),
    Quest(
      id: '4',
      title: 'Engine tuning and performance upgrade',
      description:
          'Looking for a tuning specialist to optimize my engine performance. Want to increase horsepower safely.',
      author: 'Mike Racing',
      authorAvatar:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      questType: 'Help Request',
      skillRequired: 'Engine Tuning',
      location: 'Kacyiru, Kigali',
      payment: 75000,
      urgency: 'Low',
      timeAgo: '1 day ago',
      responses: 5,
      status: 'Open',
      carMake: 'Subaru',
      carModel: 'WRX',
    ),
    Quest(
      id: '5',
      title: 'Mobile car wash service available',
      description:
          'Professional mobile car washing and detailing. We come to your location. Interior and exterior cleaning.',
      author: 'CleanRide Services',
      authorAvatar:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      questType: 'Service Offer',
      skillRequired: 'Car Detailing',
      location: 'All Kigali Areas',
      payment: 15000,
      urgency: 'Low',
      timeAgo: '2 days ago',
      responses: 15,
      status: 'Open',
      carMake: 'All Makes',
      carModel: 'All Models',
    ),
  ];

  void _addNewQuest() {
    Navigator.pushNamed(context, '/add_quest');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Quests',
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
            onPressed: _addNewQuest,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate refresh
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
          itemCount: _quests.length,
          itemBuilder: (context, index) {
            return QuestWidget(quest: _quests[index]);
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

class Quest {
  final String id;
  final String title;
  final String description;
  final String author;
  final String authorAvatar;
  final String questType; // 'Help Request' or 'Service Offer'
  final String skillRequired;
  final String location;
  final int payment;
  final String urgency; // 'Low', 'Medium', 'High'
  final String timeAgo;
  final int responses;
  final String status; // 'Open', 'In Progress', 'Completed'
  final String carMake;
  final String carModel;

  Quest({
    required this.id,
    required this.title,
    required this.description,
    required this.author,
    required this.authorAvatar,
    required this.questType,
    required this.skillRequired,
    required this.location,
    required this.payment,
    required this.urgency,
    required this.timeAgo,
    required this.responses,
    required this.status,
    required this.carMake,
    required this.carModel,
  });
}

class QuestWidget extends StatelessWidget {
  final Quest quest;

  const QuestWidget({super.key, required this.quest});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestDetailsScreen(
              questId: quest.id,
              title: quest.title,
              description: quest.description,
              author: quest.author,
              authorAvatar: quest.authorAvatar,
              questType: quest.questType,
              skillRequired: quest.skillRequired,
              location: quest.location,
              payment: quest.payment,
              urgency: quest.urgency,
              timeAgo: quest.timeAgo,
              responses: quest.responses,
              status: quest.status,
              carMake: quest.carMake,
              carModel: quest.carModel,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with user info and quest type
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(quest.authorAvatar),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              quest.author,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: quest.questType == 'Help Request'
                                    ? Colors.orange.shade100
                                    : Colors.green.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                quest.questType,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: quest.questType == 'Help Request'
                                      ? Colors.orange.shade700
                                      : Colors.green.shade700,
                                ),
                              ),
                            ),
                          ],
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
                              quest.location,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '• ${quest.timeAgo}',
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
                  // Status and urgency indicators
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(quest.status),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          quest.status,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (quest.urgency == 'High') ...[
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'URGENT',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Title
              Text(
                quest.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),

              // Description
              Text(
                quest.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 12),

              // Car info and skill required
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.directions_car,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${quest.carMake} ${quest.carModel}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        quest.skillRequired,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Payment and responses
              Row(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        size: 18,
                        color: Colors.green.shade600,
                      ),
                      Text(
                        '${quest.payment.toString()} RWF',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade600,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${quest.responses} responses',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle respond to quest
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            quest.questType == 'Help Request'
                                ? 'Offer help functionality coming soon!'
                                : 'Contact service functionality coming soon!',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: quest.questType == 'Help Request'
                          ? Colors.blue.shade600
                          : Colors.green.shade600,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    child: Text(
                      quest.questType == 'Help Request'
                          ? 'Offer Help'
                          : 'Contact',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Open':
        return Colors.green.shade600;
      case 'In Progress':
        return Colors.orange.shade600;
      case 'Completed':
        return Colors.grey.shade600;
      default:
        return Colors.blue.shade600;
    }
  }
}
