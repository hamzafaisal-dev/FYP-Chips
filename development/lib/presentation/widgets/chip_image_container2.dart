import 'package:development/presentation/widgets/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class ChipNetworkImageContainer extends StatefulWidget {
  const ChipNetworkImageContainer({
    super.key,
    required this.imageUrl,
  });

  final String? imageUrl;

  @override
  State<ChipNetworkImageContainer> createState() =>
      _ChipNetworkImageContainerState();
}

class _ChipNetworkImageContainerState extends State<ChipNetworkImageContainer> {
  void _showPictureFullScreen(String imageUrl) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog.fullscreen(
            backgroundColor: Colors.black38,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(imageUrl),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.topRight,
                    color: Colors.black45,
                    height: 40,
                    width: 400,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) {
      return InkWell(
        onTap: () => _showPictureFullScreen(widget.imageUrl!),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          height: MediaQuery.of(context).size.width,
          width: MediaQuery.of(context).size.width,
          child: Image.network(
            widget.imageUrl!,
            fit: BoxFit.contain,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              // If the image is fully loaded, return the original child.
              if (loadingProgress == null) {
                return child;
              } else {
                return const Center(
                  child: CustomCircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
