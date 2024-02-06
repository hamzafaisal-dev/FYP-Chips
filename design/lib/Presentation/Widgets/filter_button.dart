import 'package:design/Common/responsiveness.dart';
import 'package:design/Presentation/Widgets/filter_modal.dart';
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
          isScrollControlled: true,
          showDragHandle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(sw * 0.063),
              topRight: Radius.circular(sw * 0.063),
            ),
          ),
          context: context,
          builder: (context) => const FilterModal(),
        );
      },
    );
  }
}
