import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChipTile extends StatefulWidget {
  const ChipTile({
    super.key,
    required this.postedBy,
    required this.jobTitle,
    required this.description,
  });

  final String postedBy;
  final String jobTitle;
  final String description;

  @override
  State<ChipTile> createState() => _ChipTileState();
}

class _ChipTileState extends State<ChipTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // user pfp + posted by + time
                Row(
                  children: [
                    //

                    // user profile picture
                    const Padding(
                      padding: EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        radius: 16,
                        child: Icon(Icons.person_3),
                      ),
                    ),

                    // posted by + time
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //

                        // posted by
                        Text(
                          widget.postedBy,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),

                        // time
                        Text(
                          '41m ago',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // bookmark icon
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  child: Icon(
                    Icons.bookmark_outline,
                    size: 22,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                )
              ],
            ),

            Divider(
              color: Theme.of(context).colorScheme.primaryContainer,
              thickness: 2,
            ),

            // job title
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 3, 0, 4),
              child: Text(
                widget.jobTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            // job description
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(widget.description),
            ),

            Divider(
              color: Theme.of(context).colorScheme.primaryContainer,
              thickness: 2,
            ),

            // heart icon + post likes
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //
                  // Chip(
                  //   color: MaterialStateProperty
                  //       .all<Color>(Theme.of(context)
                  //           .colorScheme
                  //           .primary),
                  //   padding: EdgeInsets.zero,
                  //   label: Text('Flutter'),
                  // ),

                  // heart icon + post likes
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //

                      // heart icon
                      Icon(
                        CupertinoIcons.heart_fill,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),

                      const SizedBox(width: 3),

                      // post likes count
                      const Text(
                        '3.1k',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
