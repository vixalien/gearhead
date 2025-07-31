import 'package:flutter/material.dart';
import '../components/bottom_navigation.dart';
import '../components/navigation_handler.dart';

class NotificationItem {
  final String title;
  final String message;
  final String fullMessage;
  final String timeAgo;
  final Color backgroundColor;
  final IconData icon;
  final String type; // 'spot', 'event', 'quest', 'profile'
  final String targetId;
  bool isRead;
  bool isExpanded;

  NotificationItem({
    required this.title,
    required this.message,
    required this.fullMessage,
    required this.timeAgo,
    required this.backgroundColor,
    required this.icon,
    required this.type,
    required this.targetId,
    this.isRead = false,
    this.isExpanded = false,
  });
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int _selectedIndex = 3; // Notifications tab is selected

  List<NotificationItem> notifications = [
    NotificationItem(
      title: 'New Car Spot',
      message: 'John Doe spotted a Toyota Mark II near you',
      fullMessage:
          'John Doe spotted a beautiful Toyota Mark II near you in Kimisagara. Check out the modifications and see if you know the owner!',
      timeAgo: '2 hours ago',
      backgroundColor: const Color(0xFFE3F2FD),
      icon: Icons.location_on,
      type: 'spot',
      targetId: 'spot_123',
    ),
    NotificationItem(
      title: 'Quest Response',
      message: 'Someone responded to your turbo installation quest',
      fullMessage:
          'Mike from AutoTech Garage responded to your turbo installation quest. He has 5+ years experience and offers competitive pricing. Check his profile for reviews.',
      timeAgo: '4 hours ago',
      backgroundColor: const Color(0xFFE8F5E8),
      icon: Icons.help,
      type: 'quest',
      targetId: 'quest_456',
    ),
    NotificationItem(
      title: 'Event Reminder',
      message: 'Toyota Meet Kigali is tomorrow at 10 AM',
      fullMessage:
          'Don\'t forget about the Toyota Meet Kigali event tomorrow at Amahoro Stadium. Bring your ride and meet fellow Toyota enthusiasts!',
      timeAgo: '8 hours ago',
      backgroundColor: const Color(0xFFFFF3E0),
      icon: Icons.event,
      type: 'event',
      targetId: 'event_789',
    ),
    NotificationItem(
      title: 'New Follower',
      message: 'Sarah Wilson started following you',
      fullMessage:
          'Sarah Wilson started following you on GearHead. Check out her profile to see her amazing car collection and connect with fellow automotive enthusiasts.',
      timeAgo: '1 day ago',
      backgroundColor: const Color(0xFFF3E5F5),
      icon: Icons.person_add,
      type: 'profile',
      targetId: 'user_sarah',
    ),
    NotificationItem(
      title: 'Event Invitation',
      message: 'You\'re invited to the Drift Competition',
      fullMessage:
          'Rwanda Drift Club invited you to their upcoming drift competition at Nyamirambo Stadium. Registration closes in 3 days!',
      timeAgo: '2 days ago',
      backgroundColor: const Color(0xFFFFEBEE),
      icon: Icons.event_available,
      type: 'event',
      targetId: 'event_drift',
    ),
    NotificationItem(
      title: 'Quest Completed',
      message: 'Your brake repair quest has been completed',
      fullMessage:
          'AutoFix Garage has successfully completed your brake repair quest. Please leave a review and rating for the service provided.',
      timeAgo: '3 days ago',
      backgroundColor: const Color(0xFFE8F5E8),
      icon: Icons.check_circle,
      type: 'quest',
      targetId: 'quest_brake',
    ),
  ];

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification.isRead = true;
      }
    });
  }

  void _toggleNotification(int index) {
    setState(() {
      notifications[index].isExpanded = !notifications[index].isExpanded;
      notifications[index].isRead = true;
    });
  }

  void _navigateToItem(NotificationItem notification) {
    switch (notification.type) {
      case 'spot':
        // Navigate to specific car spot
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigate to spot ${notification.targetId}')),
        );
        break;
      case 'event':
        // Navigate to specific event
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigate to event ${notification.targetId}')),
        );
        break;
      case 'quest':
        // Navigate to specific quest
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Navigate to quest ${notification.targetId}')),
        );
        break;
      case 'profile':
        // Navigate to user profile
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Navigate to profile ${notification.targetId}'),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'Notifications',
          style: TextStyle(
            color: Theme.of(context).appBarTheme.foregroundColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _markAllAsRead,
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: Color(0xFF4A90E2),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];

          return GestureDetector(
            onTap: () {
              _toggleNotification(index);
              _navigateToItem(notification);
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Notification icon
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: notification.backgroundColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            notification.icon,
                            size: 20,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.color,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification.isExpanded
                                    ? notification.fullMessage
                                    : notification.message,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.color
                                      ?.withOpacity(0.8),
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notification.timeAgo,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color
                                      ?.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: notification.isRead
                                ? Colors.transparent
                                : const Color(0xFF4A90E2),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
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
