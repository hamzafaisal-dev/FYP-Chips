import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/comment/comment_cubit.dart';
import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/presentation/widgets/bookmark_icon.dart';
import 'package:development/presentation/widgets/buttons/mark_applied_button.dart';
import 'package:development/presentation/widgets/chip_image_container2.dart';
import 'package:development/presentation/widgets/comment_box.dart';
import 'package:development/presentation/widgets/comment_tile.dart';
import 'package:development/presentation/widgets/comments_section.dart';
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
  ChipModel? _chipData;

  String? _chipId;

  bool _isEditable = false;
  bool _isDeletable = false;

  bool _isInitiallyMarkedApplied = false;

  late bool isApplied;
  bool _commentAutoFocused = false;

  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();

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
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChipBloc, ChipState>(
      listener: (context, state) {
        if (state is IndividualChipLoaded) _chipData = state.chip;
      },
      builder: (context, state) {
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
          return PopScope(
            onPopInvoked: (didPop) {
              // have to fix the filters thing here later
              BlocProvider.of<ChipBloc>(context)
                  .add(const FetchChipsStream(filters: {}));
            },
            child: _buildViewScreen(
                context,
                _chipData,
                _isDeletable,
                _isEditable,
                _authenticatedUser,
                _commentController,
                _commentAutoFocused),
          );
        } else if (state is ChipError) {
          return Scaffold(body: Center(child: Text(state.errorMsg)));
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
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
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
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

                  const SizedBox(height: 14),

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

                      const SizedBox(width: 10),

                      Row(
                        children: [
                          // bookmark icon
                          CustomBookmarkButton(
                            iconSize: 28,
                            radius: 22,
                            currentChip: chipData,
                          ),

                          if (isEditable) const SizedBox(width: 10),

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

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //
                      Text(
                        'Posted By: ${chipData.postedBy}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),

                      Text(
                        Helpers.formatTimeAgo(chipData.createdAt.toString()),
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

                  Text(chipData.description ?? 'No description available'),

                  const SizedBox(height: 14),

                  if (chipData.imageUrl != null && chipData.imageUrl != '')
                    ChipNetworkImageContainer(imageUrl: chipData.imageUrl!),

                  const SizedBox(height: 14),

                  MarkAppliedButton(chipId: chipData.chipId),

                  const SizedBox(height: 14),

                  const Divider(height: 3, color: Colors.white),

                  const SizedBox(height: 14),

                  CommentsSection(chip: chipData),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
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
