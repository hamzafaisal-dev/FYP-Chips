import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/custom_colors.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/data/networks/user_network.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class LikeScreen extends StatefulWidget {
  const LikeScreen({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
  @override
  void initState() {
    List<String> userNames = widget.arguments?['likedBy'];

    BlocProvider.of<UserCubit>(context).fetchUsersByUsernames(userNames);

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      print(isAllowed);

      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'LIKES',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
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

        actions: [
          IconButton(
            onPressed: () async {
              print('pressed');

              await UserNetwork().getTopContributors();
            },
            icon: Icon(Icons.abc),
          )
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UsersLoadedState) {
            return Column(
              children: [
                //
                Divider(
                  height: 10,
                  thickness: 1,
                  color: Theme.of(context).colorScheme.surface,
                ),

                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      UserModel user = state.users[index];

                      return Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Theme.of(context).colorScheme.surface,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: ListTile(
                          horizontalTitleGap: 0,
                          tileColor: CustomColors.weirdWhite,
                          leading: CircleAvatar(
                            radius: 40.r,
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: ClipOval(
                              child: SvgPicture.network(
                                user.profilePictureUrl,
                                height: 57.h,
                                width: 57.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            user.username,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('@${user.name}'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          if (state is UserErrorState) {
            return Center(child: Text(state.errorMessage));
          }

          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 9,
            itemBuilder: (context, index) {
              return _buildLikeSkeleton(context);
            },
          );
        },
      ),
    );
  }
}

Widget _buildLikeSkeleton(BuildContext context) {
  return Column(
    children: [
      //
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 1.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //
              CircleAvatar(
                radius: 32.r,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),

              SizedBox(width: 8.w),

              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          height: 20,
                          width: 110,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          height: 20,
                          width: 80,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
