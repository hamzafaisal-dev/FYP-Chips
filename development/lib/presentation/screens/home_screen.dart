import 'package:development/business%20logic/cubits/auth/auth_cubit.dart';
import 'package:development/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // late UserModel _user;

  // final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Text(state.props.toString()),
            // child: Text("welcome, ${(state as AuthSignInSuccess).user.name}"),
          );
        },
      ),
      // child: BlocBuilder<ChipBloc, ChipState>(
      //   builder: (context, state) {
      //     if (state is ChipsStreamLoaded) {
      //       return Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           //
      //           SizedBox(height: 16.h),

      //           // hey, user name
      //           RichText(
      //             text: TextSpan(
      //               text: 'hello, ',
      //               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      //                     fontWeight: FontWeight.w700,
      //                     fontSize: 36.sp,
      //                   ),
      //               children: <TextSpan>[
      //                 TextSpan(
      //                   // text: 'Farhan Mushi',
      //                   text: _user.username,
      //                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      //                         fontWeight: FontWeight.w700,
      //                         fontSize: 36.sp,
      //                         color: Theme.of(context).primaryColor,
      //                       ),
      //                 ),
      //               ],
      //             ),
      //           ),

      //           RichText(
      //             text: TextSpan(
      //               text: 'here are some ',
      //               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      //                     fontWeight: FontWeight.w400,
      //                     fontSize: 18.sp,
      //                   ),
      //               children: [
      //                 TextSpan(
      //                   text: 'Chips',
      //                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      //                         fontWeight: FontWeight.w700,
      //                         fontSize: 18.sp,
      //                       ),
      //                 ),
      //                 TextSpan(
      //                   text: ' for you',
      //                   style: Theme.of(context).textTheme.bodyLarge?.copyWith(
      //                         fontWeight: FontWeight.w400,
      //                         fontSize: 18.sp,
      //                       ),
      //                 ),
      //               ],
      //             ),
      //           ),

      //           // SizedBox(height: 23.4.h),

      //           // search bar
      //           // TextFormField(
      //           //   controller: _searchController,
      //           //   decoration: InputDecoration(
      //           //     fillColor: Colors.white,
      //           //     hintText: 'Search',
      //           //     hintStyle: Theme.of(context).textTheme.bodyLarge,
      //           //     prefixIcon: Icon(
      //           //       Icons.search,
      //           //       size: 20.w,
      //           //     ),
      //           //     contentPadding: EdgeInsets.symmetric(
      //           //       horizontal: 0.w,
      //           //       vertical: 0.h,
      //           //     ),
      //           //     border: OutlineInputBorder(
      //           //       borderRadius: BorderRadius.circular(12.r),
      //           //     ),
      //           //   ),
      //           // ),

      //           SizedBox(height: 23.4.h),

      //           StreamBuilder(
      //             stream: state.chips,
      //             builder: (context, snapshot) {
      //               if (snapshot.connectionState == ConnectionState.waiting) {
      //                 return const Expanded(
      //                   child: Center(
      //                     child: CircularProgressIndicator(),
      //                   ),
      //                 );
      //               }

      //               if (snapshot.hasError) {
      //                 return Expanded(
      //                   child: Center(
      //                     child: Text(
      //                       snapshot.error.toString(),
      //                     ),
      //                   ),
      //                 );
      //               }

      //               if (snapshot.hasData) {
      //                 if (snapshot.data!.isEmpty) {
      //                   return const Expanded(
      //                     child: Center(
      //                       child: Text(
      //                         'Could not find what you were looking for',
      //                       ),
      //                     ),
      //                   );
      //                 }

      //                 return Expanded(
      //                   child: ListView.builder(
      //                     itemCount: snapshot.data!.length,
      //                     itemBuilder: (context, index) {
      //                       List<ChipModel> chipData = snapshot.data!;
      //                       var chipObject = chipData[index];

      //                       return Padding(
      //                         padding: EdgeInsets.only(bottom: 10.8.h),
      //                         child: ChipTile(
      //                           chipData: chipObject,
      //                           onTap: () => NavigationService.routeToNamed(
      //                             '/view-chip',
      //                             arguments: {"chipData": chipObject},
      //                           ),
      //                         ),
      //                       );
      //                     },
      //                   ),
      //                 );
      //               }
      //               return const SizedBox();
      //             },
      //           ),
      //         ],
      //       );
      //     }

      //     if (state is ChipEmpty) {
      //       return const Text('khaali hai');
      //     }

      //     return const SizedBox.shrink();
      //   },
      // ),
    );
  }
}
