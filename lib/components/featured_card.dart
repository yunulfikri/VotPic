import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedCard extends StatelessWidget {
  final Function? onTap;
  final String? imgUrl;

  const FeaturedCard({Key? key, this.onTap, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
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
    );
  }
}
