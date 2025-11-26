import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:jollycast/view/widgets/color.dart';

class VideoLoadingShimmer extends StatelessWidget {
  const VideoLoadingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Colors.grey[300]),
      ),
    );
  }
}

class DiscoverScreenShimmer extends StatelessWidget {
  const DiscoverScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: darkGreyColor,
      highlightColor: darkGreyColor2,
      period: const Duration(milliseconds: 1500),
      child: Container(
        color: blackColor3,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AppBar shimmer
              SizedBox(height: 60.spMin),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.spMin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 90.spMin,
                      height: 40.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(8.spMin),
                      ),
                    ),
                    Container(
                      width: 161.spMin,
                      height: 61.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(18.spMin),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.spMin),
              // Hot & trending section shimmer
              Padding(
                padding: EdgeInsets.only(left: 23.spMin, bottom: 17.spMin),
                child: Row(
                  children: [
                    Container(
                      width: 27.spMin,
                      height: 36.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(4.spMin),
                      ),
                    ),
                    SizedBox(width: 8.spMin),
                    Container(
                      width: 200.spMin,
                      height: 24.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(4.spMin),
                      ),
                    ),
                  ],
                ),
              ),
              // Trending cards shimmer
              SizedBox(
                height: 351.spMin,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 24.spMin),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 283.spMin,
                      height: 351.spMin,
                      margin: EdgeInsets.only(right: 16.spMin),
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(12.spMin),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 57.spMin),
              // Editor's pick section shimmer
              Padding(
                padding: EdgeInsets.only(left: 23.spMin, bottom: 16.spMin),
                child: Row(
                  children: [
                    Container(
                      width: 27.spMin,
                      height: 27.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(4.spMin),
                      ),
                    ),
                    SizedBox(width: 5.spMin),
                    Container(
                      width: 150.spMin,
                      height: 24.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(4.spMin),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 17.spMin),
              // Editor's pick card shimmer
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.spMin),
                child: Container(
                  height: 206.spMin,
                  decoration: BoxDecoration(
                    color: darkGreyColor,
                    borderRadius: BorderRadius.circular(16.spMin),
                  ),
                ),
              ),
              SizedBox(height: 60.spMin),
              // Top jolly section shimmer
              Padding(
                padding: EdgeInsets.only(left: 21.spMin, right: 18.spMin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 120.spMin,
                      height: 24.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(4.spMin),
                      ),
                    ),
                    Container(
                      width: 78.spMin,
                      height: 30.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(18.spMin),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 23.spMin),
              // Top jolly cards shimmer
              SizedBox(
                height: 237.spMin,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 14.spMin),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 185.spMin,
                      height: 237.spMin,
                      margin: EdgeInsets.only(right: 10.spMin),
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(12.spMin),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 50.spMin),
              // Newest episodes section shimmer
              Padding(
                padding: EdgeInsets.only(left: 21.spMin, right: 18.spMin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 150.spMin,
                      height: 24.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(4.spMin),
                      ),
                    ),
                    Container(
                      width: 101.spMin,
                      height: 30.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(18.spMin),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 17.spMin),
              // Newest episodes list shimmer
              SizedBox(
                height: 510.spMin,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 12.spMin),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 22.spMin),
                      child: Container(
                        width: 300.spMin,
                        child: Column(
                          children: List.generate(5, (rowIndex) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom: rowIndex < 4 ? 21.spMin : 0,
                              ),
                              child: Container(
                                height: 80.spMin,
                                decoration: BoxDecoration(
                                  color: darkGreyColor,
                                  borderRadius: BorderRadius.circular(8.spMin),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 40.spMin),
              // See all button shimmer
              Center(
                child: Container(
                  width: 238.spMin,
                  height: 48.spMin,
                  decoration: BoxDecoration(
                    color: darkGreyColor,
                    borderRadius: BorderRadius.circular(22.spMin),
                  ),
                ),
              ),
              SizedBox(height: 58.spMin),
              // Mixed by interest section shimmer
              Padding(
                padding: EdgeInsets.only(left: 21.spMin),
                child: Container(
                  width: 200.spMin,
                  height: 24.spMin,
                  decoration: BoxDecoration(
                    color: darkGreyColor,
                    borderRadius: BorderRadius.circular(4.spMin),
                  ),
                ),
              ),
              SizedBox(height: 14.spMin),
              // Grid shimmer
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 19.spMin),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12.spMin,
                    mainAxisSpacing: 15.spMin,
                    childAspectRatio: 190 / 221.5,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(12.spMin),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 40.spMin),
              // Show all button shimmer
              Center(
                child: Container(
                  width: 238.spMin,
                  height: 48.spMin,
                  decoration: BoxDecoration(
                    color: darkGreyColor,
                    borderRadius: BorderRadius.circular(22.spMin),
                  ),
                ),
              ),
              SizedBox(height: 76.spMin),
              // Handpicked section shimmer
              Padding(
                padding: EdgeInsets.only(left: 23.spMin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 27.spMin,
                      height: 36.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(4.spMin),
                      ),
                    ),
                    SizedBox(height: 6.spMin),
                    Container(
                      width: 200.spMin,
                      height: 24.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(4.spMin),
                      ),
                    ),
                    SizedBox(height: 3.spMin),
                    Container(
                      width: 150.spMin,
                      height: 18.spMin,
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(4.spMin),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.spMin),
              // Handpicked cards shimmer
              Column(
                children: List.generate(3, (index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.spMin),
                    child: Container(
                      width: 382.spMin,
                      height: 500.spMin,
                      margin: EdgeInsets.only(bottom: index < 2 ? 20.spMin : 0),
                      decoration: BoxDecoration(
                        color: darkGreyColor,
                        borderRadius: BorderRadius.circular(12.spMin),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 88.spMin),
              // Hashtag tags shimmer
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.spMin),
                child: Column(
                  children: List.generate(6, (rowIndex) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: rowIndex < 5 ? 26.spMin : 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          rowIndex % 2 == 0 ? 2 : 3,
                          (tagIndex) {
                            return Container(
                              width: 100.spMin,
                              height: 35.spMin,
                              decoration: BoxDecoration(
                                color: darkGreyColor,
                                borderRadius: BorderRadius.circular(20.spMin),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 32.spMin),
            ],
          ),
        ),
      ),
    );
  }
}
