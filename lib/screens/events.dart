import 'package:flutter/material.dart';
import '../components/bottom_navigation.dart';
import '../components/navigation_handler.dart';
import 'event_details.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _selectedIndex = 1; // Events tab is selected

  // Sample events data
  final List<CarEvent> _events = [
    CarEvent(
      id: '1',
      title: 'Toyota Meet Kigali',
      description:
          'Monthly Toyota owners meetup. Bring your ride and meet fellow Toyota enthusiasts! Food, music, and great vibes.',
      organizer: 'Toyota Club Rwanda',
      organizerAvatar:
          'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      eventImage:
          'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      eventType: 'Car Meet',
      location: 'Amahoro Stadium Parking',
      eventDate: 'Jan 20, 2025',
      startTime: '10:00 AM',
      endTime: '4:00 PM',
      attendees: 45,
      maxAttendees: 100,
      entryFee: 5000,
      isAttending: false,
    ),
    CarEvent(
      id: '2',
      title: 'Kigali Auto Show 2025',
      description:
          'The biggest automotive event in Rwanda! Latest car models, classic cars, tuning competition, and more.',
      organizer: 'Rwanda Auto Association',
      organizerAvatar:
          'https://images.unsplash.com/photo-1494790108755-2616b72b6698?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      eventImage:
          'https://images.unsplash.com/photo-1583121274602-3e2820c69888?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      eventType: 'Auto Show',
      location: 'BK Arena, Kigali',
      eventDate: 'Feb 15-17, 2025',
      startTime: '9:00 AM',
      endTime: '6:00 PM',
      attendees: 120,
      maxAttendees: 500,
      entryFee: 15000,
      isAttending: true,
    ),
    CarEvent(
      id: '3',
      title: 'Sunday Cruise to Nyanza',
      description:
          'Scenic drive to Nyanza with stops at beautiful viewpoints. Perfect for photography and bonding with fellow car lovers.',
      organizer: 'Kigali Cruisers',
      organizerAvatar:
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      eventImage:
          'https://images.unsplash.com/photo-1494905998402-395d579af36f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      eventType: 'Road Trip',
      location: 'Starting from Kimisagara',
      eventDate: 'Jan 28, 2025',
      startTime: '7:00 AM',
      endTime: '5:00 PM',
      attendees: 15,
      maxAttendees: 25,
      entryFee: 10000,
      isAttending: false,
    ),
    CarEvent(
      id: '4',
      title: 'Drift Competition',
      description:
          'Test your drifting skills! Open to all skill levels. Safety gear provided. Prizes for top 3 performers.',
      organizer: 'Rwanda Drift Club',
      organizerAvatar:
          'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      eventImage:
          'https://images.unsplash.com/photo-1542362567-b07e54358753?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1000&q=80',
      eventType: 'Competition',
      location: 'Nyamirambo Stadium',
      eventDate: 'Feb 10, 2025',
      startTime: '2:00 PM',
      endTime: '6:00 PM',
      attendees: 8,
      maxAttendees: 20,
      entryFee: 25000,
      isAttending: true,
    ),
  ];

  void _addNewEvent() {
    Navigator.pushNamed(context, '/add_event');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: Text(
          'Events',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).appBarTheme.foregroundColor,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).appBarTheme.foregroundColor,
              size: 28,
            ),
            onPressed: _addNewEvent,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Simulate refresh
          await Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
          itemCount: _events.length,
          itemBuilder: (context, index) {
            return EventWidget(
              event: _events[index],
              onAttendToggle: (eventId) {
                setState(() {
                  final event = _events.firstWhere((e) => e.id == eventId);
                  event.isAttending = !event.isAttending;
                  if (event.isAttending) {
                    event.attendees++;
                  } else {
                    event.attendees--;
                  }
                });
              },
              onTap: () {
                final event = _events[index];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsScreen(
                      eventId: event.id,
                      title: event.title,
                      description: event.description,
                      organizer: event.organizer,
                      organizerAvatar: event.organizerAvatar,
                      eventImage: event.eventImage,
                      eventType: event.eventType,
                      location: event.location,
                      eventDate: event.eventDate,
                      startTime: event.startTime,
                      endTime: event.endTime,
                      attendees: event.attendees,
                      maxAttendees: event.maxAttendees,
                      entryFee: event.entryFee,
                      isAttending: event.isAttending,
                    ),
                  ),
                );
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

class CarEvent {
  final String id;
  final String title;
  final String description;
  final String organizer;
  final String organizerAvatar;
  final String eventImage;
  final String eventType;
  final String location;
  final String eventDate;
  final String startTime;
  final String endTime;
  int attendees;
  final int maxAttendees;
  final int entryFee;
  bool isAttending;

  CarEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.organizer,
    required this.organizerAvatar,
    required this.eventImage,
    required this.eventType,
    required this.location,
    required this.eventDate,
    required this.startTime,
    required this.endTime,
    required this.attendees,
    required this.maxAttendees,
    required this.entryFee,
    required this.isAttending,
  });
}

class EventWidget extends StatelessWidget {
  final CarEvent event;
  final Function(String) onAttendToggle;
  final VoidCallback onTap;

  const EventWidget({
    super.key,
    required this.event,
    required this.onAttendToggle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(
                Theme.of(context).brightness == Brightness.dark ? 0.3 : 0.1,
              ),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Event image
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                image: DecorationImage(
                  image: NetworkImage(event.eventImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Event type badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          event.eventType,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      // Event title overlay
                      Text(
                        event.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 1),
                              blurRadius: 3,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Event details
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Organizer info
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: NetworkImage(event.organizerAvatar),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'by ${event.organizer}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[400]
                              : Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Description
                  Text(
                    event.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black87,
                      height: 1.4,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 16),

                  // Event details grid
                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          context,
                          Icons.calendar_today,
                          'Date',
                          event.eventDate,
                        ),
                      ),
                      Expanded(
                        child: _buildDetailItem(
                          context,
                          Icons.access_time,
                          'Time',
                          '${event.startTime} - ${event.endTime}',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      Expanded(
                        child: _buildDetailItem(
                          context,
                          Icons.location_on,
                          'Location',
                          event.location,
                        ),
                      ),
                      Expanded(
                        child: _buildDetailItem(
                          context,
                          Icons.attach_money,
                          'Entry Fee',
                          '${event.entryFee} RWF',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Attendees and action
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.people, size: 18, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Text(
                            '${event.attendees}/${event.maxAttendees} attending',
                            style: TextStyle(
                              fontSize: 14,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? Colors.grey[400]
                                  : Colors.grey[600],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () => onAttendToggle(event.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: event.isAttending
                              ? Colors.green.shade600
                              : Colors.blue.shade600,
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
                          event.isAttending ? 'Attending' : 'Join Event',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.grey[400]
              : Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[400]
                      : Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 13,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
