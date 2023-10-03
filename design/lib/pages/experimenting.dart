// import 'package:design/responsiveness.dart';
// import 'package:flutter/material.dart';

// class ExperimentingPage extends StatefulWidget {
//   const ExperimentingPage({super.key});

//   @override
//   State<ExperimentingPage> createState() => _ExperimentingPageState();
// }

// class _ExperimentingPageState extends State<ExperimentingPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           // box
//           DecoratedBox(
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.surface,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(
//                     Responsiveness.getScreenWidth(context) * 0.0636363),
//                 topRight: Radius.circular(
//                     Responsiveness.getScreenWidth(context) * 0.0636363),
//               ),
//             ),
//             child: SizedBox(
//               height: Responsiveness.getScreenHeight(context) / 2.6180339887,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: Responsiveness.getScreenWidth(context) * 0.063,
//                   vertical: Responsiveness.getScreenHeight(context) * 0.0,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // sized box
//                     SizedBox(
//                       height: Responsiveness.getScreenHeight(context) * 0.036,
//                     ),

//                     // welcome back
//                     Text(
//                       'Welcome Back!',
//                       style: TextStyle(
//                         fontSize:
//                             Responsiveness.getScreenWidth(context) * 0.072,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),

//                     // sized box
//                     SizedBox(
//                       height: Responsiveness.getScreenHeight(context) * 0.018,
//                     ),

//                     // email
//                     TextFormField(
//                       maxLength: 36,
//                       decoration: InputDecoration(
//                         counterText: '',
//                         hintText: 'a.jone.23031@khi.iba.edu.pk',
//                         prefixIcon: const Icon(Icons.email_outlined),
//                         filled: true,
//                         fillColor: Theme.of(context).colorScheme.surface,
//                         border: const OutlineInputBorder(),
//                       ),
//                     ),

//                     // sized box
//                     SizedBox(
//                       height: Responsiveness.getScreenHeight(context) * 0.009,
//                     ),

//                     // password
//                     TextFormField(
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: 'Password',
//                         prefixIcon: const Icon(Icons.lock_outline),
//                         filled: true,
//                         fillColor: Theme.of(context).colorScheme.surface,
//                         border: const OutlineInputBorder(),
//                       ),
//                     ),

//                     // sized box
//                     SizedBox(
//                       height: Responsiveness.getScreenHeight(context) * 0.018,
//                     ),

//                     // buttons
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Row(
//                           children: [
//                             IconButton(
//                                 onPressed: () {},
//                                 icon: const Icon(Icons.account_circle)),
//                             IconButton(
//                                 onPressed: () {}, icon: const Icon(Icons.login))
//                           ],
//                         ),
//                         IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.play_arrow_rounded)),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
