import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/constants/custom_colors.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/chip_tile.dart';
import 'package:development/presentation/widgets/chip_tile_skeleton.dart';
import 'package:development/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AppliedChipScreen extends StatefulWidget {
  const AppliedChipScreen({super.key});

  @override
  State<AppliedChipScreen> createState() => _AppliedChipScreenState();
}

class _AppliedChipScreenState extends State<AppliedChipScreen> {
  late final UserModel? _authenticatedUser;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    userCubit.fetchUserChips(_authenticatedUser!.appliedChips);
  }

  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
        firstDate: DateTime(2024),
        lastDate: DateTime.now());

    if (picked != null) {
      setState(() {
        _startDate = picked.start;
        _endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applied Chips'),
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
              onTap: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            //
            Padding(
              padding: EdgeInsets.only(top: 15.h, bottom: 10.h),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: TextFormField(
                  controller: _searchController,
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
            ),

            SizedBox(height: 16.4.h),

            ElevatedButton(
              onPressed: () {
                _selectDateRange(context);
              },
              child: Text(
                'Select Date Range',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: CustomColors.mustard,
                    ),
              ),
            ),

            SizedBox(height: 23.4.h),

            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                print(state);

                if (state is UserChipsFetched) {
                  List<ChipModel> usersAppliedChips = state.userChips;

                  if (usersAppliedChips.isEmpty) {
                    // Animation if no favorite chips
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //
                        Lottie.asset(
                          AssetPaths.appliedEmptyAnimation,
                          frameRate: FrameRate(420),
                          width: 270.w,
                        ),

                        SizedBox(height: 20.h),

                        Text(
                          "No applied chips yet!",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: usersAppliedChips.length,
                      itemBuilder: (context, index) {
                        ChipModel chipData = usersAppliedChips[index];

                        return ChipTile(
                          chipData: chipData,
                          onTap: () => NavigationService.routeToNamed(
                            '/view-chip',
                            arguments: {"chipData": chipData},
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is UserErrorState) {
                  return Center(child: Text(state.errorMessage));
                }

                return const CustomCircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
