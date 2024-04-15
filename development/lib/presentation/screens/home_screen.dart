import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/shared_pref_cubit/cubit/shared_pref_cubit.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/chip_tile.dart';
import 'package:development/presentation/widgets/chip_tile_skeleton.dart';
import 'package:development/presentation/widgets/search_bar.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                              itemCount: state.chips.length,
                              itemBuilder: (context, index) {
                                List<ChipModel> chipData = state.chips;
                                ChipModel chipObject = chipData[index];

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10.8.h),
                                  child: ChipTile(
                                    chipData: chipObject,
                                    currentUser: _authenticatedUser!,
                                    onTap: () => NavigationService.routeToNamed(
                                      '/view-chip',
                                      arguments: {"chipData": chipObject},
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                  if (state is ChipsLoaded)
                    if (state.chips.isEmpty)
                      const Center(
                        child: Text('Empty hai'),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.chips.length,
                          itemBuilder: (context, index) {
                            List<ChipModel> chipData = state.chips;
                            var chipObject = chipData[index];

                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.8.h),
                              child: ChipTile(
                                chipData: chipObject,
                                currentUser: _authenticatedUser!,
                                onTap: () => NavigationService.routeToNamed(
                                  '/view-chip',
                                  arguments: {"chipData": chipObject},
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                  if (state is ChipsLoading)
                    Expanded(
                      child: ListView.builder(
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
