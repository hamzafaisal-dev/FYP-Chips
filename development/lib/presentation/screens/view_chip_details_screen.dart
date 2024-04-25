import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/shared_pref_cubit/cubit/shared_pref_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/bookmark_icon.dart';
import 'package:development/presentation/widgets/buttons/mark_applied_button.dart';
import 'package:development/presentation/widgets/chip_image_container2.dart';
import 'package:development/presentation/widgets/comment_box.dart';
import 'package:development/presentation/widgets/comments_section.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/services/navigation_service.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  ChipModel? _chipData;

  String? _chipId;

  bool _isEditable = false;
  bool _isDeletable = false;

  bool _isInitiallyMarkedApplied = false;

  late bool isApplied;
  bool _commentAutoFocused = false;

  late Map<String, dynamic> _filters;

  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    print('inited');

    super.initState();

    BlocProvider.of<SharedPrefCubit>(context).getData();

    if (widget.arguments != null) {
      if (widget.arguments!["chipData"] == null) {
        _chipId = widget.arguments!["chipId"];

        BlocProvider.of<ChipBloc>(context)
            .add(FetchChipByIdEvent(chipId: _chipId!));
      } else {
        _chipData = widget.arguments!["chipData"];

        _commentAutoFocused = widget.arguments?["commentFocus"] ?? false;
      }
    }

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    // if user has posted the current chip, the chip becomes editable
    if (_authenticatedUser.postedChips.contains(_chipId ?? _chipData?.chipId)) {
      _isEditable = true;
      _isDeletable = true;
    }

    if (_authenticatedUser.favoritedChips
        .contains(_chipId ?? _chipData?.chipId)) {
      _isInitiallyMarkedApplied = true;
    }

    isApplied = _isInitiallyMarkedApplied;

    Helpers.logEvent(
      _authenticatedUser.userId,
      "view-chip",
      [_chipData?.chipId ?? _chipId ?? 'n/a'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SharedPrefCubit, SharedPrefState>(
      listener: (context, state) {
        if (state is SharedPrefDataGet) {
          _filters = state.data;
        }
      },
      builder: (context, state) {
        return BlocConsumer<ChipBloc, ChipState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is IndividualChipLoaded) _chipData = state.chip;

            if (widget.arguments!["chipData"] != null) {
              _chipData = widget.arguments!["chipData"];

              return _buildViewScreen(
                context,
                _chipData!,
                _isDeletable,
                _isEditable,
                _authenticatedUser,
                _commentController,
                _commentAutoFocused,
              );
            }

            if (state is IndividualChipLoaded) {
              print(state.chip!.companyName);

              print('_filters are $_filters');

              return _buildViewScreen(
                context,
                _chipData,
                _isDeletable,
                _isEditable,
                _authenticatedUser,
                _commentController,
                _commentAutoFocused,
              );
            }

            // lawd in high heaven above, pls forgive me for this godforsaken jugaar. we goin to pRodUciTioN in 2 days
            if (state is ChipsStreamLoaded) {
              return _buildViewScreen(
                context,
                _chipData,
                _isDeletable,
                _isEditable,
                _authenticatedUser,
                _commentController,
                _commentAutoFocused,
              );
            }

            if (state is ChipError) {
              return Scaffold(body: Center(child: Text(state.errorMsg)));
            }

            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}

Widget _buildInfoThing(
    BuildContext context, String leadingText, String tileText, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      //
      Text(
        leadingText,
        style: Theme.of(context).textTheme.bodyLarge,
      ),

      const SizedBox(width: 4),

      Container(
        width: tileText.length >= 45
            ? MediaQuery.of(context).size.width * 0.55
            : null,
        padding: const EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          tileText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.surface,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    ],
  );
}

Widget _buildViewScreen(
  BuildContext context,
  ChipModel? chipData,
  bool isDeletable,
  bool isEditable,
  UserModel authenticatedUser,
  TextEditingController commentController,
  bool commentAutoFocused,
) {
  return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(12.w, 14.h, 12.w, 14.h),
        child: chipData == null
            ? const Center(child: Text('Looks like this chip has been deleted'))
            : ListView(
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
                          if (state is ChipDeleteSuccess) {
                            // event fired to emit updated user in app
                            BlocProvider.of<AuthCubit>(context)
                                .userUpdated(state.updatedUser);

                            // NavigationService.routeToReplacementNamed('/layout');
                            NavigationService.goBack();

                            HelperWidgets.showSnackbar(
                              context,
                              'Chip deleted successfully!🍟',
                              'success',
                            );
                          }

                          if (state is ChipDeletingState) {
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
                                  chipId: chipData.chipId,
                                  currentUser: authenticatedUser,
                                ),
                              );
                            }
                          },
                          itemBuilder: (BuildContext context) => [
                            if (isDeletable)
                              const PopupMenuItem<String>(
                                value: '1',
                                child: Text('Delete'),
                              ),
                            if (!isDeletable)
                              const PopupMenuItem<String>(
                                value: '2',
                                child: Text('Report Chip'),
                              ),
                          ],
                          icon: const Icon(Icons.more_horiz),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  // chip title + bookmark icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      Flexible(
                        child: Text(
                          chipData.jobTitle,
                          style: Theme.of(context).textTheme.headlineMedium,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      SizedBox(width: 10.w),

                      Row(
                        children: [
                          // bookmark icon
                          CustomBookmarkButton(
                            iconSize: 28.sp,
                            radius: 22.r,
                            currentChip: chipData,
                          ),

                          if (isEditable) SizedBox(width: 10.w),

                          if (isEditable)
                            CustomIconButton(
                              iconSvgPath: AssetPaths.editIconPath,
                              iconWidth: 22.w,
                              iconHeight: 22.h,
                              onTap: () {
                                NavigationService.routeToReplacementNamed(
                                  '/add-chip2',
                                  arguments: {
                                    "routeName": "/viewDetails",
                                    "chipData": chipData
                                  },
                                );
                              },
                            ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  // Posted By + Posted Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      Row(
                        children: [
                          //
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //
                              RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.bodyLarge,
                                  children: [
                                    const TextSpan(
                                      text: 'Posted By: ',
                                    ),
                                    TextSpan(
                                      text: chipData.postedBy,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),

                      Text(
                        Helpers.formatTimeAgo(chipData.createdAt.toString()),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  // Apply Here + Copy to clipboard
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      Row(
                        children: [
                          //
                          _buildInfoThing(
                            context,
                            'Apply Here: ',
                            chipData.applicationLink,
                            Colors.greenAccent,
                          ),
                        ],
                      ),

                      IconButton(
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        onPressed: () {
                          Clipboard.setData(
                                  ClipboardData(text: chipData.applicationLink))
                              .then((_) {
                            HelperWidgets.showSnackbar(
                                context, 'Copied to clipboard!', 'success');
                          });
                        },
                        icon: Icon(Icons.copy, size: 22.sp),
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  // Company Name
                  Row(
                    children: [
                      //
                      _buildInfoThing(
                        context,
                        'Employer Name: ',
                        chipData.companyName,
                        Colors.lightBlueAccent,
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  // Deadline
                  Row(
                    children: [
                      //
                      _buildInfoThing(
                        context,
                        'Last Date To Apply:',
                        Helpers.formatDateTimeString(
                            chipData.deadline.toString()),
                        Colors.lightBlueAccent,
                      ),
                    ],
                  ),

                  SizedBox(height: 14.h),

                  Text(
                    'Chip Details',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .copyWith(fontSize: 23.sp),
                  ),

                  Text(
                    chipData.description ?? 'No description available',
                    style: TextStyle(fontSize: 16.sp),
                  ),

                  SizedBox(height: 14.h),

                  if (chipData.imageUrl != null && chipData.imageUrl != '')
                    ChipNetworkImageContainer(imageUrl: chipData.imageUrl!),

                  SizedBox(height: 14.h),

                  MarkAppliedButton(chipId: chipData.chipId),

                  SizedBox(height: 14.h),

                  Material(
                    elevation: 2,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    color: Colors.white,
                    child: Divider(height: 1.h, color: Colors.white),
                  ),

                  SizedBox(height: 14.h),

                  CommentsSection(chip: chipData),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ],
              ),
      ),
    ),
    floatingActionButton: CommentBox(
      commentAutoFocused: commentAutoFocused,
      commentController: commentController,
      chipData: chipData,
      authenticatedUser: authenticatedUser,
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
  );
}
