import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/shared_pref_cubit/cubit/shared_pref_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/chip_image_tile.dart';
import 'package:development/presentation/widgets/chip_tile.dart';
import 'package:development/presentation/widgets/chip_tile_skeleton.dart';
import 'package:development/presentation/widgets/custom_preference_chip.dart';
import 'package:development/presentation/widgets/user_interests_list.dart';
import 'package:development/services/branch_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../widgets/top_contributors_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.searchController});

  final TextEditingController? searchController;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final UserModel? _authenticatedUser;
  late Map<String, dynamic> _filters;
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = widget.searchController ?? TextEditingController();

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    BlocProvider.of<UserCubit>(context).fetchTopContributors();

    SharedPrefCubit sharedPrefCubit = BlocProvider.of<SharedPrefCubit>(context);
    sharedPrefCubit.getData();

    // BranchService().listenDynamicLinks();
    // BranchService().initDeepLinkData();
  }

  Future<void> _handleRefresh() async {
    BlocProvider.of<ChipBloc>(context).add(FetchChipsStream(filters: _filters));
    _searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    print('home built');

    return BlocListener<SharedPrefCubit, SharedPrefState>(
      listener: (context, state) {
        if (state is SharedPrefDataGet) {
          _filters = state.data;

          BlocProvider.of<ChipBloc>(context)
              .add(FetchChipsStream(filters: _filters));
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).colorScheme.surface,
          onRefresh: () => _handleRefresh(),
          child: BlocBuilder<ChipBloc, ChipState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //
                  if (state is ChipsStreamLoaded)
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        // Add 2 for the TopContributorsSection and UserInterests widgets
                        itemCount: state.chips.length + 2,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return UserInterests(
                              authenticatedUser: _authenticatedUser!,
                            );
                          }
                          if (index == 1) {
                            // render the TopContributorsSection widget at the first position
                            return const TopContributorsSection();
                          } else {
                            // render the remaining items normally after the TopContributorsSection
                            List<ChipModel> chipData = state.chips;
                            ChipModel chipObject = chipData[index - 2];

                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.8.h),
                              child: (chipObject.imageUrl == '')
                                  ? ChipTile(
                                      chipData: chipObject,
                                      currentUser: _authenticatedUser!,
                                    )
                                  : ChipImageTile(
                                      chipData: chipObject,
                                      currentUser: _authenticatedUser!,
                                    ),
                            );
                          }
                        },
                      ),
                    ),

                  if (state is ChipsLoaded)
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: state.chips.isEmpty
                            ? state.chips.length + 3
                            : state.chips.length + 2,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return UserInterests(
                              authenticatedUser: _authenticatedUser!,
                            );
                          }
                          if (index == 1) {
                            // render the TopContributorsSection widget at the first position
                            return const TopContributorsSection();
                          }

                          if (index == 2 && state.chips.isEmpty) {
                            return _buildEmptyGraphic(context);
                          }

                          List<ChipModel> chipData = state.chips;
                          var chipObject = chipData[index - 2];

                          return (state is ChipsLoading)
                              ? const ChipTileSkeleton()
                              : Padding(
                                  padding: EdgeInsets.only(bottom: 10.8.h),
                                  child: (chipObject.imageUrl == '')
                                      ? ChipTile(
                                          chipData: chipObject,
                                          currentUser: _authenticatedUser!,
                                        )
                                      : ChipImageTile(
                                          chipData: chipObject,
                                          currentUser: _authenticatedUser!,
                                        ),
                                );
                        },
                      ),
                    ),

                  if (state is ChipsLoading)
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return UserInterests(
                              authenticatedUser: _authenticatedUser!,
                            );
                          }
                          if (index == 1) {
                            // render the TopContributorsSection widget at the first position
                            return const TopContributorsSection();
                          }

                          return const ChipTileSkeleton();
                        },
                      ),
                    ),

                  if (state is ChipError)
                    Center(
                      child: Text(state.errorMsg),
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyGraphic(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Lottie.asset(
            AssetPaths.ghostEmptyAnimationPath,
            frameRate: FrameRate.max,
            repeat: false,
            animate: false,
            width: 300,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'OOPS! NO CHIPS FOUND',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
