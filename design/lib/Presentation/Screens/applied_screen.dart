import 'package:design/Common/responsiveness.dart';
import 'package:design/Presentation/Widgets/Chip%20Tile/chip_tile.dart';
import 'package:design/Presentation/Widgets/Chip%20Tile/edit_button.dart';
import 'package:design/Presentation/Widgets/Chip%20Tile/like_button.dart';
import 'package:flutter/material.dart';

class AppliedBody extends StatefulWidget {
  const AppliedBody({super.key});

  @override
  State<AppliedBody> createState() => _AppliedBodyState();
}

class _AppliedBodyState extends State<AppliedBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // app bar
        SliverAppBar(
          surfaceTintColor: Colors.transparent,
          title: const Text('Applied'),
          centerTitle: true,
          floating: true,
          actions: [
            IconButton(
              tooltip: 'Search',
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
        ),

        // body
        SliverAnimatedList(
          initialItemCount: 3,
          itemBuilder: (context, index, animation) {
            return Padding(
              padding: EdgeInsets.only(
                top: index == 0 ? Responsiveness.sw(context) * 0.009 : 0,
              ),
              child: const ChipTile(
                deadline: '23',
                title: 'title',
                subtitle: 'subtitle',
                actionButton: LikeButton(),
                isToday: true,
              ),
            );
          },
        ),

        SliverAnimatedList(
          initialItemCount: 33,
          itemBuilder: (context, index, animation) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == 32 ? Responsiveness.sw(context) * 0.009 : 0,
              ),
              child: const ChipTile(
                deadline: 'Oct',
                title: 'title',
                subtitle: 'subtitle',
                actionButton: EditButton(),
                isToday: false,
              ),
            );
          },
        ),
      ],
    );
  }
}