// import 'package:design/responsiveness.dart';
// import 'package:design/widgets/chip_tile/chip_tile.dart';
// import 'package:design/widgets/chip_tile/edit_button.dart';
// import 'package:flutter/material.dart';

// class ProfilePage extends StatelessWidget {
//   const ProfilePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // screen width
//     double sw = Responsiveness.getScreenWidth(context);
//     return Scaffold(
//       // appbar
//       appBar: AppBar(
//         title: const Text(
//           'a.jone.23031',
//           style: TextStyle(fontWeight: FontWeight.w500),
//         ),
//         surfaceTintColor: Colors.transparent,
//         actions: [
//           // hamburger menu
//           IconButton(
//             tooltip: 'Menu',
//             onPressed: () {
//               showModalBottomSheet(
//                 context: context,
//                 builder: (context) {
//                   return Container();
//                 },
//               );
//             },
//             icon: const Icon(
//               Icons.menu_outlined,
//             ),
//           ),
//         ],
//       ),

//       // body
//       body: Column(
//         children: [
//           // sized box
//           SizedBox(height: sw * 0.0369),

//           // profile header
//           Row(
//             children: [
//               // avatar
//               Padding(
//                 padding: EdgeInsets.only(
//                   left: sw * 0.0369,
//                 ),
//                 child: Container(
//                   width: sw * 0.234,
//                   height: sw * 0.234,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(sw * 0.036),
//                     image: const DecorationImage(
//                       image: AssetImage('assets/pictures/daa.jpeg'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//               ),

//               // sized box
//               SizedBox(width: sw * 0.099),

//               // column
//               Expanded(
//                 child: Column(
//                   children: [
//                     // stats row
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         // chips
//                         Tooltip(
//                           message: 'Your contributions!',
//                           child: Column(
//                             children: [
//                               Text(
//                                 '18',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: sw * 0.0458333,
//                                 ),
//                               ),
//                               const Text('Chips'),
//                             ],
//                           ),
//                         ),

//                         // vertical divider
//                         SizedBox(
//                           height: sw * 0.0687499,
//                           child: const VerticalDivider(),
//                         ),

//                         // likes
//                         Tooltip(
//                           message: '36 people favorited your Chips!',
//                           child: Column(
//                             children: [
//                               Text(
//                                 '36',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: sw * 0.0458333,
//                                 ),
//                               ),
//                               const Text('Likes'),
//                             ],
//                           ),
//                         ),

//                         // vertical divider
//                         SizedBox(
//                           height: sw * 0.0687499,
//                           child: const VerticalDivider(),
//                         ),

//                         // views
//                         Tooltip(
//                           message: '81 people viewed your Chips!',
//                           child: Column(
//                             children: [
//                               Text(
//                                 '81',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: sw * 0.0458333,
//                                 ),
//                               ),
//                               const Text('Views'),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),

//                     // sized box
//                     SizedBox(height: sw * 0.0234),

//                     // button
//                     Tooltip(
//                       message: 'Edit Profile & Personal Details',
//                       child: SizedBox(
//                         height: sw * 0.063,
//                         width: double.maxFinite,
//                         child: FilledButton(
//                           onPressed: () {},
//                           style: ButtonStyle(
//                             shape: MaterialStateProperty.all(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(sw * 0.018),
//                               ),
//                             ),
//                           ),
//                           child: const Text('Edit Profile'),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               // sized box
//               SizedBox(width: sw * 0.099),
//             ],
//           ),

//           // sized box
//           SizedBox(height: sw * 0.0369),

//           // rest

//           // divider
//           Padding(
//             padding: EdgeInsets.only(top: sw * 0.0234),
//             child: const Divider(height: 0),
//           ),

//           // chips
//           Expanded(
//             child: ListView.builder(
//               itemCount: 63,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.fromLTRB(
//                     0,
//                     index == 0 ? sw * 0.009 : 0,
//                     0,
//                     index == 62 ? sw * 0.009 : 0,
//                   ),
//                   child: const ChipTile(
//                     deadline: '23',
//                     title: 'title',
//                     subtitle: 'subtitle',
//                     actionButton: EditButton(),
//                     isToday: true,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),

//       // bottom nav bar
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: 3,
//         animationDuration: const Duration(milliseconds: 360),
//         destinations: const [
//           NavigationDestination(
//             icon: Icon(Icons.home_outlined),
//             selectedIcon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.favorite_outline),
//             selectedIcon: Icon(Icons.favorite),
//             label: 'Favorites',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.history_outlined),
//             selectedIcon: Icon(Icons.history),
//             label: 'Applied',
//           ),
//           NavigationDestination(
//             icon: Icon(Icons.account_circle_outlined),
//             selectedIcon: Icon(Icons.account_circle),
//             label: 'Profile',
//           ),
//         ],
//       ),

//       // fab
//       floatingActionButton: FloatingActionButton.extended(
//         tooltip: 'Post a Chip',
//         label: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.add),
//             SizedBox(width: sw * 0.0239872),
//             const Text('Add Chip'),
//           ],
//         ),
//         onPressed: () {
//           print(27 / sw);
//         },
//       ),
//     );
//   }
// }
