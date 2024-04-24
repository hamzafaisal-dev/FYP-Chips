import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/business%20logic/cubits/user/user_cubit.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:development/utils/widget_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarkAppliedButton extends StatefulWidget {
  const MarkAppliedButton({
    super.key,
    required this.chipId,
  });

  final String chipId;

  @override
  State<MarkAppliedButton> createState() => _MarkAppliedButtonState();
}

class _MarkAppliedButtonState extends State<MarkAppliedButton> {
  late final UserModel? _authenticatedUser;
  bool _isInitiallyBookmarked = false;

  late bool isBookmarked;

  @override
  void initState() {
    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;

    if (_authenticatedUser!.appliedChips.contains(widget.chipId)) {
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
        if (state is ChipAppliedState) {
          _isInitiallyBookmarked = !_isInitiallyBookmarked;

          // event fired to emit updated user in app
          BlocProvider.of<AuthCubit>(context).userUpdated(state.updatedUser);

          HelperWidgets.showSnackbar(
            context,
            'Chip marked as applied!✅',
            'success',
          );

          // log event
          Helpers.logEvent(
            _authenticatedUser!.userId,
            "mark-chip-applied",
            [widget.chipId],
          );
        }

        if (state is ChipUnAppliedState) {
          _isInitiallyBookmarked = !_isInitiallyBookmarked;

          // event fired to emit updated user in app
          BlocProvider.of<AuthCubit>(context).userUpdated(state.updatedUser);

          HelperWidgets.showSnackbar(
            context,
            'Chip unmarked as applied!❌',
            'info',
          );

          // log event
          Helpers.logEvent(
            _authenticatedUser!.userId,
            "unmark-chip-applied",
            [widget.chipId],
          );
        }

        if (state is UserErrorState) {
          HelperWidgets.showSnackbar(
            context,
            state.errorMessage,
            'error',
          );
        }
      },
      builder: (context, state) {
        return FilledButton(
          onPressed: () {
            BlocProvider.of<UserCubit>(context).markChipAsApplied(
              chipId: widget.chipId,
              currentUser: _authenticatedUser!,
            );

            setState(() => isBookmarked = !isBookmarked);
          },
          child: isBookmarked
              ? Text(
                  'Unmark as applied',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 22),
                )
              : Text(
                  'Mark as applied',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontSize: 22),
                ),
        );
      },
    );
  }
}
