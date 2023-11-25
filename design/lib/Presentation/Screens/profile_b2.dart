import 'package:design/Common/responsiveness.dart';
import 'package:design/Presentation/Widgets/chip_tile/chip_tile.dart';
import 'package:design/Presentation/Widgets/chip_tile/edit_button.dart';
import 'package:flutter/material.dart';

class ProfileBody2 extends StatelessWidget {
  const ProfileBody2({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = Responsiveness.sw(context);
    final radius = sw * 0.0636363;
    return Column(
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(radius),
              bottomRight: Radius.circular(radius),
            ),
          ),
          child: Column(
            children: [
              // sized box
              SizedBox(height: sw * 0.0369),

              // profile header
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: sw * 0.0369,
                    ),
                    child: CircleAvatar(
                      radius: sw * 0.117,
                      backgroundImage:
                          const AssetImage('assets/pictures/daa.jpeg'),
                    ),
                  ),

                  // sized box
                  SizedBox(width: sw * 0.099),

                  // column
                  Expanded(
                    child: Column(
                      children: [
                        // stats row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // chips
                            Tooltip(
                              message: 'Your contributions!',
                              child: Column(
                                children: [
                                  Text(
                                    '18',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: sw * 0.0458333,
                                    ),
                                  ),
                                  const Text('Chips'),
                                ],
                              ),
                            ),

                            // vertical divider
                            SizedBox(
                              height: sw * 0.0687499,
                              child: const VerticalDivider(),
                            ),

                            // likes
                            Tooltip(
                              message: '36 people favorited your Chips!',
                              child: Column(
                                children: [
                                  Text(
                                    '36',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: sw * 0.0458333,
                                    ),
                                  ),
                                  const Text('Likes'),
                                ],
                              ),
                            ),

                            // vertical divider
                            SizedBox(
                              height: sw * 0.0687499,
                              child: const VerticalDivider(),
                            ),

                            // views
                            Tooltip(
                              message: '81 people viewed your Chips!',
                              child: Column(
                                children: [
                                  Text(
                                    '81',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: sw * 0.0458333,
                                    ),
                                  ),
                                  const Text('Views'),
                                ],
                              ),
                            ),
                          ],
                        ),

                        // sized box
                        SizedBox(height: sw * 0.0234),

                        // button
                        SizedBox(
                          height: sw * 0.063,
                          width: double.maxFinite,
                          child: FilledButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/editProfile');
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(sw * 0.018),
                                ),
                              ),
                            ),
                            child: const Text('Edit profile'),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // sized box
                  SizedBox(width: sw * 0.099),
                ],
              ),

              // sized box
              // SizedBox(height: sw * 0.0369),
              SizedBox(height: sw * 0.063),
            ],
          ),
        ),

        // chips
        Expanded(
          child: ListView.builder(
            itemCount: 63,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                  0,
                  index == 0 ? sw * 0.009 : 0,
                  0,
                  index == 62 ? sw * 0.009 : 0,
                ),
                child: const ChipTile(
                  deadline: '23',
                  title: 'title',
                  subtitle: 'subtitle',
                  actionButton: EditButton(),
                  isToday: true,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
