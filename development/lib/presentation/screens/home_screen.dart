import 'package:development/business%20logic/blocs/auth/auth_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/blocs/sign_in/sign_in_bloc.dart';
import 'package:development/business%20logic/blocs/sign_up/sign_up_bloc.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/chip_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late UserModel _authenticedUser;

  final _potty = TextEditingController();

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
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<ChipBloc, ChipState>(
        builder: (context, state) {
          if (state is ChipsStreamLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //
                SizedBox(height: 16.h),

                // hey, user name
                RichText(
                  text: TextSpan(
                    text: 'hello, ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 36.sp,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        // text: 'Farhan Mushi',
                        text: _authenticedUser.userName,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 36.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ],
                  ),
                ),

                RichText(
                  text: TextSpan(
                    text: 'here are some ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 18.sp,
                        ),
                    children: [
                      TextSpan(
                        text: 'Chips',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 18.sp,
                            ),
                      ),
                      TextSpan(
                        text: ' for you',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                            ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 23.4.h),

                // search bar
                TextFormField(
                  controller: _potty,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: 'Search',
                    hintStyle: Theme.of(context).textTheme.bodyLarge,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 20.w,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 0.w,
                      vertical: 0.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ),

                SizedBox(height: 23.4.h),

                StreamBuilder(
                  stream: state.chips,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (snapshot.hasError) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            snapshot.error.toString(),
                          ),
                        ),
                      );
                    }

                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Expanded(
                          child: Center(
                            child: Text(
                              'Could not find what you were looking for',
                            ),
                          ),
                        );
                      }

                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            List<ChipModel> chipData = snapshot.data!;
                            var chipObject = chipData[index];

                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.8.h),
                              child: ChipTile(
                                postedBy: chipObject.postedBy,
                                jobTitle: chipObject.jobTitle,
                                description: chipObject.description,
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
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
