import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:development/presentation/widgets/custom_preference_chip.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// this shouldve done came from db but i cant move it move it anymore mauricio
List<String> interests = [
  'Python',
  'Java',
  'JavaScript',
  'C/C++',
  'Swift',
  'Kotlin',
  'Ruby',
  'TypeScript',
  'Go',
  'Rust',
  'Vue.js',
  'React.js',
  'Angular',
  'Express.js',
  'Django',
  'Flask',
  'Ruby on Rails',
  'ASP.NET',
  'Laravel',
  'Spring Boot',
  'Flutter',
  'React Native',
  'Objective-C',
  'iOS Development',
  'Swift',
  'Java',
  'NLTK',
  'AI',
  'ML',
  'Kotlin',
  'Artificial Intelligence',
  'Keras',
  'Machine Learning',
  'TensorFlow',
  'PyTorch',
  'OpenCV',
  'SpaCy',
  'Gensim',
  'Data Science',
  'Pandas',
  'NumPy',
  'Matplotlib',
  'Seaborn',
  'Plotly',
  'Tableau',
  'Power BI',
  'Apache Spark',
  'Hadoop',
  'Cloud Computing',
  'IBM Cloud',
  'Amazon Web Services (AWS)',
  'Heroku',
  'Google Cloud Platform (GCP)',
  'Microsoft Azure',
  'DigitalOcean',
  'Docker',
  'Kubernetes',
  'Jenkins',
  'Travis CI',
  'CircleCI',
  'GitLab CI',
  'Ansible',
  'Terraform',
  'Chef',
  'Puppet',
  'MySQL',
  'PostgreSQL',
  'MongoDB',
  'Redis',
  'SQLite',
  'Microsoft SQL Server',
  'Oracle Database',
  'Wireshark',
  'Metasploit',
  'Nessus',
  'Snort',
  'Nmap',
  'Burp Suite',
  'OSSEC',
  'Splunk',
  'Unity',
  'Unreal Engine',
];

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen({super.key});

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  late UserModel? _authenticatedUser;

  List<String> _interests = [];

  void _handleInterestClick(String interest) {
    _interests.contains(interest)
        ? _interests.remove(interest)
        : _interests.add(interest);
  }

  void _handleContinueClick() {
    if (_authenticatedUser != null) {
      _authenticatedUser = _authenticatedUser!.copyWith(skills: _interests);

      BlocProvider.of<UserCubit>(context).updateUser(_authenticatedUser!);
    }
  }

  @override
  void initState() {
    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: 8.1.h),

              SizedBox(height: 17.h),

              // 'Interests'
              Text(
                'Interests',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 4.h),

              // ''
              Text(
                'Pick at least one skill you\'re interested in',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 15.h),

              Wrap(
                children: [
                  ...interests.map(
                    (interest) => PreferenceChip(
                      chipLabel: interest,
                      selectedChips: _interests,
                      onPressed: (interest) => _handleInterestClick(interest),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 15.h),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserProfileUpdated) {
              NavigationService.pushAndRemoveUntil('/layout');

              HelperWidgets.showSnackbar(
                context,
                'Account Created Successfully! Welcome to Chips!🍟',
                'success',
              );
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.91,
              child: FilledButton(
                onPressed: (state is UpdatingUserProfile)
                    ? null
                    : () {
                        if (_interests.isNotEmpty) {
                          _handleContinueClick();
                        } else {
                          HelperWidgets.showSnackbar(
                            context,
                            'Please select at least 1 interest',
                            'error',
                          );
                        }
                      },
                child: (state is AuthSignInLoading)
                    ? const CustomCircularProgressIndicator()
                    : const Text('Continue'),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
