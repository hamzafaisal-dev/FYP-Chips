import 'package:design/responsiveness.dart';
import 'package:flutter/material.dart';

class AddChipFormPage extends StatefulWidget {
  const AddChipFormPage({super.key});

  @override
  State<AddChipFormPage> createState() => _AddChipFormPageState();
}

class _AddChipFormPageState extends State<AddChipFormPage> {
  // for cities
  List<String> selectedCities = [
    'Chicago',
    'Houston',
    'Boston',
  ];
  final List<String> allCities = [
    'New York',
    'Los Angeles',
    'Chicago',
    'Houston',
    'Miami',
    'San Francisco',
    'Boston',
    'Seattle',
    'Dallas',
    'Denver',
    // this is temporary for testing
  ];

  // for FOIs
  List<String> selectedFOIs = [
    'Flutter',
    'Node.js',
    'SQL',
  ];

  String _selectedMode = '';
  RangeValues _values = const RangeValues(0, 20);
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // textformfield height
    double tffh = Responsiveness.sh(context) * 0.0639;
    // textformfield border radius
    double tffbr = Responsiveness.sw(context) * 0.018;
    return Scaffold(
      // appbar
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text('Add Chip'),
        centerTitle: true,
      ),

      // body
      body: SafeArea(
        child: SingleChildScrollView(
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

                // title textformfield
                SizedBox(
                  height: tffh,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Job Title',
                      hintText: 'E.g. Graduate Trainee',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(tffbr),
                        ),
                      ),
                    ),
                  ),
                ),

                // sized box
                SizedBox(
                  height: Responsiveness.sh(context) * 0.018,
                ),

                // company name textformfield
                SizedBox(
                  height: tffh,
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Company Name',
                      hintText: 'E.g. Google',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(tffbr),
                        ),
                      ),
                    ),
                  ),
                ),

                // sized box
                SizedBox(
                  height: Responsiveness.sh(context) * 0.018,
                ),

                // mode segmented button
                SizedBox(
                  width: double.maxFinite,
                  child: SegmentedButton(
                    style: ButtonStyle(
                      animationDuration: const Duration(milliseconds: 369),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(tffbr),
                        ),
                      ),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) {
                        return states.contains(MaterialState.selected)
                            ? Theme.of(context).colorScheme.surface
                            : Theme.of(context).colorScheme.background;
                      }),
                      foregroundColor: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) {
                        return states.contains(MaterialState.selected)
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.onBackground;
                      }),
                    ),
                    selected: {_selectedMode},
                    segments: [
                      ButtonSegment(
                        value: 'On-site',
                        icon: const Icon(Icons.business_rounded),
                        label: Text(
                          'On-site',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        tooltip: 'Work alongside colleagues in person.',
                      ),
                      ButtonSegment(
                        value: 'Hybrid',
                        icon: const Icon(Icons.home_work_outlined),
                        label: Text(
                          'Hybrid',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        tooltip:
                            'Mix and match work from home and office days.',
                      ),
                      ButtonSegment(
                        value: 'Remote',
                        icon: const Icon(Icons.laptop_windows_rounded),
                        label: Text(
                          'Remote',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        tooltip: 'Work from anywhere in the world.',
                      ),
                    ],
                    onSelectionChanged: (p0) {
                      setState(() {
                        if (p0.first == _selectedMode) {
                          _selectedMode = '';
                        } else {
                          _selectedMode = p0.first;
                        }
                      });
                    },
                    emptySelectionAllowed: true,
                    showSelectedIcon: false,
                  ),
                ),

                // sized box
                SizedBox(
                  height: Responsiveness.sh(context) * 0.018,
                ),

                // cities
                buildCitySearchField(),
                SizedBox(
                  height: Responsiveness.sh(context) * 0.009,
                ),
                buildChips(selectedCities),

                // sized box
                SizedBox(
                  height: Responsiveness.sh(context) * 0.018,
                ),

                // type drop down button
                SizedBox(
                  width: double.maxFinite,
                  child: DropdownButtonFormField(
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      labelText: 'Type',
                      hintText: 'E.g. Full-time',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(tffbr),
                        ),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Contract',
                        child: Text('Contract'),
                      ),
                      DropdownMenuItem(
                        value: 'Freelance',
                        child: Text('Freelance'),
                      ),
                      DropdownMenuItem(
                        value: 'Social Internship',
                        child: Text('Social Internship'),
                      ),
                      DropdownMenuItem(
                        value: 'Corporate Internship',
                        child: Text('Corporate Internship'),
                      ),
                      DropdownMenuItem(
                        value: 'Internship leading to Job',
                        child: Text('Internship leading to Job'),
                      ),
                      DropdownMenuItem(
                        value: 'Full-time Job',
                        child: Text('Full-time Job'),
                      ),
                      DropdownMenuItem(
                        value: 'Part-time Job',
                        child: Text('Part-time Job'),
                      ),
                    ],
                    onChanged: (p0) {},
                  ),
                ),

                // sized box
                SizedBox(
                  height: Responsiveness.sh(context) * 0.018,
                ),

                // preferred gender drop down
                SizedBox(
                  width: double.maxFinite,
                  child: DropdownButtonFormField(
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      labelText: 'Preferred Sex',
                      hintText: 'E.g. Female',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(tffbr),
                        ),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Male',
                        child: Tooltip(
                          message: 'Males preferred for this role',
                          child: Row(
                            children: [
                              Text('Male'),
                            ],
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Female',
                        child: Tooltip(
                          message: 'Females preferred for this role',
                          child: Row(
                            children: [
                              Text('Female'),
                            ],
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'Intersex',
                        child: Tooltip(
                          message: 'Intersex people preferred for this role',
                          child: Row(
                            children: [
                              Text('Intersex'),
                            ],
                          ),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 'No preference',
                        child: Tooltip(
                          message: 'All are welcome to apply for this role',
                          child: Row(
                            children: [
                              Text('No preference'),
                            ],
                          ),
                        ),
                      ),
                    ],
                    onChanged: (p0) {},
                  ),
                ),

                // sized box
                SizedBox(
                  height: Responsiveness.sh(context) * 0.018,
                ),

                // years of experience required range slider
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(tffbr),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: Responsiveness.sw(context) * 0.0234,
                          top: Responsiveness.sw(context) * 0.0234,
                        ),
                        child: Text(
                          "Experience Required (${_values.start.toInt().toString()}-${_values.end.toInt().toString()} years)",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                      RangeSlider(
                        values: _values,
                        min: 0,
                        max: 20,
                        divisions: 20,
                        onChanged: (rangeValues) {
                          setState(() {
                            _values = rangeValues;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                // sized box
                SizedBox(
                  height: Responsiveness.sh(context) * 0.018,
                ),

                // deadline datepicker
                SizedBox(
                  width: double.maxFinite,
                  child: TextFormField(
                    controller: _deadlineController,
                    decoration: InputDecoration(
                      labelText: 'Deadline to Apply',
                      hintText: 'E.g. 31/12/2021',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(tffbr),
                        ),
                      ),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 2),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _deadlineController.text =
                              pickedDate.toString().substring(0, 10);
                        });
                      }
                    },
                  ),
                ),

                // sized box
                SizedBox(
                  height: Responsiveness.sh(context) * 0.018,
                ),

                // cities
                buildFoiSearchField(),
                SizedBox(
                  height: Responsiveness.sh(context) * 0.009,
                ),
                buildFoiChips(selectedFOIs),

                // sized box
                SizedBox(
                  height: Responsiveness.sh(context) * 0.018,
                ),

                // description
                TextFormField(
                  maxLines: 5,
                  decoration: InputDecoration(
                    labelText: 'Job Description',
                    alignLabelWithHint: true,
                    // hintText: 'Job description...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(tffbr),
                      ),
                    ),
                  ),
                ),

                // sized box
                SizedBox(
                  height: Responsiveness.sh(context) * 0.018,
                ),
              ],
            ),
          ),
        ),
      ),

      // fab
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Post Chip',
        icon: const Icon(Icons.rocket_launch_rounded),
        label: const Text('Post'),
        onPressed: () {
          Navigator.pushNamed(context, '/addChipForm');
        },
      ),
    );
  }

  Widget buildChips(List<String> cities) {
    return Wrap(
      spacing: 9.0,
      children: cities.map((city) {
        return Chip(
          label: Text(city),
          onDeleted: () {
            removeCity(city);
          },
        );
      }).toList(),
    );
  }

  Widget buildFoiChips(List<String> fois) {
    return Wrap(
      spacing: 9.0,
      children: fois.map((foi) {
        return Chip(
          label: Text(foi),
          onDeleted: () {
            removeFoi(foi);
          },
        );
      }).toList(),
    );
  }

  Widget buildCitySearchField() {
    return SizedBox(
      height: Responsiveness.sh(context) * 0.0639,
      child: TextFormField(
        controller: _locationController,
        onFieldSubmitted: (value) {
          addCity(value);
          _locationController.clear();
        },
        decoration: InputDecoration(
          labelText: 'Location(s)',
          hintText: 'Search city name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Responsiveness.sw(context) * 0.018),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFoiSearchField() {
    return SizedBox(
      height: Responsiveness.sh(context) * 0.0639,
      child: TextFormField(
        controller: _locationController,
        onFieldSubmitted: (value) {
          addFoi(value);
          _locationController.clear();
        },
        decoration: InputDecoration(
          labelText: 'Skills',
          hintText: 'Search skills',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Responsiveness.sw(context) * 0.018),
            ),
          ),
        ),
      ),
    );
  }

  void addCity(String cityName) {
    if (selectedCities.length < 9 && !selectedCities.contains(cityName)) {
      setState(() {
        selectedCities.add(cityName);
      });
    }
  }

  void addFoi(String foi) {
    if (selectedFOIs.length < 9 && !selectedFOIs.contains(foi)) {
      setState(() {
        selectedFOIs.add(foi);
      });
    }
  }

  void removeCity(String cityName) {
    setState(() {
      selectedCities.remove(cityName);
    });
  }

  void removeFoi(String foi) {
    setState(() {
      selectedFOIs.remove(foi);
    });
  }
}
