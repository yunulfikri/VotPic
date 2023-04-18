import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ruangbawah/components/ad_helper.dart';
import 'package:ruangbawah/helper/api_helper.dart';
import 'dart:io';
import '../components/icons.dart';
import '../components/svg_asset.dart';

class PostImageScreen extends StatefulWidget {
  final File images;
  const PostImageScreen({Key? key, required this.images}) : super(key: key);
  @override
  State<PostImageScreen> createState() => _PostImageScreenState();
}

class _PostImageScreenState extends State<PostImageScreen> {
  String? imageUrl;
  BannerAd? _bannerAd;
  @override
  void initState() {
    // TODO: implement initState
    BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.mediumRectangle,
      listener: BannerAdListener(
        onAdLoaded: (ad){
          setState(() { 
            _bannerAd = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (ad, err){
          print('Failed to load a banner ad: ${err.message}')
;
          ad.dispose();
        }
      )
    ).load();
    super.initState();
    imageBackgroundUpload();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _bannerAd?.dispose();

    super.dispose();
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }
  imageBackgroundUpload()async{
    print("the progressss....................");
    String _image = widget.images!.path;
    print(_image);
    await ApiHelper().uploadPhoto(_image).then((progress){
      if (progress != "failed"){
        setState(() {
          imageUrl = progress.toString();
          _postText.text = progress.toString();
        });
        print("Upload Succes!!!!!!!!!!!");
      }else{
        print(progress);
      }
    });

  }
  postSubmit(){
    if(imageUrl != null){

    }else{
      print("Sedang progress upload");
    }
  }
  final TextEditingController _postText = TextEditingController();
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
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 22.w,
                    vertical: 5.h,
                  ),
                  height: 250.0,

                  decoration:  BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(

                      image: FileImage(widget.images),
                      fit: BoxFit.cover,

                    )
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 22.w,
                    vertical: 5.h,
                  ),

                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),

                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0
                  ),
                  child: TextField(
                    controller: _postText,

                    autofocus: true,
                    scrollPhysics: const BouncingScrollPhysics(),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "The Title? (Opsional)"
                    ),
                    style: TextField.materialMisspelledTextStyle,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 22.w,
                    vertical: 5.h,
                  ),

                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),

                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 5.0
                  ),
                  child: TextField(
                    controller: _postText,
                    minLines: 5,
                    maxLines: 20,
                    autofocus: true,
                    scrollPhysics: const BouncingScrollPhysics(),
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "What u Think?"
                    ),
                    style: TextField.materialMisspelledTextStyle,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                if(_bannerAd != null) Container(
                  width: _bannerAd!.size.width.toDouble(),
                  height: _bannerAd!.size.height.toDouble(),
                  child: AdWidget(ad: _bannerAd!,),
                )
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: const Color(0xff121421),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 22.w,
                      right: 22.w,
                      top: 20.h,
                      bottom: 10.h
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.circular(360),
                          onTap: (){
                            Get.back();
                          },
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
                          onTap: (){},
                          child: Container(
                            height: 35.w,
                            width: 35.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(360),
                            ),
                            child: const Center(
                                child: Icon(Icons.add_a_photo, color: Colors.white, size: 25.0,)
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 87.h,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    gradient: LinearGradient(
                        stops: [0,1],
                        colors: [
                          Color(0xff121421),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    )
                ),
                child: Center(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: (){},
                      child: Ink(
                        decoration: BoxDecoration(
                          color: const Color(0xff4A80F0),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          height: 56.h,
                          width: 319.w,
                          child: Center(child: Text("Post", style: TextStyle(fontSize: 16.w, fontWeight: FontWeight.bold,color: Colors.white),)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
