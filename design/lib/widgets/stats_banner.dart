import 'package:design/responsiveness.dart';
import 'package:flutter/material.dart';

class StatsBanner extends StatefulWidget {
  const StatsBanner({super.key});

  @override
  State<StatsBanner> createState() => _StatsBannerState();
}

class _StatsBannerState extends State<StatsBanner> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // stats row
          Padding(
            padding: EdgeInsets.only(
              // top: Responsiveness.sw(context) * 0.09,
              bottom: Responsiveness.sw(context) * 0.09,
              right: Responsiveness.sw(context) * 0.0369,
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: Responsiveness.sw(context) * 0.0369,
                  ),
                  child: CircleAvatar(
                    radius: Responsiveness.sw(context) * 0.117,
                    backgroundImage:
                        const AssetImage('assets/pictures/daa.jpeg'),
                  ),
                ),

                // sized box
                SizedBox(width: Responsiveness.sw(context) * 0.099),

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
                            message: 'He has posted 18 Chips!',
                            child: Column(
                              children: [
                                Text(
                                  '18',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        Responsiveness.sw(context) * 0.0458333,
                                  ),
                                ),
                                const Text('Chips'),
                              ],
                            ),
                          ),

                          // vertical divider
                          SizedBox(
                            height: Responsiveness.sw(context) * 0.0687499,
                            child: const VerticalDivider(),
                          ),

                          // likes
                          Tooltip(
                            message: '36 people favorited his Chips!',
                            child: Column(
                              children: [
                                Text(
                                  '36',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        Responsiveness.sw(context) * 0.0458333,
                                  ),
                                ),
                                const Text('Likes'),
                              ],
                            ),
                          ),

                          // vertical divider
                          SizedBox(
                            height: Responsiveness.sw(context) * 0.0687499,
                            child: const VerticalDivider(),
                          ),

                          // views
                          Tooltip(
                            message: '81 people viewed his Chips!',
                            child: Column(
                              children: [
                                Text(
                                  '81',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        Responsiveness.sw(context) * 0.0458333,
                                  ),
                                ),
                                const Text('Views'),
                              ],
                            ),
                          ),
                        ],
                      ),

                      // sized box
                      SizedBox(height: Responsiveness.sw(context) * 0.0234),

                      // button
                      SizedBox(
                        height: Responsiveness.sw(context) * 0.063,
                        width: double.maxFinite,
                        child: FilledButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Responsiveness.sw(context) * 0.018),
                              ),
                            ),
                          ),
                          child: const Text('Contact'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
