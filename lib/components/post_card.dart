import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ruangbawah/components/svg_asset.dart';

import 'icons.dart';

class PostCard extends StatelessWidget {
  final Function? onTap, onTapLike;
  final String? imgUrl, author, like, comments, captions, title;

  const PostCard(
      {Key? key, this.onTap, this.imgUrl, this.author, this.like, this.captions, this.title, this.onTapLike, this.comments})
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
            child: Container(
              height: 176.w,
              width: 305.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  image: DecorationImage(
                      image: NetworkImage(imgUrl!), fit: BoxFit.cover)),

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
                          SvgAsset(
                            assetName: AssetName.heart,
                            height: 24.w,
                            width: 24.w,
                          ),
                          Text(like!, style: const TextStyle(
                            color: Colors.white,
                          ),)
                        ],
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Column(
                      children: [
                        SvgAsset(
                          assetName: AssetName.headphone,
                          height: 24.w,
                          width: 24.w,
                        ),
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
                          Text(title!, style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            overflow: TextOverflow.ellipsis
                          ),)
                        ],
                      ),
                    )
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }

}
