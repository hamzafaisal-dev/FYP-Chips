import 'package:design/Common/responsiveness.dart';
import 'package:design/Presentation/Widgets/chip_tile/chip_tile.dart';
import 'package:design/Presentation/Widgets/chip_tile/like_button.dart';
import 'package:flutter/material.dart';

class FavoritesBody extends StatefulWidget {
  const FavoritesBody({super.key});

  @override
  State<FavoritesBody> createState() => _FavoritesBodyState();
}

class _FavoritesBodyState extends State<FavoritesBody> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // appbar
        SliverAppBar(
          surfaceTintColor: Colors.transparent,
          title: const Text('Favorites'),
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
          initialItemCount: 36,
          itemBuilder: (context, index, animation) {
            return Padding(
              padding: EdgeInsets.only(
                top: index == 0 ? Responsiveness.sw(context) * 0.009 : 0,
                bottom: index == 35 ? Responsiveness.sw(context) * 0.009 : 0,
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
      ],
    );
  }
}
