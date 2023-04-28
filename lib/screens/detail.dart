import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../components/icons.dart';
import '../components/svg_asset.dart';
import '../components/ad_helper.dart';
import '../helper/api_helper.dart';
import '../helper/comment.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {Key? key,
      required this.uuid,
      required this.author,
      required this.captions,
      required this.photo_url,
      required this.like,
      required this.comment})
      : super(key: key);
  final String uuid, author, captions, photo_url, like, comment;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool? isHeartIconTapped = false;
  BannerAd? _bannerAd;
  TextEditingController commentController = TextEditingController();
  late Future<List<CommentList>> _commentPost;
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
    _commentPost = ApiHelper().getAllPostComment(widget.uuid);
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
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 66.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Hero(
                    tag: "Author",
                    child: Material(
                      color: Colors.transparent,
                      child: Text(widget.author!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 34.w,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 28.w),
                  child: Text(
                    "Like " + widget.like + ", Comments " + widget.comment,
                    style: TextStyle(
                        color: const Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w),
                  ),
                ),
                SizedBox(height: 25.h),
                SizedBox(
                  height: 279.w,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(width: 28.w),
                      CachedNetworkImage(
                        imageUrl: widget.photo_url,
                        httpHeaders: const {'Connection': 'keep-alive'},
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                const CupertinoActivityIndicator(
                                    color: Colors.white70),
                        imageBuilder: (context, imgProvider) => Container(
                          height: 280.w,
                          width: 320.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: imgProvider,
                                fit: BoxFit.cover,
                              )),
                        ),
                        errorWidget: (context, url, error) {
                          print(error);
                          return const Icon(Icons.error, color: Colors.red);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32.h),
                Padding(
                  padding:
                      EdgeInsets.only(left: 28.w, right: 28.w, bottom: 20.h),
                  child: Text(
                    widget.captions,
                    style: TextStyle(
                        color: const Color(0xffffffff).withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                        fontSize: 16.w),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20.w, right: 20.w, bottom: 5.h),
                  child: _iklan(),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding:
                      EdgeInsets.only(left: 20.w, right: 20.w, bottom: 5.h),
                  child: FutureBuilder<List<CommentList>>(

                    future: _commentPost,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CommentListWidget(commentList: snapshot.data!);
                      } else if (snapshot.hasError) {
                        return Text(
                          '${snapshot.error}',
                          style: const TextStyle(color: Colors.white),
                        );
                      }
                      return const CupertinoActivityIndicator();
                    },
                  ),
                ),
                SizedBox(height: 45.h)
              ],
            ),
            // header
            Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: const Color(0xff121421),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 22.w, right: 22.w, top: 20.h, bottom: 10.h),
                    child: Material(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(360),
                            onTap: onBackIconTapped,
                            child: Container(
                              height: 35.w,
                              width: 35.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                              ),
                              child: Center(
                                child: SvgAsset(
                                  assetName: AssetName.back,
                                  height: 20.w,
                                  width: 20.w,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            borderRadius: BorderRadius.circular(360),
                            onTap: onHeartIconTapped,
                            child: Container(
                              height: 35.w,
                              width: 35.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(360),
                              ),
                              child: Center(
                                child: SvgAsset(
                                  assetName: AssetName.heart,
                                  height: 24.w,
                                  width: 24.w,
                                  color: isHeartIconTapped!
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
            // bottom comment post
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          maxLines: 1,
                          minLines: 1,
                          controller: commentController,
                          decoration: const InputDecoration(
                              hintText: "Write a comment for this post...",
                              border: InputBorder.none),
                        ),
                      ),
                      Expanded(
                          child: MaterialButton(
                        onPressed: () async {
                          await ApiHelper().publishComment(
                              commentController.text,
                              widget.uuid, context
                          );
                          setState(() {
                            _commentPost = ApiHelper().getAllPostComment(widget.uuid);
                            commentController.text = "";
                          });

                        },
                        child: const Text("Post",
                            style: TextStyle(color: Colors.blueAccent)),
                      ))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  void onStartButtonPressed() {}

  void onBackIconTapped() {
    Get.back();
  }

  void onHeartIconTapped() {
    setState(() {
      isHeartIconTapped = !isHeartIconTapped!;
    });
  }
}

class CommentListWidget extends StatelessWidget {
  const CommentListWidget({Key? key, required this.commentList})
      : super(key: key);
  final List<CommentList> commentList;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: commentList.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            borderRadius: BorderRadius.circular(5.0)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                commentList[index].name,
                style: const TextStyle(
                  fontSize: 16.0,
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              Text(
                commentList[index].comment,
                softWrap: true,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.normal),
              ),
              Text(
                commentList[index].time,
                style: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
