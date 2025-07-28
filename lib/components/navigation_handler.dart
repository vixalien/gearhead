import 'package:flutter/material.dart';

class NavigationHandler {
  static void handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Navigate to home
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/homepage',
          (route) => false,
        );
        break;
      case 1:
        // Navigate to search
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Search functionality coming soon!')),
        );
        break;
      case 2:
        // Navigate to add
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/create_post',
          (route) => false,
        );
        break;
      case 3:
        // Navigate to notifications
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notifications functionality coming soon!'),
          ),
        );
        break;
      case 4:
        // Navigate to profile
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/profile',
          (route) => false,
        );
        break;
    }
  }
}
