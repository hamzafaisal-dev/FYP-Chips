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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: BlocBuilder<ChipBloc, ChipState>(
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
                        color: Colors.white,
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  //
                                  Row(
                                    children: [
                                      //
                                      const Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: CircleAvatar(
                                          radius: 16,
                                          child: Icon(Icons.person_3),
                                        ),
                                      ),

                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            chipObject.postedBy,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            '41m ago',
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondaryContainer,
                                              // fontWeight: FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                    child: Icon(
                                      Icons.bookmark_outline,
                                      size: 22,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  )
                                ],
                              ),

                              Divider(
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                thickness: 2,
                              ),

                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 3, 0, 4),
                                child: Text(
                                  chipObject.jobTitle,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'lorem ipsum dolor sit amet consectetur lorem ipsum dolor sit amet consectetur lorem ipsum dolor sit amet consectetur lorem ipsum dolor sit amet consectetur...',
                                ),
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  //
                                  Image.asset('assets/HeartLike.png',
                                      scale: 0.8),

                                  SizedBox(width: 4),

                                  Text(
                                    '3.1k',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 10),
                            ],
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
      ),
    );
  }
}
