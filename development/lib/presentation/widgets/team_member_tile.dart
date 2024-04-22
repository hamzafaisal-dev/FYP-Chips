import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamMemberTile extends StatelessWidget {
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
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: () {
        _launchUrl('https://www.linkedin.com/in/$username/');
      },
    );
  }
}
