import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'svg_asset.dart';

import 'icons.dart';

class PostCard extends StatelessWidget {
  final Function? onTap, onTapLike;
  final String? imgUrl, author, like, comments, captions;

  const PostCard(
      {Key? key, this.onTap, this.imgUrl, this.author, this.like, this.captions, this.onTapLike, this.comments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          InkWell(
            onTap: () => onTap!(),
            borderRadius: BorderRadius.circular(26),
            child: CachedNetworkImage(
              imageUrl: imgUrl!,
              httpHeaders: const {
                'Connection': 'keep-alive'
              },
              progressIndicatorBuilder: (context, url, downloadProgress) => const CupertinoActivityIndicator(color: Colors.white70),
              imageBuilder: (context, imgProvider) => Container(
                height: 176.w,
                width: 305.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                    image: imgProvider,
                    fit: BoxFit.cover,
                  )
                ),
              ),
              errorWidget: (context, url, error) {
                print(error);
                return Icon(Icons.error, color: Colors.red);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20.w, top: 10.h, right: 20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () => onTapLike!(),
                      child: Column(
                        children: [
                          const Icon(EvaIcons.heartOutline,color: Colors.white,),
                          Text(like!, style: const TextStyle(
                            color: Colors.white,
                          ),)
                        ],
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Column(
                      children: [
                        const Icon(EvaIcons.messageCircleOutline, color: Colors.white,),
                        Text(comments!, style: const TextStyle(
                          color: Colors.white,
                        ),)
                      ],
                    ),
                    SizedBox(width: 15.w,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(author!, style: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              overflow: TextOverflow.clip
                          ),),
                          Text(captions!, style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 11,
                            overflow: TextOverflow.ellipsis
                          ),)
                        ],
                      ),
                    )
                  ],
                ),

              ],
            ),
          ),
          SizedBox(height: 10.h,)
        ],
      ),
    );
  }

}
