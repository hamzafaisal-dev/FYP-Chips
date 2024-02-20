import 'package:flutter/material.dart';

class SettingsActionTile extends StatelessWidget {
  const SettingsActionTile({
    super.key,
    required this.title,
    this.subTitle,
    required this.leadingIcon,
    required this.trailingIcon,
  });

  final String title;
  final String? subTitle;
  final IconData leadingIcon;
  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        //
        tileColor: Theme.of(context).colorScheme.surface,

        // adjusts padding according to subtitle availability
        contentPadding: EdgeInsets.fromLTRB(
          subTitle != null ? 15 : 8,
          subTitle != null ? 6 : 0,
          subTitle != null ? 15 : 15,
          subTitle != null ? 6 : 0,
        ),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),

        leading: Container(
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Icon(
            leadingIcon,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),

        trailing: Icon(
          trailingIcon,
          size: 20,
        ),

        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),

        subtitle: subTitle != null
            ? Text(
                subTitle!,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              )
            : null,

        onTap: () {},
      ),
    );
  }
}
