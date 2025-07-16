import 'package:flutter/material.dart';

class ResetPasswordInfo extends StatefulWidget {
  const ResetPasswordInfo({super.key});

  @override
  State<ResetPasswordInfo> createState() => _ResetPasswordInfoState();
}

class _ResetPasswordInfoState extends State<ResetPasswordInfo> {
  void _createPassword() {
    Navigator.pushNamed(context, '/create_password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Password Reset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
                Text(
                  'Logo Placeholder',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: 32),
        
                Text(
                  'Password Reset',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 24),

                Text(
                  'Your password has been successfully reset, click Confirm to set a new password',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),

                SizedBox(height: 120),

                SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1D61E7),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: _createPassword,
                  child: const Text('Confirm'),
                ),
              ),                
            ],
          ),
        ),
      )
    );
  }
}