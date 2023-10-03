import 'package:design/responsiveness.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = Responsiveness.sw(context);
    return IconButton(
      tooltip: 'Filter',
      icon: const Icon(Icons.filter_alt_outlined),
      onPressed: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(sw * 0.0369),
              topRight: Radius.circular(sw * 0.0369),
            ),
          ),
          context: context,
          builder: (context) => Container(),
        );
      },
    );
  }
}
