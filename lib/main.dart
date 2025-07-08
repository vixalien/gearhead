import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/signup.dart';
import 'screens/screen2.dart';
import 'screens/screen3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gearhead App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Gearhead Home'),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/screen2': (context) => const Screen2(),
        '/screen3': (context) => const Screen3(),
      },
    );
  }
}

class ScreenItem {
  final String title;
  final String route;
  final IconData icon;

  const ScreenItem({
    required this.title,
    required this.route,
    required this.icon,
  });
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  // Array of screens for navigation
  final List<ScreenItem> screens = const [
    ScreenItem(title: 'Screen 1 (Login)', route: '/login', icon: Icons.login),
    ScreenItem(
      title: 'Screen 2 (Signup)',
      route: '/signup',
      icon: Icons.person_add,
    ),
    ScreenItem(title: 'Screen 3', route: '/screen2', icon: Icons.dashboard),
    ScreenItem(title: 'Screen 4', route: '/screen3', icon: Icons.settings),
  ];

  void _navigateToScreen(BuildContext context, String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Icon(Icons.home, size: 80, color: Colors.deepPurple),
              const SizedBox(height: 32),
              const Text(
                'Welcome to Gearhead',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Select a screen to navigate:',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              // Generate buttons from the screens array
              ...screens.map(
                (screen) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ElevatedButton.icon(
                    onPressed: () => _navigateToScreen(context, screen.route),
                    icon: Icon(screen.icon),
                    label: Text(screen.title),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
