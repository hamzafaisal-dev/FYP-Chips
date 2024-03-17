import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/bookmark_icon.dart';
import 'package:development/presentation/widgets/chip_image_container2.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipDetailsScreen extends StatefulWidget {
  const ChipDetailsScreen({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  State<ChipDetailsScreen> createState() => _ChipDetailsScreenState();
}

class _ChipDetailsScreenState extends State<ChipDetailsScreen> {
  late UserModel _authenticatedUser;
  late ChipModel _chipData;

  bool _isEditable = false;

  @override
  void initState() {
    super.initState();

    if (widget.arguments != null) {
      _chipData = widget.arguments!["chipData"];
    }

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    // if user has posted the current chip, the chip becomes editable
    if (_authenticatedUser.postedChips.contains(_chipData.chipId)) {
      _isEditable = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          child: ListView(
            children: [
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  CustomIconButton(
                    iconSvgPath: AssetPaths.leftArrowIconPath,
                    iconWidth: 16.w,
                    iconHeight: 16.h,
                    onTap: () => Navigator.of(context).pop(),
                  ),

                  BlocListener<ChipBloc, ChipState>(
                    listener: (context, state) {
                      if (state is ChipSuccess) {
                        // Navigator.pop(context);

                        NavigationService.routeToReplacementNamed('/layout');

                        HelperWidgets.showSnackbar(
                            context, 'Chip deleted successfully', 'success');
                      }

                      if (state is ChipsLoading) {
                        HelperWidgets.showSnackbar(
                          context,
                          'Deleting chip...',
                          'info',
                        );
                      }

                      if (state is ChipError) {
                        HelperWidgets.showSnackbar(
                          context,
                          state.errorMsg,
                          'error',
                        );
                      }
                    },
                    child: PopupMenuButton<String>(
                      onSelected: (String value) {
                        if (value == '1') {
                          BlocProvider.of<ChipBloc>(context).add(
                            DeleteChipEvent(
                              chipId: _chipData.chipId,
                              currentUser: _authenticatedUser,
                            ),
                          );
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: '1',
                          child: Text('Delete'),
                        ),
                      ],
                      icon: const Icon(Icons.more_horiz),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Flexible(
                    child: Text(
                      _chipData.jobTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(width: 10),

                  // bookmark icon
                  CustomBookmarkIcon(
                    iconSize: 28,
                    radius: 22,
                    chipId: _chipData.chipId,
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Text(
                    'Posted By: ${_chipData.postedBy}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  Text(
                    Helpers.formatTimeAgo(_chipData.createdAt.toString()),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Text(
                'Chip Details',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 22),
              ),

              Text(_chipData.description ?? 'No description available'),

              const SizedBox(height: 14),

              if (_chipData.imageUrl != null && _chipData.imageUrl != '')
                ChipNetworkImageContainer(imageUrl: _chipData.imageUrl!),
            ],
          ),
        ),
      ),
      floatingActionButton: _isEditable
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              onPressed: () {
                NavigationService.routeToReplacementNamed(
                  '/add-chip2',
                  arguments: {
                    "routeName": "/viewDetails",
                    "chipData": _chipData,
                  },
                );
              },
              child: const Icon(Icons.edit, size: 28),
            )
          : null,
    );
  }
}
