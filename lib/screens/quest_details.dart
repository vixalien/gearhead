import 'package:flutter/material.dart';
import 'user_profile.dart';

class QuestDetailsScreen extends StatefulWidget {
  final String questId;
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

  const QuestDetailsScreen({
    super.key,
    required this.questId,
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

  @override
  State<QuestDetailsScreen> createState() => _QuestDetailsScreenState();
}

class _QuestDetailsScreenState extends State<QuestDetailsScreen> {
  bool _hasApplied = false;

  void _toggleApplication() {
    setState(() {
      _hasApplied = !_hasApplied;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _hasApplied
              ? 'Application submitted successfully!'
              : 'Application withdrawn',
        ),
        backgroundColor: _hasApplied ? Colors.green : Colors.orange,
      ),
    );
  }

  void _navigateToUserProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserProfileScreen(
          userId: widget.questId,
          username: widget.author,
          userAvatar: widget.authorAvatar,
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

  Color _getUrgencyColor(String urgency) {
    switch (urgency) {
      case 'High':
        return Colors.red.shade600;
      case 'Medium':
        return Colors.orange.shade600;
      case 'Low':
        return Colors.green.shade600;
      default:
        return Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Quest Details',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with user info and quest type
            Row(
              children: [
                GestureDetector(
                  onTap: _navigateToUserProfile,
                  child: CircleAvatar(
                    radius: 24,
                    backgroundImage: NetworkImage(widget.authorAvatar),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: _navigateToUserProfile,
                            child: Text(
                              widget.author,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: widget.questType == 'Help Request'
                                  ? Colors.orange.shade100
                                  : Colors.green.shade100,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              widget.questType,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: widget.questType == 'Help Request'
                                    ? Colors.orange.shade700
                                    : Colors.green.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            widget.location,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '• ${widget.timeAgo}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(widget.status),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.status,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    if (widget.urgency == 'High') ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'URGENT',
                          style: TextStyle(
                            fontSize: 10,
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

            const SizedBox(height: 24),

            // Title
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 16),

            // Description
            Text(
              widget.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            // Car and skill info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quest Information',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    Icons.directions_car,
                    'Vehicle',
                    '${widget.carMake} ${widget.carModel}',
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    Icons.build,
                    'Required Skill',
                    widget.skillRequired,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    Icons.location_on,
                    'Location',
                    widget.location,
                  ),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                    Icons.schedule,
                    'Urgency',
                    widget.urgency,
                    valueColor: _getUrgencyColor(widget.urgency),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Payment and responses
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.attach_money,
                        size: 32,
                        color: Colors.green.shade600,
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${widget.payment.toString()} RWF',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade600,
                            ),
                          ),
                          Text(
                            widget.questType == 'Help Request'
                                ? 'Budget'
                                : 'Service Price',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.responses.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Responses',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Action button
            if (widget.status == 'Open')
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _toggleApplication,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _hasApplied
                        ? Colors.grey.shade600
                        : (widget.questType == 'Help Request'
                              ? Colors.blue.shade600
                              : Colors.green.shade600),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _hasApplied
                        ? 'Application Submitted'
                        : (widget.questType == 'Help Request'
                              ? 'Offer Help'
                              : 'Contact for Service'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(
    IconData icon,
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: valueColor ?? Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
