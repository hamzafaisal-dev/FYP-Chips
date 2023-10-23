import 'package:design/responsiveness.dart';
import 'package:flutter/material.dart';

class ChangePasswordSettings extends StatelessWidget {
  const ChangePasswordSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text('Change Password'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsiveness.sw(context) * 0.063,
          ),
          child: Column(
            children: [
              // sized box
              SizedBox(
                height: Responsiveness.sh(context) * 0.018,
              ),

              // old password textformfield
              SizedBox(
                height: Responsiveness.sh(context) * 0.0639,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.visibility),
                    labelText: 'Old Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Responsiveness.sw(context) * 0.018),
                      ),
                    ),
                  ),
                ),
              ),

              // sized box
              SizedBox(
                height: Responsiveness.sh(context) * 0.018,
              ),

              // new password textformfield
              SizedBox(
                height: Responsiveness.sh(context) * 0.0639,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.visibility),
                    labelText: 'New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Responsiveness.sw(context) * 0.018),
                      ),
                    ),
                  ),
                ),
              ),

              // sized box
              SizedBox(
                height: Responsiveness.sh(context) * 0.018,
              ),

              // confirm new password textformfield
              SizedBox(
                height: Responsiveness.sh(context) * 0.0639,
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.visibility),
                    labelText: 'Confirm New Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Responsiveness.sw(context) * 0.018),
                      ),
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
