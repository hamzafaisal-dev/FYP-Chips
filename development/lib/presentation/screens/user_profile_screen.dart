import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/presentation/widgets/user_prof_screen_header_skeleton.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/user_profile_screen_header.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late final UserModel? _authenticatedUser;

  @override
  void initState() {
    super.initState();

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.fetchUserChipsStream(_authenticatedUser!.username);

    if (widget.arguments != null) {
      String postedBy = widget.arguments!["postedBy"];

      BlocProvider.of<UserCubit>(context).fetchUserByUsername(postedBy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onTap: () => NavigationService.goBack(),
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

            // // your chips
            // Padding(
            //   padding: EdgeInsets.only(bottom: 10.h),
            //   child: Text(
            //     "Your Chips",
            //     style: Theme.of(context).textTheme.headlineSmall,
            //   ),
            // ),

            // // user chips list
            // BlocBuilder<UserCubit, UserState>(
            //   builder: (context, state) {
            //     if (state is UserChipsStreamFetched) {
            //       return StreamBuilder(
            //         stream: state.userChipsStream,
            //         builder: (context, snapshot) {
            //           if (snapshot.connectionState == ConnectionState.waiting) {
            //             return Expanded(
            //               child: ListView.builder(
            //                 itemCount: 9,
            //                 itemBuilder: (context, index) =>
            //                     const ChipTileSkeleton(),
            //               ),
            //             );
            //           } else if (snapshot.hasError) {
            //             return SelectableText(snapshot.error.toString());
            //           } else if (snapshot.data?.isEmpty ?? true) {
            //             return Column(
            //               mainAxisSize: MainAxisSize.min,
            //               children: [
            //                 Lottie.asset(
            //                   AssetPaths.ghostEmptyAnimationPath,
            //                   width: 234.w,
            //                   frameRate: FrameRate.max,
            //                 ),
            //                 Padding(
            //                   padding: EdgeInsets.only(top: 10.h),
            //                   child: Text(
            //                     "You haven't posted any chips yet.",
            //                     style: Theme.of(context).textTheme.labelSmall,
            //                     textAlign: TextAlign.center,
            //                   ),
            //                 ),
            //               ],
            //             );
            //           } else if (snapshot.hasData) {
            //             return Expanded(
            //               child: RefreshIndicator(
            //                 backgroundColor:
            //                     Theme.of(context).colorScheme.surface,
            //                 onRefresh: () async {
            //                   BlocProvider.of<UserCubit>(context)
            //                       .fetchUserChipsStream(
            //                           _authenticatedUser!.username);
            //                 },
            //                 child: ListView.builder(
            //                   itemCount: snapshot.data!.length,
            //                   itemBuilder: (context, index) {
            //                     List<ChipModel> userChipsList = snapshot.data!;
            //                     ChipModel chip = userChipsList[index];
            //                     return Padding(
            //                       padding: EdgeInsets.only(bottom: 10.8.h),
            //                       child: ChipTile(
            //                         chipData: chip,
            //                         currentUser: _authenticatedUser!,
            //                         onTap: () => NavigationService.routeToNamed(
            //                           '/view-chip',
            //                           arguments: {"chipData": chip},
            //                         ),
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               ),
            //             );
            //           } else {
            //             return const Text("woops, something went wrong...");
            //           }
            //         },
            //       );
            //     } else if (state is FetchingUserChips) {
            //       return const Text("fetching...");
            //     } else {
            //       return Text("chips not fetched. state: $state");
            //     }
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
