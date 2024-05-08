import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/chip_tile.dart';
import 'package:development/presentation/widgets/chip_tile_skeleton.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/presentation/widgets/user_prof_screen_header_skeleton.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../widgets/user_profile_screen_header.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late final UserModel? _authenticatedUser;

  late final UserModel? _loadedUser;

  @override
  void initState() {
    super.initState();

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.fetchUserChipsStream(_authenticatedUser!.username);

    BlocProvider.of<ChipBloc>(context).add(const JustFetchChips());

    if (widget.arguments != null) {
      String postedBy = widget.arguments!["postedBy"];

      BlocProvider.of<UserCubit>(context).fetchUserByUsername(postedBy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        BlocProvider.of<UserCubit>(context).fetchTopContributors();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,

          // back button
          leadingWidth: 64.w,
          leading: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0.h, 0.w, 0.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CustomIconButton(
                iconSvgPath: AssetPaths.leftArrowIconPath,
                iconWidth: 16.w,
                iconHeight: 16.h,
                onTap: () {
                  BlocProvider.of<UserCubit>(context).fetchTopContributors();

                  NavigationService.goBack();
                },
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              // user details section
              Padding(
                padding: EdgeInsets.only(top: 5.h, bottom: 10.h),
                child: BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    if (state is UserLoadingState) {
                      return const UserProfileScreenHeaderSkeleton();
                    }

                    if (widget.arguments?["postedBy"] ==
                        _authenticatedUser?.username) {
                      Helpers.logEvent(
                        _authenticatedUser!.userId,
                        "view-own-profile",
                        [_authenticatedUser],
                      );
                      return UserProfileScreenHeader(
                        authenticatedUser: _authenticatedUser,
                        isEditable: true,
                      );
                    } else if (state is UserLoadedState) {
                      _loadedUser = state.user;

                      Helpers.logEvent(
                        _authenticatedUser!.userId,
                        "view-profile",
                        [state.user],
                      );
                      return UserProfileScreenHeader(
                        authenticatedUser: state.user,
                        isEditable: false,
                      );
                    } else {
                      Helpers.logEvent(
                        _authenticatedUser!.userId,
                        "view-own-profile",
                        [_authenticatedUser],
                      );
                      return UserProfileScreenHeader(
                        authenticatedUser: _authenticatedUser,
                        isEditable: true,
                      );
                    }
                  },
                ),
              ),

              // your chips
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  "Posted Chips",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),

              BlocBuilder<ChipBloc, ChipState>(
                builder: (context, state) {
                  if (state is ChipsLoading) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: 9,
                        itemBuilder: (context, index) =>
                            const ChipTileSkeleton(),
                      ),
                    );
                  } else if (state is ChipsStreamLoaded) {
                    List<ChipModel> chipsList = state.chips;
                    List<ChipModel> usersChips = [];
                    for (ChipModel chip in chipsList) {
                      if (_authenticatedUser!.postedChips
                          .contains(chip.chipId)) {
                        usersChips.add(chip);
                      }
                    }

                    if (usersChips.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                AssetPaths.appliedEmptyAnimationPath,
                                width: 200.w,
                                repeat: true,
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "No chips posted yet!",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: usersChips.length,
                          itemBuilder: (context, index) {
                            ChipModel chip = usersChips[index];

                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.8.h),
                              child: ChipTile(
                                chipData: chip,
                                currentUser: _authenticatedUser!,
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else if (state is ChipError) {
                    return Text(state.errorMsg);
                  }
                  return const Text("woops, something went wrong...");
                },
              ),

              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
