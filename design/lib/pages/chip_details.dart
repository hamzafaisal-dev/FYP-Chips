import 'package:design/responsiveness.dart';
import 'package:design/widgets/stats_banner.dart';
import 'package:flutter/material.dart';

class ChipDetails extends StatefulWidget {
  const ChipDetails({super.key});

  @override
  State<ChipDetails> createState() => _ChipDetailsState();
}

class _ChipDetailsState extends State<ChipDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Developer'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const ListTile(
              leading: Tooltip(
                message: 'Nov-23',
                child: CircleAvatar(
                  child: Text('23'),
                ),
              ),
              title: Text('Systems Limited'),
              subtitle: Text('Karachi'),
            ),

            // credits
            ListTile(
              title: Row(
                children: [
                  const Text('Credits: '),
                  InkWell(
                    onTap: () {
                      // show modal bottom sheet
                      showModalBottomSheet(
                        showDragHandle: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                Responsiveness.sw(context) * 0.063),
                            topRight: Radius.circular(
                                Responsiveness.sw(context) * 0.063),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return const StatsBanner();
                        },
                      );
                    },
                    child: const Text(
                      'a.jone.23031',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // mode, type, experience
            ListTile(
              leading: const Icon(Icons.cases_outlined),
              title: Row(
                children: [
                  Chip(
                    label: const Text('On-site'),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.0234),
                  Chip(
                    label: const Text('Full-time'),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.0234),
                  Chip(
                    label: const Text('2-4 Years'),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                ],
              ),
            ),

            // skills
            ListTile(
              leading: const Icon(Icons.lightbulb_outline),
              title: Row(
                children: [
                  Chip(
                    label: const Text('Flutter'),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.0234),
                  Chip(
                    label: const Text('Node.js'),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  SizedBox(width: Responsiveness.sw(context) * 0.0234),
                  Chip(
                    label: const Text('Mongo DB'),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                ],
              ),
            ),

            // expected salary
            ListTile(
              leading: const Icon(Icons.attach_money_outlined),
              title: Row(
                children: [
                  Chip(
                    label: const Text('PKR 100,000'),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                ],
              ),
            ),

            // description title and description box
            const ListTile(
              title: Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(
                'We are looking for a Flutter Developer who possesses a passion for pushing mobile technologies to the limits. This Flutter app developer will work with our team of talented engineers to design and build the next generation of our mobile applications. Flutter programming works closely with other app development and technical teams.',
              ),
            ),
          ],
        ),
      ),

      // apply now floating action button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('Apply Now'),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
