import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/chip_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class UserChipsScreen extends StatefulWidget {
  const UserChipsScreen({Key? key}) : super(key: key);

  @override
  State<UserChipsScreen> createState() => _UserChipsScreenState();
}

class _UserChipsScreenState extends State<UserChipsScreen>
    with SingleTickerProviderStateMixin {
  late final UserModel? _authenticatedUser;
  late TabController _tabController;

  @override
  void initState() {
    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.fetchUserChips(_authenticatedUser!.favoritedChips);

    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabSelection);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    UserCubit userCubit = BlocProvider.of<UserCubit>(context);

    int currentIndex = _tabController.index;

    switch (currentIndex) {
      case 0:
        userCubit.fetchUserChips(_authenticatedUser!.favoritedChips);
        break;
      case 1:
        userCubit.fetchUserChips(_authenticatedUser!.postedChips);
        break;
      case 2:
        userCubit.fetchUserChips(_authenticatedUser!.appliedChips);
        break;
      default:
        userCubit.fetchUserChips(_authenticatedUser!.favoritedChips);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Chips"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              icon: Icon(Icons.bookmark),
              text: "Saved",
            ),
            Tab(
              icon: Icon(Icons.post_add),
              text: "Posted",
            ),
            Tab(
              icon: Icon(Icons.apple),
              text: "Applied",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          //
          _buildListView(),

          _buildListView(),

          _buildListView(),
        ],
      ),
    );
  }

  Widget _buildListView() {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserChipsFetched) {
          List<ChipModel> usersChips = state.userChips;

          if (usersChips.isEmpty) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  AssetPaths.girlEmptyBoxAnimationPath,
                  frameRate: FrameRate.max,
                  width: 270.w,
                ),
                SizedBox(height: 20.h),
                Text(
                  "No favorite chips yet!",
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          }

          return ListView.builder(
            itemCount: usersChips.length,
            padding: const EdgeInsets.only(top: 10),
            itemBuilder: (context, index) {
              ChipModel chipData = usersChips[index];

              return ChipTile(
                chipData: chipData,
                currentUser: _authenticatedUser!,
              );
            },
          );
        } else if (state is UserErrorState) {
          return Center(child: Text(state.errorMessage));
        }

        return const CircularProgressIndicator();
      },
    );
  }
}
