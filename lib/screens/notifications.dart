import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String message;
  final String fullMessage;
  final String timeAgo;
  final Color backgroundColor;
  bool isRead;
  bool isExpanded;

  NotificationItem({
    required this.title,
    required this.message,
    required this.fullMessage,
    required this.timeAgo,
    required this.backgroundColor,
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
  List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Service Reminder',
      message: 'Your car is due for brake service in 3 days',
      fullMessage: 'Your car is due for brake service in 3 days. Please schedule an appointment with your preferred service center to ensure optimal vehicle performance and safety.',
      timeAgo: '2 hours ago',
      backgroundColor: const Color(0xFFE3F2FD),
    ),
    NotificationItem(
      title: 'New Post',
      message: 'John Doe posted a new photo of his BMW M3',
      fullMessage: 'John Doe posted a new photo of his BMW M3. Check out the latest modifications and join the conversation with other car enthusiasts in the comments.',
      timeAgo: '4 hours ago',
      backgroundColor: const Color(0xFFE8F5E8),
    ),
    NotificationItem(
      title: 'Engine Service',
      message: 'Engine service completed successfully',
      fullMessage: 'Engine service completed successfully at AutoCare Center. Your vehicle has been thoroughly inspected and all maintenance items have been addressed. Receipt and service details are available in your account.',
      timeAgo: '1 day ago',
      backgroundColor: const Color(0xFFFFF3E0),
    ),
    NotificationItem(
      title: 'New Follower',
      message: 'Sarah Wilson started following you',
      fullMessage: 'Sarah Wilson started following you on GearHead. Check out her profile to see her amazing car collection and connect with fellow automotive enthusiasts.',
      timeAgo: '2 days ago',
      backgroundColor: const Color(0xFFF3E5F5),
    ),
    NotificationItem(
      title: 'Tire Pressure Alert',
      message: 'Low tire pressure detected in your vehicle',
      fullMessage: 'Low tire pressure detected in your vehicle. Front left tire pressure is below recommended levels. Please check and inflate to proper PSI for safe driving.',
      timeAgo: '3 days ago',
      backgroundColor: const Color(0xFFFFEBEE),
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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(
            color: isDark ? Colors.white : Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
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
            onTap: () => _toggleNotification(index),
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? Colors.white : Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notification.isExpanded 
                                    ? notification.fullMessage 
                                    : notification.message,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark ? Colors.white70 : Colors.grey[700],
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notification.timeAgo,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark ? Colors.white54 : Colors.grey[500],
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
    );
  }
}