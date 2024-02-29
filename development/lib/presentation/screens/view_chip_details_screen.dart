import 'package:development/constants/asset_paths.dart';
import 'package:development/data/models/chip_model.dart';
import 'package:development/presentation/widgets/custom_icon_button.dart';
import 'package:development/utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChipDetailsScreen extends StatefulWidget {
  const ChipDetailsScreen({super.key, this.arguments});

  final Map<String, dynamic>? arguments;

  @override
  State<ChipDetailsScreen> createState() => _ChipDetailsScreenState();
}

class _ChipDetailsScreenState extends State<ChipDetailsScreen> {
  late ChipModel _chipData;

  @override
  void initState() {
    super.initState();

    if (widget.arguments != null) {
      _chipData = widget.arguments!["chipData"];
    }

    print(_chipData.createdAt.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
          child: ListView(
            children: [
              //
              CustomIconButton(
                iconSvgPath: AssetPaths.leftArrowIconPath,
                iconWidth: 16.w,
                iconHeight: 16.h,
                onTap: () => Navigator.of(context).pop(),
              ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Text(
                    _chipData.jobTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    child: Icon(
                      Icons.bookmark_outline,
                      size: 28,
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Text(
                    'Posted By: ${_chipData.postedBy}',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  Text(
                    Helpers.formatTimeAgo(_chipData.createdAt.toString()),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),

              const SizedBox(height: 14),

              Text(
                'Chip Details',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium!
                    .copyWith(fontSize: 22),
              ),

              Text(_chipData.description),

              const SizedBox(height: 14),

              if (_chipData.imageUrl != null && _chipData.imageUrl != '')
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    _chipData.imageUrl!,
                    fit: BoxFit.contain,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return child; // If the image is fully loaded, return the original child.
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
