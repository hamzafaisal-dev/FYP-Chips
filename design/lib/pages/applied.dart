// import 'package:design/responsiveness.dart';
// import 'package:design/widgets/chip_tile/chip_tile.dart';
// import 'package:design/widgets/chip_tile/edit_button.dart';
// import 'package:design/widgets/chip_tile/like_button.dart';
// import 'package:flutter/material.dart';

// class AppliedPage extends StatelessWidget {
//   const AppliedPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // screen width
//     double sw = Responsiveness.getScreenWidth(context);
//     return Scaffold(
//       // appbar
//       appBar: AppBar(
//         // title
//         title: const Text('Applied'),
//         centerTitle: true,

//         // trailing actions
//         actions: [
//           IconButton(
//             tooltip: 'Search',
//             onPressed: () {},
//             icon: const Icon(Icons.search),
//             // icon: const Icon(Icons.notifications_outlined),
//           ),
//         ],
//       ),

//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // chips expiring today
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: 3,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.fromLTRB(
//                     0,
//                     index == 0 ? sw * 0.009 : 0,
//                     0,
//                     0,
//                   ),
//                   child: const ChipTile(
//                     actionButton: LikeButton(),
//                     deadline: '18',
//                     subtitle: 'Unilever',
//                     title: 'Summer Internship',
//                     isToday: true,
//                   ),
//                 );
//               },
//             ),

//             // apna chip
//             const ChipTile(
//               actionButton: EditButton(),
//               deadline: '23',
//               subtitle: 'Folio3',
//               title: 'Software Engineer',
//               isToday: false,
//             ),

//             // chips expiring later this month
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: 3,
//               itemBuilder: (context, index) {
//                 return const ChipTile(
//                   actionButton: LikeButton(),
//                   deadline: '23',
//                   subtitle: 'Folio3',
//                   title: 'Software Engineer',
//                   isToday: false,
//                 );
//               },
//             ),

//             // apna chip
//             const ChipTile(
//               actionButton: EditButton(),
//               deadline: '23',
//               subtitle: 'Folio3',
//               title: 'Software Engineer',
//               isToday: false,
//             ),

//             // chips expiring next month
//             ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: 13,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: EdgeInsets.fromLTRB(
//                     0,
//                     0,
//                     0,
//                     index == 12 ? sw * 0.009 : 0,
//                   ),
//                   child: const ChipTile(
//                     actionButton: LikeButton(),
//                     deadline: 'Oct',
//                     subtitle: 'OpenAI',
//                     title: 'AI Researcher',
//                     isToday: false,
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       // bottom nav bar
//       bottomNavigationBar: NavigationBar(
//         selectedIndex: 2,
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
//         onPressed: () {},
//       ),
//     );
//   }
// }
