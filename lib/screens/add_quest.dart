import 'package:flutter/material.dart';

class AddQuestScreen extends StatefulWidget {
  const AddQuestScreen({super.key});

  @override
  State<AddQuestScreen> createState() => _AddQuestScreenState();
}

class _AddQuestScreenState extends State<AddQuestScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _paymentController = TextEditingController();
  final _carMakeController = TextEditingController();
  final _carModelController = TextEditingController();

  String _questType = 'Help Request'; // 'Help Request' or 'Service Offer'
  String? _selectedSkill;
  String _urgency = 'Medium';
  bool _isLoading = false;

  // Skills/Services list
  final List<String> _skills = [
    'Engine Repair',
    'Brake Repair',
    'Transmission Service',
    'Electrical Repair',
    'Turbo Installation',
    'Engine Tuning',
    'Suspension Work',
    'Body Work',
    'Paint Job',
    'Car Detailing',
    'Tire Service',
    'Oil Change',
    'Air Conditioning',
    'Car Audio Installation',
    'Performance Upgrades',
    'Diagnostic',
    'Welding',
    'Towing Service',
    'Other',
  ];

  // Car makes for dropdown
  final List<String> _carMakes = [
    'Toyota',
    'Honda',
    'BMW',
    'Mercedes',
    'Audi',
    'Volkswagen',
    'Ford',
    'Nissan',
    'Mazda',
    'Subaru',
    'Hyundai',
    'Kia',
    'Lexus',
    'Infiniti',
    'Acura',
    'All Makes',
    'Other',
  ];

  String? _selectedCarMake;
  String _status = 'upcoming'; // upcoming, ongoing, completed, cancelled

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _paymentController.dispose();
    _carMakeController.dispose();
    _carModelController.dispose();
    super.dispose();
  }

  void _submitQuest() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              _questType == 'Help Request'
                  ? 'Help request posted successfully!'
                  : 'Service offer posted successfully!',
            ),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pop(context);
      }
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
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Create Quest',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _submitQuest,
            child: Text(
              'Post',
              style: TextStyle(
                color: _isLoading ? Colors.grey : Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Quest type toggle
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _questType = 'Help Request';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: _questType == 'Help Request'
                                ? Colors.orange.shade600
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Request Help',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _questType == 'Help Request'
                                  ? Colors.white
                                  : Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _questType = 'Service Offer';
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: _questType == 'Service Offer'
                                ? Colors.green.shade600
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            'Offer Service',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: _questType == 'Service Offer'
                                  ? Colors.white
                                  : Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Title
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: _questType == 'Help Request'
                      ? 'What do you need help with?'
                      : 'What service do you offer?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  hintText: _questType == 'Help Request'
                      ? 'Describe the problem and what kind of help you need...'
                      : 'Describe your service, experience, and what you can offer...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please add a description';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Car information section
              const Text(
                'Car Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 16),

              // Car make dropdown
              DropdownButtonFormField<String>(
                value: _selectedCarMake,
                decoration: InputDecoration(
                  labelText: 'Car Make',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                items: _carMakes.map((String make) {
                  return DropdownMenuItem<String>(
                    value: make,
                    child: Text(make),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCarMake = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select car make';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Car model
              TextFormField(
                controller: _carModelController,
                decoration: InputDecoration(
                  labelText: 'Car Model (or "All Models")',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter car model';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 24),

              // Service details section
              const Text(
                'Service Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 16),

              // Skill/Service dropdown
              DropdownButtonFormField<String>(
                value: _selectedSkill,
                decoration: InputDecoration(
                  labelText: _questType == 'Help Request'
                      ? 'Required Skill'
                      : 'Service Type',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                items: _skills.map((String skill) {
                  return DropdownMenuItem<String>(
                    value: skill,
                    child: Text(skill),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSkill = newValue;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a skill/service';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Location
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Payment and urgency row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _paymentController,
                      decoration: InputDecoration(
                        labelText: _questType == 'Help Request'
                            ? 'Budget (RWF)'
                            : 'Price (RWF)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Required';
                        }
                        final number = int.tryParse(value);
                        if (number == null || number <= 0) {
                          return 'Invalid amount';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _urgency,
                      decoration: InputDecoration(
                        labelText: 'Urgency',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                      ),
                      items: ['Low', 'Medium', 'High'].map((String urgency) {
                        return DropdownMenuItem<String>(
                          value: urgency,
                          child: Text(urgency),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _urgency = newValue!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Info card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _questType == 'Help Request'
                      ? Colors.orange.shade50
                      : Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _questType == 'Help Request'
                        ? Colors.orange.shade200
                        : Colors.green.shade200,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _questType == 'Help Request'
                          ? Icons.help_outline
                          : Icons.handyman,
                      color: _questType == 'Help Request'
                          ? Colors.orange.shade600
                          : Colors.green.shade600,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _questType == 'Help Request'
                            ? 'Your help request will be visible to mechanics and car enthusiasts who can assist you.'
                            : 'Your service offer will be visible to car owners who need assistance.',
                        style: TextStyle(
                          fontSize: 14,
                          color: _questType == 'Help Request'
                              ? Colors.orange.shade700
                              : Colors.green.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitQuest,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _questType == 'Help Request'
                        ? Colors.orange.shade600
                        : Colors.green.shade600,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : Text(
                          _questType == 'Help Request'
                              ? 'Post Help Request'
                              : 'Post Service Offer',
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
      ),
    );
  }
}
