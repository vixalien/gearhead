import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../components/bottom_navigation.dart';
import '../components/navigation_handler.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  int _selectedIndex = 2;

  bool isPicturePost = true;
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Event fields
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _imageFile = picked;
      });
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _submitPost() {
    if (isPicturePost) {
      // Handle image post
      if (_imageFile == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Please select an image')));
        return;
      }
    } else {
      // Handle event post
      if (_titleController.text.isEmpty ||
          _selectedDate == null ||
          _locationController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete all event details')),
        );
        return;
      }
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Post submitted!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Post')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ToggleButtons(
              isSelected: [isPicturePost, !isPicturePost],
              onPressed: (index) {
                setState(() {
                  isPicturePost = index == 0;
                });
              },
              borderRadius: BorderRadius.circular(8),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Post Picture'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text('Post Event'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: isPicturePost
                    ? _buildPicturePostForm()
                    : _buildEventPostForm(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1D61E7),
                  foregroundColor: Colors.white,
                ),
                onPressed: _submitPost,
                child: const Text('Submit'),
              ),
            ),
          ],
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

  Widget _buildPicturePostForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _imageFile != null
            ? Image.file(
                File(_imageFile!.path),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : const SizedBox(),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text("Choose Image"),
        ),
        const SizedBox(height: 16),
        const TextField(
          decoration: InputDecoration(
            labelText: 'Caption (optional)',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  Widget _buildEventPostForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Show picked image if any
        _imageFile != null
            ? Image.file(
                File(_imageFile!.path),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : const SizedBox(),

        const SizedBox(height: 16),

        // Button to pick image
        OutlinedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: const Text("Choose Image"),
        ),

        const SizedBox(height: 16),

        TextField(
          controller: _titleController,
          decoration: const InputDecoration(
            labelText: 'Event Title',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _descriptionController,
          maxLines: 3,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _locationController,
          decoration: const InputDecoration(
            labelText: 'Location',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        OutlinedButton.icon(
          onPressed: _pickDate,
          icon: const Icon(Icons.date_range),
          label: Text(
            _selectedDate == null
                ? 'Choose Event Date'
                : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
          ),
        ),
      ],
    );
  }
}
