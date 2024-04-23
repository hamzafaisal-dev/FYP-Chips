import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/data/models/user_model.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamMemberTile extends StatefulWidget {
  const TeamMemberTile({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.username,
  });

  final String imagePath;
  final String title;
  final String subtitle;
  final String username;

  @override
  State<TeamMemberTile> createState() => _TeamMemberTileState();
}

class _TeamMemberTileState extends State<TeamMemberTile> {
  late final UserModel? _authenticatedUser;

  @override
  void initState() {
    AuthState authState = BlocProvider.of<AuthCubit>(context).state;
    if (authState is AuthUserSignedIn) _authenticatedUser = authState.user;
    super.initState();
  }

  //
  Future<void> _launchUrl(String b) async {
    final Uri url = Uri.parse(b);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $b');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24.w,
        backgroundImage: AssetImage(widget.imagePath),
      ),
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        widget.subtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: () {
        Helpers.logEvent(
          _authenticatedUser!.userId,
          "view-team-member",
          [widget.username, _authenticatedUser],
        );
        _launchUrl('https://www.linkedin.com/in/${widget.username}/');
      },
    );
  }
}
