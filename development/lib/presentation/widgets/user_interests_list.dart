import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/cubits/shared_pref_cubit/cubit/shared_pref_cubit.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/custom_preference_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserInterests extends StatefulWidget {
  const UserInterests({
    super.key,
    required this.authenticatedUser,
  });

  final UserModel authenticatedUser;

  @override
  State<UserInterests> createState() => _UserInterestsState();
}

class _UserInterestsState extends State<UserInterests> {
  late Map<String, dynamic> _filters;

  final List<String> _interests = [];

  void _handleInterestClick(String interest) {
    setState(() {
      if (_interests.contains(interest)) {
        _interests.remove(interest);
      } else {
        if (_interests.isNotEmpty) {
          _interests[0] = interest;
        } else {
          _interests.add(interest);
        }
      }
    });

    if (_interests.isNotEmpty) {
      BlocProvider.of<ChipBloc>(context).add(
        FetchChips(searchText: _interests[0].toLowerCase()),
      );
    } else {
      print('filters are $_filters');

      BlocProvider.of<ChipBloc>(context)
          .add(FetchChipsStream(filters: _filters));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedPrefCubit, SharedPrefState>(
      builder: (context, state) {
        if (state is SharedPrefDataGet) {
          _filters = state.data;
        }

        return Padding(
          padding: const EdgeInsets.fromLTRB(10, 16, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Row(
                children: [
                  //
                  Text(
                    'Your Interests',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 19.sp,
                        ),
                  ),

                  const SizedBox(width: 5),

                  const Tooltip(
                    triggerMode: TooltipTriggerMode.tap,
                    message: 'Select an interest to filter posts',
                    child: Icon(Icons.info, size: 20),
                  )
                ],
              ),

              SizedBox(height: 7.h),

              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.authenticatedUser.skills?.length ?? 0,
                  itemBuilder: (context, index) {
                    String interest =
                        widget.authenticatedUser.skills?[index] ?? '';

                    return PreferenceChip(
                      chipLabel: interest,
                      selectedChips: _interests,
                      onPressed: (interest) => _handleInterestClick(interest),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
