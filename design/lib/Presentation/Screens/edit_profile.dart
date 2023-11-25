import 'package:design/Common/responsiveness.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // app bar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text('Edit Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),

      // body
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsiveness.sw(context) * 0.063,
          ),
          child: Column(
            children: [
              // edit picture
              CircleAvatar(
                radius: Responsiveness.sw(context) * 0.117,
                backgroundImage: const AssetImage('assets/pictures/daa.jpeg'),
              ),
              TextButton(
                child: const Text('Edit Picture'),
                onPressed: () {},
              ),

              // name textformfield
              SizedBox(
                height: Responsiveness.sh(context) * 0.0639,
                child: TextFormField(
                  controller: TextEditingController(
                    text: 'Ali Jone',
                  ),
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'E.g. Dawood Haroon',
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

              // sex
              SizedBox(
                width: double.maxFinite,
                child: DropdownButtonFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    labelText: 'Sex',
                    hintText: 'E.g. Female',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(Responsiveness.sw(context) * 0.018),
                      ),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'Female',
                      child: Text('Female'),
                    ),
                    DropdownMenuItem(
                      value: 'Intersex',
                      child: Text('Intersex'),
                    ),
                  ],
                  onChanged: (p0) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
