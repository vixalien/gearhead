import 'package:flutter/material.dart';

class NavigationHandler {
  static void handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Navigate to spots
        Navigator.pushNamedAndRemoveUntil(context, '/spots', (route) => false);
        break;
      case 1:
        // Navigate to events
        Navigator.pushNamedAndRemoveUntil(context, '/events', (route) => false);
        break;
      case 2:
        // Navigate to quests
        Navigator.pushNamedAndRemoveUntil(context, '/quests', (route) => false);
        break;
      case 3:
        // Navigate to notifications
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/notifications',
          (route) => false,
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
