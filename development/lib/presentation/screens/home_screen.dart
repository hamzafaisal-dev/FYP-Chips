import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/chip_tile.dart';
import 'package:development/presentation/widgets/chip_tile_skeleton.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/top_contributor_card.dart';
import '../widgets/top_contributors_section.dart';

List<String> jobModes = ['On-site', 'Hybrid', 'Remote'];
List<String> jobTypes = [
  'Internship',
  'Management Trainee',
  'Contract',
  'Entry-Level',
  'Mid-Level',
  'Senior',
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final UserModel? _authenticatedUser;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    ChipBloc chipBloc = BlocProvider.of<ChipBloc>(context);
    chipBloc.add(const FetchChipsStream());
  }

  Future<void> _handleRefresh() async {
    BlocProvider.of<ChipBloc>(context).add(const FetchChipsStream());
    _searchController.text = '';
  }

  void _handleFilterClick() {
    showModalBottomSheet(
      context: context,
      // showDragHandle: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 8, 8),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Filter
                Text(
                  'Filter',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 22.sp,
                      ),
                ),

                SizedBox(height: 18.h),

                // Job Type
                Text(
                  'Job Type',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      ),
                ),

                SizedBox(height: 8.h),

                Wrap(
                  children: [
                    ...jobModes.map(
                      (jobMode) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Chip(
                          label: Text(jobMode),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Job Mode
                Text(
                  'Job Mode',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      ),
                ),

                SizedBox(height: 8.h),

                Wrap(
                  children: [
                    ...jobTypes.map(
                      (jobType) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Chip(
                          label: Text(jobType),
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: RefreshIndicator(
        backgroundColor: Theme.of(context).colorScheme.surface,
        onRefresh: () => _handleRefresh(),
        child: BlocBuilder<ChipBloc, ChipState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),

                // hey, user name
                RichText(
                  text: TextSpan(
                    text: 'Hello, ',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 36.sp,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        // text: 'Farhan Mushi',
                        text: _authenticatedUser?.name ?? 'John Doe',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 36.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ],
                  ),
                ),

                // here are some chips for you
                RichText(
                  text: TextSpan(
                    text: 'Here are some ',
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

                // top contributors
                TopContributorsSection(authenticatedUser: _authenticatedUser),

                SizedBox(height: 16.h),

                // search bar
                Stack(
                  children: [
                    //
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextFormField(
                        controller: _searchController,
                        onTapOutside: (event) =>
                            FocusScope.of(context).unfocus(),
                        onFieldSubmitted: (value) {
                          if (value.isNotEmpty) {
                            BlocProvider.of<ChipBloc>(context).add(
                              FetchChips(searchText: value),
                            );
                          }
                        },
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
                    ),

                    Positioned(
                      top: 5,
                      bottom: 5,
                      right: 7,
                      child: InkWell(
                        onTap: _handleFilterClick,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.filter_list),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 23.4.h),

                if (state is ChipsStreamLoaded)
                  StreamBuilder(
                    stream: state.chips,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) =>
                                const ChipTileSkeleton(),
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
                        );
                      }
                      return const SizedBox();
                    },
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
                      itemBuilder: (context, index) => const ChipTileSkeleton(),
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
    );
  }
}
