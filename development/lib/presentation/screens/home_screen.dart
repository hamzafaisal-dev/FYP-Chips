import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/shared_pref_cubit/cubit/shared_pref_cubit.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/chip_tile.dart';
import 'package:development/presentation/widgets/chip_tile_skeleton.dart';
import 'package:development/presentation/widgets/custom_filter_chip.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late Map<String, dynamic> _filters;
  final _searchController = TextEditingController();

  List<String> _selectedJobModes = [];
  List<String> _selectedJobTypes = [];

  @override
  void initState() {
    super.initState();

    _filters = {
      "jobModes": _selectedJobModes,
      "jobTypes": _selectedJobTypes,
    };

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    ChipBloc chipBloc = BlocProvider.of<ChipBloc>(context);
    chipBloc.add(FetchChipsStream(filters: _filters));

    SharedPrefCubit sharedPrefCubit = BlocProvider.of<SharedPrefCubit>(context);
    sharedPrefCubit.getData();
  }

  void _handleJobModeChipClick(String jobMode) {
    _selectedJobModes.contains(jobMode)
        ? _selectedJobModes.remove(jobMode)
        : _selectedJobModes.add(jobMode);
  }

  void _handleJobTypeChipClick(String jobType) {
    _selectedJobTypes.contains(jobType)
        ? _selectedJobTypes.remove(jobType)
        : _selectedJobTypes.add(jobType);
  }

  Future<void> _handleRefresh() async {
    BlocProvider.of<ChipBloc>(context).add(FetchChipsStream(filters: _filters));
    _searchController.text = '';
  }

  void _handleFilterClick() {
    showModalBottomSheet(
      context: context,
      // showDragHandle: true,
      builder: (context) {
        return BlocConsumer<SharedPrefCubit, SharedPrefState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is SharedPrefDataGet) {
              _selectedJobModes = state.data['jobModes'];
              _selectedJobTypes = state.data['jobTypes'];
            }

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
                        ...jobModes.map(
                          (jobMode) => CustomFilterChip(
                            chipLabel: jobMode,
                            selectedChips: _selectedJobModes,
                            onPressed: (jobMode) =>
                                _handleJobModeChipClick(jobMode),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

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
                        ...jobTypes.map(
                          (jobType) => CustomFilterChip(
                            chipLabel: jobType,
                            selectedChips: _selectedJobTypes,
                            onPressed: (jobType) =>
                                _handleJobTypeChipClick(jobType),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 18.h),

                    FilledButton(
                      onPressed: () async {
                        Navigator.pop(context);

                        _filters['jobModes'] = _selectedJobModes;
                        _filters['jobTypes'] = _selectedJobTypes;

                        BlocProvider.of<SharedPrefCubit>(context)
                            .setData(_filters);

                        BlocProvider.of<ChipBloc>(context)
                            .add(FetchChipsStream(filters: _filters));
                      },
                      child: const Text('Apply Filters'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
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
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18.sp,
                                  ),
                        ),
                        TextSpan(
                          text: ' for you',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
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
