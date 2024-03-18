import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/chip_tile.dart';
import 'package:development/presentation/widgets/chip_tile_skeleton.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/user_profile_screen_header.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

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

    // fetch user chips stream
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.fetchUserChipsStream(_authenticatedUser!.username);
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
          padding: EdgeInsets.fromLTRB(20.w, 0.h, 0.w, 0.w),
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomIconButton(
              iconSvgPath: AssetPaths.leftArrowIconPath,
              iconWidth: 16.w,
              iconHeight: 16.h,
              onTap: () => Navigator.of(context).pop(),
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
              child: UserProfileScreenHeader(
                authenticatedUser: _authenticatedUser,
              ),
            ),

            // your chips
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Text(
                "Your Chips",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),

            // user chips list
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserChipsStreamFetched) {
                  return StreamBuilder(
                    stream: state.userChipsStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: 9,
                            itemBuilder: (context, index) => ChipTileSkeleton(),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return SelectableText(snapshot.error.toString());
                      } else if (snapshot.data?.isEmpty ?? true) {
                        return const Text("much empty, such wow");
                      } else if (snapshot.hasData) {
                        return Expanded(
                          child: RefreshIndicator(
                            backgroundColor:
                                Theme.of(context).colorScheme.surface,
                            onRefresh: () async {
                              BlocProvider.of<UserCubit>(context)
                                  .fetchUserChipsStream(
                                      _authenticatedUser!.username);
                            },
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                List<ChipModel> userChipsList = snapshot.data!;
                                ChipModel chip = userChipsList[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10.8.h),
                                  child: ChipTile(
                                    chipData: chip,
                                    onTap: () => NavigationService.routeToNamed(
                                      '/view-chip',
                                      arguments: {"chipData": chip},
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return const Text("something went wrong");
                      }
                    },
                  );
                } else if (state is FetchingUserChips) {
                  return const Text("fetching...");
                } else {
                  return Text("chips not fetched. state: $state");
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
