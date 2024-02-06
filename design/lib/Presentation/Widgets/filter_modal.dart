import 'package:design/Common/responsiveness.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  // variables to store selected filter values
  String? selectedJobType;
  List<String> selectedWorkModes = [];
  List<String> selectedLocations = [];
  List<String> selectedFields = [];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsiveness.sw(context) * 0.063,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // filter title
              const Text(
                'Filter Chips',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),

              // mode
              // title
              const Row(
                children: [
                  Text(
                    'Mode',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              // chips
              Row(
                children: [
                  FilterChip(
                    avatar: const Icon(Icons.business_rounded),
                    label: const Text('On-site'),
                    onSelected: (value) {},
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.018),
                  FilterChip(
                    avatar: const Icon(Icons.home_work_outlined),
                    label: const Text('Hybrid'),
                    onSelected: (value) {},
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.018),
                  FilterChip(
                    avatar: const Icon(Icons.laptop_windows_rounded),
                    label: const Text('Remote'),
                    onSelected: (value) {},
                  ),
                ],
              ),

              // space
              SizedBox(height: Responsiveness.sw(context) * 0.009),

              // cities
              // title
              const Row(
                children: [
                  Text(
                    'Cities',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              // chips
              Row(
                children: [
                  FilterChip(
                    label: const Text('Hyderabad'),
                    onSelected: (value) {},
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.018),
                  FilterChip(
                    label: const Text('Karachi'),
                    onSelected: (value) {},
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.018),
                  FilterChip(
                    label: const Text('Lahore'),
                    onSelected: (value) {},
                  ),
                ],
              ),

              // space
              SizedBox(height: Responsiveness.sw(context) * 0.009),

              // type
              // title
              const Row(
                children: [
                  Text(
                    'Type',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              // chips
              Row(
                children: [
                  FilterChip(
                    label: const Text('Contract'),
                    onSelected: (value) {},
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.018),
                  FilterChip(
                    label: const Text('Freelance'),
                    onSelected: (value) {},
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.018),
                  FilterChip(
                    label: const Text('Internship'),
                    onSelected: (value) {},
                  ),
                ],
              ),

              // space
              SizedBox(height: Responsiveness.sw(context) * 0.009),

              // skills
              // title
              const Row(
                children: [
                  Text(
                    'Skills',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              // chips
              Row(
                children: [
                  FilterChip(
                    label: const Text('Flutter'),
                    onSelected: (value) {},
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.018),
                  FilterChip(
                    label: const Text('Dart'),
                    onSelected: (value) {},
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.018),
                  FilterChip(
                    label: const Text('Firebase'),
                    onSelected: (value) {},
                  ),
                ],
              ),

              // space
              SizedBox(
                height: Responsiveness.sw(context) * 0.063,
              ),

              // apply/clear filters buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // clear filters
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Clear Filters',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ),

                  // apply filters
                  TextButton(
                    onPressed: () {},
                    child: const Text('Apply Filters'),
                  ),
                ],
              ),

              SizedBox(
                height: Responsiveness.sw(context) * 0.0369,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
