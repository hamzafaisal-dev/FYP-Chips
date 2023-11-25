import 'package:design/Common/responsiveness.dart';
import 'package:design/Presentation/Widgets/chip_tile/chip_tile.dart';
import 'package:design/Presentation/Widgets/chip_tile/edit_button.dart';
import 'package:design/Presentation/Widgets/chip_tile/like_button.dart';
import 'package:design/Presentation/Widgets/filter_button.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // app bar
        SliverAppBar(
          surfaceTintColor: Colors.transparent,
          leading: const FilterButton(),
          title: const Text('Chips'),
          centerTitle: true,
          floating: true,
          actions: [
            IconButton(
              tooltip: 'Search',
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              tooltip: 'Notifications',
              onPressed: () {},
              icon: const Badge(child: Icon(Icons.notifications_outlined)),
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
