import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChipScreen extends StatefulWidget {
  const AddChipScreen({super.key});

  @override
  State<AddChipScreen> createState() => _AddChipScreenState();
}

class _AddChipScreenState extends State<AddChipScreen> {
  late UserModel _authenticatedUser;

  @override
  void initState() {
    // access the auth blok using the context
    final authBloc = BlocProvider.of<AuthBloc>(context);

    if (authBloc.state is AuthStateAuthenticated) {
      _authenticatedUser =
          (authBloc.state as AuthStateAuthenticated).authenticatedUser;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: FilledButton(
            onPressed: () {
              BlocProvider.of<ChipBloc>(context).add(
                UploadChipEvent(
                  jobTitle: 'Pishi Maker',
                  companyName: 'Pishi Limited',
                  description: 'We make the best pishi in Karachi',
                  jobMode: 'on-site',
                  locations: const [],
                  jobType: 'full-time',
                  experienceRequired: 20,
                  deadline: DateTime.now(),
                  skills: [],
                  salary: 0,
                  updatedUser: _authenticatedUser,
                  uploaderAvatar: _authenticatedUser.userName,
                ),
              );
            },
            child: const Text('Create New Chip'),
          ),
        ),
      ],
    );
  }
}
