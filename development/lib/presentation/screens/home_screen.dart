import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/blocs/sign_in/sign_in_bloc.dart';
import 'package:development/business%20logic/blocs/sign_up/sign_up_bloc.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserModel _authenticedUser;

  @override
  void initState() {
    final chipBloc = BlocProvider.of<ChipBloc>(context);

    final authBlocBloc = BlocProvider.of<AuthBloc>(context);
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);
    final signInBloc = BlocProvider.of<SignInBloc>(context);

    if (authBlocBloc.state is AuthStateAuthenticated) {
      _authenticedUser =
          (authBlocBloc.state as AuthStateAuthenticated).authenticatedUser;
    } else if (signUpBloc.state is SignUpValidState) {
      _authenticedUser = (signUpBloc.state as SignUpValidState).newUser;
    } else if (signInBloc.state is SignInValidState) {
      _authenticedUser =
          (signInBloc.state as SignInValidState).authenticatedUser;
    }

    if (chipBloc.state is! ChipsStreamLoaded) {
      chipBloc.add(const FetchChipsStream());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChipBloc, ChipState>(
      builder: (context, state) {
        if (state is ChipsStreamLoaded) {
          return StreamBuilder(
            stream: state.chips,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                ));
              }

              if (snapshot.hasError) {
                return Text(
                  snapshot.error.toString(),
                );
              }

              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Text(
                    'Could not find what you were looking for',
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    List<ChipModel> chipData = snapshot.data!;
                    var chipObject = chipData[index];

                    return Card(
                      child: ListTile(
                        title: Text(chipObject.chipId),
                        trailing: IconButton(
                          onPressed: () {
                            BlocProvider.of<ChipBloc>(context).add(
                              DeleteChipEvent(
                                chipId: chipObject.chipId,
                                user: _authenticedUser,
                              ),
                            );
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ),
                    );
                  },
                );
              }
              return const SizedBox();
            },
          );
        }

        if (state is ChipEmpty) {
          return const Text('khaali hai');
        }

        return const SizedBox.shrink();
      },
    );
  }
}
