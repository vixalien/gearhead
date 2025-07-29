import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/car_spots.dart';
import 'screens/events.dart';
import 'screens/quests.dart';
import 'screens/notifications.dart';
import 'screens/profile.dart';
import 'screens/forgot_password.dart';
import 'screens/splash_screen.dart';
import 'screens/settings.dart';
import 'screens/add_spot.dart';
import 'screens/add_event.dart';
import 'screens/add_quest.dart';
import 'screens/user_profile.dart';
import 'screens/event_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gearhead App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser != null
          ? const CarSpotsScreen()
          : const SplashScreen(),
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/spots': (context) => const CarSpotsScreen(),
        '/events': (context) => const EventsScreen(),
        '/quests': (context) => const QuestsScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/forgot_password': (context) => const ForgotPassword(),
        '/settings': (context) => const SettingsScreen(),
        '/add_spot': (context) => const AddSpotScreen(),
        '/add_event': (context) => const AddEventScreen(),
        '/add_quest': (context) => const AddQuestScreen(),
        '/user_profile': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;
          return UserProfileScreen(
            userId: args['userId'],
            username: args['username'],
            userAvatar: args['userAvatar'],
          );
        },
      },
    );
  }
}
