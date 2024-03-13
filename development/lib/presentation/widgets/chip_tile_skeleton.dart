import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChipTileSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //
                  Row(
                    children: [
                      //
                      const Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.white,
                        ),
                      ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //
                          Container(
                            width: 100,
                            height: 16,
                            color: Colors.white,
                          ),

                          const SizedBox(height: 4),

                          Container(
                            width: 80,
                            height: 12,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),

                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.bookmark_outline,
                      size: 22,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),

              Divider(
                color: Colors.grey[300],
                thickness: 1,
              ),

              Container(
                height: 30,
                width: 200,
                color: Colors.white,
              ),

              const SizedBox(height: 10),

              Container(
                height: 50,
                color: Colors.white,
              ),

              Divider(
                color: Colors.grey[300],
                thickness: 2,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //
                        Icon(
                          Icons.favorite,
                          size: 16,
                          color: Colors.grey[400],
                        ),

                        const SizedBox(width: 3),

                        Container(
                          width: 40,
                          height: 16,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
