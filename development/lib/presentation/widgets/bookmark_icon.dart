import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBookmarkIcon extends StatefulWidget {
  const CustomBookmarkIcon({
    super.key,
    required this.iconSize,
    required this.currentChip,
    this.radius,
  });

  final double? radius;
  final double iconSize;
  final ChipModel currentChip;

  @override
  State<CustomBookmarkIcon> createState() => _CustomBookmarkIconState();
}

class _CustomBookmarkIconState extends State<CustomBookmarkIcon> {
  late final UserModel? _authenticatedUser;
  bool _isInitiallyBookmarked = false;

  late bool isBookmarked;

  @override
  void initState() {
    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    if (_authenticatedUser!.favoritedChips
        .contains(widget.currentChip.chipId)) {
      _isInitiallyBookmarked = true;
    } else {
      _isInitiallyBookmarked = false;
    }

    isBookmarked = _isInitiallyBookmarked;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state is ChipBookmarkedState) {
          _isInitiallyBookmarked = !_isInitiallyBookmarked;

          // event fired to emit updated user in app
          BlocProvider.of<AuthCubit>(context).userUpdated(state.updatedUser);

          HelperWidgets.showSnackbar(
            context,
            'Chip added to favorites!🎉',
            'success',
          );
        }

        if (state is ChipUnbookmarkedState) {
          _isInitiallyBookmarked = !_isInitiallyBookmarked;

          // event fired to emit updated user in app
          BlocProvider.of<AuthCubit>(context).userUpdated(state.updatedUser);

          HelperWidgets.showSnackbar(
            context,
            'Chip removed from favorites!😢',
            'info',
          );
        }
      },
      builder: (context, state) {
        return CircleAvatar(
          radius: widget.radius,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: IconButton(
            onPressed: () {
              BlocProvider.of<UserCubit>(context).bookMarkChip(
                chip: widget.currentChip,
                currentUser: _authenticatedUser!,
              );

              setState(() => isBookmarked = !isBookmarked);
            },
            icon: Icon(
              isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              size: widget.iconSize,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        );
      },
    );
  }
}
