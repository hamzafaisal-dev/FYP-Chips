import 'package:development/business%20logic/blocs/chip/chip_bloc.dart';
import 'package:development/business%20logic/blocs/chip/chip_event.dart';
import 'package:development/business%20logic/blocs/chip/chip_state.dart';
import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBookmarkIcon extends StatefulWidget {
  const CustomBookmarkIcon({
    super.key,
    required this.iconSize,
    required this.chipId,
    this.radius,
  });

  final double? radius;
  final double iconSize;
  final String chipId;

  @override
  State<CustomBookmarkIcon> createState() => _CustomBookmarkIconState();
}

class _CustomBookmarkIconState extends State<CustomBookmarkIcon> {
  late final UserModel? _authenticatedUser;
  bool _isInitiallyBookmarked = false;

  late bool isBookmarked;

  @override
  void initState() {
    super.initState();

    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    if (_authenticatedUser!.favoritedChips.contains(widget.chipId)) {
      _isInitiallyBookmarked = true;
    } else {
      _isInitiallyBookmarked = false;
    }

    isBookmarked = _isInitiallyBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    // replace with UserCubit when its created
    return BlocConsumer<ChipBloc, ChipState>(
      listener: (context, state) {
        if (state is ChipBookmarked) {
          _isInitiallyBookmarked = !_isInitiallyBookmarked;
        }

        if (state is ChipUnbookmarked) {
          _isInitiallyBookmarked = !_isInitiallyBookmarked;
        }
      },
      builder: (context, state) {
        return CircleAvatar(
          radius: widget.radius,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: IconButton(
            onPressed: () {
              BlocProvider.of<ChipBloc>(context).add(ChipBookmarkedEvent(
                chipId: widget.chipId,
                currentUser: _authenticatedUser!,
              ));

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
