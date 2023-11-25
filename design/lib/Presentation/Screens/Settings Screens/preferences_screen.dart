import 'package:design/Common/responsiveness.dart';
import 'package:flutter/material.dart';

class PreferencesSettings extends StatefulWidget {
  const PreferencesSettings({super.key});

  @override
  State<PreferencesSettings> createState() => _PreferencesSettingsState();
}

class _PreferencesSettingsState extends State<PreferencesSettings> {
  Set<String> _selectedModes = {};
  List<String> selectedCities = [
    'Chicago',
    'Houston',
    'Boston',
  ];
  List<String> selectedTypes = [
    'Contract',
    'Freelance',
    'Internship',
  ];
  List<String> selectedSkills = [
    'Flutter',
    'Dart',
    'Firebase',
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
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _skillController = TextEditingController();

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
        title: const Text('Prefences'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsiveness.sw(context) * 0.063,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // mode
              // const Text(
              //   'Mode(s):',
              //   style: TextStyle(
              //     fontSize: 18,
              //     fontWeight: FontWeight.w400,
              //   ),
              // ),
              SizedBox(
                height: Responsiveness.sh(context) * 0.009,
              ),
              SizedBox(
                width: double.maxFinite,
                child: SegmentedButton(
                  style: ButtonStyle(
                    animationDuration: const Duration(milliseconds: 369),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Responsiveness.sw(context) * 0.018),
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
                  selected: _selectedModes,
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
                      tooltip: 'Mix and match work from home and office days.',
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
                      _selectedModes = p0;
                    });
                  },
                  multiSelectionEnabled: true,
                  emptySelectionAllowed: true,
                  showSelectedIcon: false,
                ),
              ),

              // cities
              SizedBox(
                height: Responsiveness.sh(context) * 0.018,
              ),
              buildCitySearchField(),
              SizedBox(
                height: Responsiveness.sh(context) * 0.009,
              ),
              buildChips(selectedCities),

              // types
              SizedBox(
                height: Responsiveness.sh(context) * 0.018,
              ),
              buildTypesSearchField(),
              SizedBox(
                height: Responsiveness.sh(context) * 0.009,
              ),
              buildTypeChips(selectedTypes),

              // skills
              SizedBox(
                height: Responsiveness.sh(context) * 0.018,
              ),
              buildSkillsSearchField(),
              SizedBox(
                height: Responsiveness.sh(context) * 0.009,
              ),
              buildSkillsChips(selectedSkills),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSkillsSearchField() {
    return SizedBox(
      height: Responsiveness.sh(context) * 0.0639,
      child: TextFormField(
        controller: _skillController,
        onFieldSubmitted: (value) {
          addSkill(value);
          _locationController.clear();
        },
        decoration: InputDecoration(
          labelText: 'Skill(s)',
          hintText: 'Search skill name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Responsiveness.sw(context) * 0.018),
            ),
          ),
        ),
      ),
    );
  }

  void addSkill(String skillName) {
    if (selectedSkills.length < 9 && !selectedSkills.contains(skillName)) {
      setState(() {
        _skillController.text = '';
        selectedSkills.add(skillName);
      });
    }
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

  Widget buildTypesSearchField() {
    return SizedBox(
      height: Responsiveness.sh(context) * 0.0639,
      child: TextFormField(
        controller: _typeController,
        onFieldSubmitted: (value) {
          addType(value);
          _locationController.clear();
        },
        decoration: InputDecoration(
          labelText: 'Type(s)',
          hintText: 'Search type name',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(Responsiveness.sw(context) * 0.018),
            ),
          ),
        ),
      ),
    );
  }

  void addType(String typeName) {
    if (selectedTypes.length < 9 && !selectedTypes.contains(typeName)) {
      setState(() {
        _typeController.text = '';
        selectedTypes.add(typeName);
      });
    }
  }

  void addCity(String cityName) {
    if (selectedCities.length < 9 && !selectedCities.contains(cityName)) {
      setState(() {
        _locationController.text = '';
        selectedCities.add(cityName);
      });
    }
  }

  void removeCity(String cityName) {
    setState(() {
      selectedCities.remove(cityName);
    });
  }

  void removeType(String typeName) {
    setState(() {
      selectedTypes.remove(typeName);
    });
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

  Widget buildTypeChips(List<String> types) {
    return Wrap(
      spacing: 9.0,
      children: types.map((type) {
        return Chip(
          label: Text(type),
          onDeleted: () {
            removeType(type);
          },
        );
      }).toList(),
    );
  }

  void removeSkill(String skillName) {
    setState(() {
      selectedSkills.remove(skillName);
    });
  }

  Widget buildSkillsChips(List<String> skills) {
    return Wrap(
      spacing: 9.0,
      children: skills.map((skill) {
        return Chip(
          label: Text(skill),
          onDeleted: () {
            removeSkill(skill);
          },
        );
      }).toList(),
    );
  }
}
