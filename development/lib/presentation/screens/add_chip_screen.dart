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

//  BlocProvider.of<ChipBloc>(context).add(
//                 UploadChipEvent(
//                   jobTitle: 'Pishi Maker',
//                   companyName: 'Pishi Limited',
//                   description: 'We make the best pishi in Karachi',
//                   jobMode: 'on-site',
//                   locations: const [],
//                   jobType: 'full-time',
//                   experienceRequired: 20,
//                   deadline: DateTime.now(),
//                   skills: const [],
//                   salary: 0,
//                   updatedUser: _authenticatedUser,
//                   uploaderAvatar: _authenticatedUser.userName,
//                 ),
//               );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //     //
      //     // leading: IconButton(
      //     //   onPressed: () {},
      //     //   icon: const Icon(Icons.close),
      //     // ),

      //     // actions: [
      //     //   SizedBox(
      //     //     width: 120,
      //     //     child: FilledButton(
      //     //       onPressed: () {},
      //     //       child: Text('Post'),
      //     //     ),
      //     //   ),
      //     // ],
      //     ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //
              Column(
                children: [
                  // close icon + circle avatar + post btn
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),

                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        iconSize: 26,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  const TextField(
                    decoration: InputDecoration.collapsed(
                      hintText: "Paste job details",
                    ),
                    scrollPadding: EdgeInsets.all(20.0),
                    autofocus: true,
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text('✨ Post with autofill AI ✨'),
                  ),
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     //
              //     OutlinedButton(
              //       onPressed: () {},
              //       child: const Text('✨ Autofill AI ✨'),
              //     ),

              //     Row(
              //       children: [
              //         //
              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(Icons.add_circle_outline),
              //         ),

              //         IconButton(
              //           onPressed: () {},
              //           icon: const Icon(Icons.add_a_photo),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
