import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/shared_pref_cubit/cubit/shared_pref_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/custom_filter_chip.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

List<String> jobModes = ['On-site', 'Hybrid', 'Remote'];

List<String> jobTypes = [
  'Internship',
  'Management Trainee',
  'Contract',
  'Entry-Level',
  'Mid-Level',
  'Senior',
];

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, required this.searchController});

  final TextEditingController searchController;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late Map<String, dynamic> _filters;
  late final UserModel? _authenticatedUser;

  List<String> _selectedJobModes = [];
  List<String> _selectedJobTypes = [];

  IconData leadingIcon = Icons.search;

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

                        // log event
                        Helpers.logEvent(
                          _authenticatedUser!.userId,
                          "apply-filters",
                          [_filters],
                        );
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
  void initState() {
    _filters = {"jobModes": <String>[], "jobTypes": <String>[]};

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //
        Container(
          height: 40,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextFormField(
            controller: widget.searchController,
            maxLength: 20,
            // gets rid of maxLength counter under text fields
            buildCounter: (
              context, {
              required currentLength,
              maxLength,
              required isFocused,
            }) =>
                null,
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            onChanged: (value) {
              if (value.isNotEmpty) {
                setState(() => leadingIcon = Icons.close);
              } else {
                setState(() => leadingIcon = Icons.search);
              }
            },
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                // log event
                Helpers.logEvent(
                  _authenticatedUser!.userId,
                  "search-chips",
                  [value],
                );
              }
              BlocProvider.of<ChipBloc>(context).add(
                FetchChips(searchText: value),
              );
              BlocProvider.of<ChipBloc>(context).add(
                FetchChips(searchText: value),
              );
            },
            decoration: InputDecoration(
              fillColor: Colors.white,
              hintText: 'Search',
              hintStyle: Theme.of(context).textTheme.bodyLarge,
              prefixIcon: InkWell(
                onTap: () {
                  if (widget.searchController.text != '') {
                    widget.searchController.clear();

                    BlocProvider.of<ChipBloc>(context)
                        .add(FetchChipsStream(filters: _filters));

                    setState(() => leadingIcon = Icons.search);
                  }
                },
                child: Icon(
                  leadingIcon,
                  size: 20.w,
                ),
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
              width: 32,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.tertiary,
                border: Border.all(color: Colors.transparent),
                borderRadius: BorderRadius.circular(8),
              ),
              child: SvgPicture.asset(
                AssetPaths.filterIconPath,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
