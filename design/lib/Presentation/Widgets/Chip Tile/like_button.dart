import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  const LikeButton({super.key});

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool liked = true;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      tooltip: 'Favorite',
      onPressed: () {
        setState(() {
          liked = !liked;
        });
      },
      icon: liked
          ? const Icon(
              Icons.favorite,
              color: Colors.red,
            )
          : const Icon(Icons.favorite_outline),
    );
  }
}
