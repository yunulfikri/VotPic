import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ruangbawah/components/ad_helper.dart';
import 'package:ruangbawah/components/featured_card.dart';
import 'package:ruangbawah/components/post_card.dart';
import 'package:ruangbawah/helper/api_helper.dart';
import '../helper/post.dart';
import 'detail.dart';
import 'package:ruangbawah/components/category_boxes.dart';
import 'package:ruangbawah/components/icons.dart';
import 'package:ruangbawah/components/discover_card.dart';
import 'package:ruangbawah/components/discover_small_card.dart';
import 'package:ruangbawah/components/svg_asset.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({
    Key? key,
  }) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  BannerAd? _bannerAd;
  @override
  void initState() {
    BannerAd(
        adUnitId: AdHelper.bannerAdUnitId,
        request: AdRequest(),
        size: AdSize.banner,
        listener: BannerAdListener(onAdLoaded: (ad) {
          setState(() {
            _bannerAd = ad as BannerAd;
          });
        }, onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          ad.dispose();
        })).load();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd?.dispose();
    super.dispose();
  }

  Widget _iklan() {
    if (_bannerAd != null) {
      return StatefulBuilder(
          builder: (context, setState) => Container(
                width: _bannerAd!.size.width.toDouble(),
                height: _bannerAd!.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd!),
              ));
    } else {
      return SizedBox(
        height: 1.h,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 28.w,
                right: 18.w,
                top: 36.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Discover",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34.w,
                          fontWeight: FontWeight.bold)),
                  InkWell(
                    borderRadius: BorderRadius.circular(360),
                    onTap: onSearchIconTapped,
                    child: Container(
                      height: 35.w,
                      width: 35.w,
                      child: Center(
                        child: SvgAsset(
                          assetName: AssetName.search,
                          height: 24.w,
                          width: 24.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 120.h,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 28.w,
                  ),
                  CategoryBoxes(
                    text: "CewekCantik",
                    onPressed: (value) => print(value),
                  ),
                  CategoryBoxes(
                    text: "Batu",
                    onPressed: (value) => print(value),
                  ),
                  CategoryBoxes(
                    text: "Aneh",
                    onPressed: (value) => print(value),
                  ),
                  CategoryBoxes(
                    text: "SiCantik",
                    onPressed: (value) => print(value),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Featured",
                    style: TextStyle(
                        color: Color(0xff515979),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.w),
                  ),
                  GestureDetector(
                      onTap: onSeeAllTapped,
                      child: Text("See All",
                          style: TextStyle(
                              color: Color(0xff4A80F0),
                              fontWeight: FontWeight.w500,
                              fontSize: 14.w)))
                ],
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            SizedBox(
              height: 176.w,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(width: 28.w),
                  FeaturedCard(
                    onTap: onSleepMeditationTapped,
                    imgUrl:
                        "https://images.pexels.com/photos/774866/pexels-photo-774866.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                  ),
                  SizedBox(width: 28.w),
                  FeaturedCard(
                    onTap: onSleepMeditationTapped,
                    imgUrl:
                        "https://images.pexels.com/photos/3262911/pexels-photo-3262911.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                  ),
                  SizedBox(width: 28.w),
                  DiscoverCard(
                    tag: "sleepMeditation",
                    onTap: onSleepMeditationTapped,
                    title: "Sleep Meditation",
                    subtitle: "7 Day Audio and Video Series",
                  ),
                  SizedBox(width: 20.w),
                  DiscoverCard(
                    onTap: onDepressionHealingTapped,
                    title: "Depression Healing",
                    subtitle: "10 Days Audio and Video Series",
                    gradientStartColor: Color(0xffFC67A7),
                    gradientEndColor: Color(0xffF6815B),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.h),
            _iklan(),
            SizedBox(height: 28.h),
            Padding(
              padding: EdgeInsets.only(left: 28.w),
              child: Text(
                "Recent",
                style: TextStyle(
                    color: Color(0xff515979),
                    fontWeight: FontWeight.w500,
                    fontSize: 14.w),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: FutureBuilder<List<PostList>>(
                future: ApiHelper().getAllMyPost(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return PostListWidget(postList: snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: const TextStyle(color: Colors.white),
                    );
                  }
                  return const CupertinoActivityIndicator();
                },
              )
            )
          ],
        ),
      ),
    );
  }

  void onSeeAllTapped() {}

  void onSleepMeditationTapped() {
    Get.to(() => DetailPage(), transition: Transition.rightToLeft);
  }

  void onDepressionHealingTapped() {}

  void onSearchIconTapped() {}
}

class PostListWidget extends StatelessWidget {
  const PostListWidget({Key? key, required this.postList}) : super(key: key);
final List<PostList> postList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: postList.length,
      itemBuilder: (context, length){
        return PostCard(
          onTap: (){},
          onTapLike: (){},
          imgUrl:
          "https://images.pexels.com/photos/3262911/pexels-photo-3262911.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
          title: "Smile Woman",
          author: "Null Photograph",
          captions: "Something difeirent print('');",
          like: "242",
          comments: "67",
        );
      },
    );
  }
}
