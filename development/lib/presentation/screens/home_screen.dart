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
import 'package:development/presentation/widgets/search_bar.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/services/notification_service.dart';
import 'package:flutter/material.dart';
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
  }

  Future<void> _handleRefresh() async {
    BlocProvider.of<ChipBloc>(context).add(FetchChipsStream(filters: _filters));
    _searchController.text = '';
  }

  @override
  Widget build(BuildContext context) {
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
                  // SizedBox(height: 16.h),

                  // // hey, user name
                  // RichText(
                  //   text: TextSpan(
                  //     text: 'Hello, ',
                  //     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //           fontWeight: FontWeight.w700,
                  //           fontSize: 36.sp,
                  //         ),
                  //     children: <TextSpan>[
                  //       TextSpan(
                  //         // text: 'Farhan Mushi',
                  //         text: _authenticatedUser?.name ?? 'John Doe',
                  //         style:
                  //             Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //                   fontWeight: FontWeight.w700,
                  //                   fontSize: 36.sp,
                  //                   color: Theme.of(context).primaryColor,
                  //                 ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // // here are some chips for you
                  // RichText(
                  //   text: TextSpan(
                  //     text: 'Here are some ',
                  //     style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //           fontWeight: FontWeight.w400,
                  //           fontSize: 18.sp,
                  //         ),
                  //     children: [
                  //       TextSpan(
                  //         text: 'Chips',
                  //         style:
                  //             Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //                   fontWeight: FontWeight.w700,
                  //                   fontSize: 18.sp,
                  //                 ),
                  //       ),
                  //       TextSpan(
                  //         text: ' for you',
                  //         style:
                  //             Theme.of(context).textTheme.bodyLarge?.copyWith(
                  //                   fontWeight: FontWeight.w400,
                  //                   fontSize: 18.sp,
                  //                 ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  // SizedBox(height: 23.4.h),

                  // // top contributors
                  // TopContributorsSection(authenticatedUser: _authenticatedUser),

                  // SizedBox(height: 16.h),

                  // SizedBox(height: 23.4.h),

                  if (state is ChipsStreamLoaded)
                    (state.chips.isEmpty)
                        ? const Center(
                            child: Text(
                              'khaali hai bey',
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              // Add 1 for the TopContributorsSection widget
                              itemCount: state.chips.length + 1,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  // Render the TopContributorsSection widget at the first position
                                  return const TopContributorsSection();
                                } else {
                                  // Render the remaining items normally after the TopContributorsSection
                                  List<ChipModel> chipData = state.chips;
                                  ChipModel chipObject = chipData[index - 1];

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
                    if (state.chips.isEmpty)
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            //
                            const SizedBox(height: 140),

                            Lottie.asset(
                              AssetPaths.ghostEmptyAnimationPath,
                              frameRate: FrameRate.max,
                              repeat: false,
                              animate: false,
                              width: 300,
                            ),

                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Text(
                                'OOPS! NO CHIPS FOUND',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: state.chips.length,
                          itemBuilder: (context, index) {
                            List<ChipModel> chipData = state.chips;
                            var chipObject = chipData[index];

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
                          },
                        ),
                      ),

                  if (state is ChipsLoading)
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 10,
                        itemBuilder: (context, index) =>
                            const ChipTileSkeleton(),
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
}
