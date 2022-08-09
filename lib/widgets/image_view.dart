import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_color.dart';

class ImageView extends StatelessWidget {
  final String? url;
  double height;
  double width;
  ImageView({Key? key, this.url, this.width = 0.0, this.height = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(url);
    return Container(
      height: height != 0.0 ? height : null,
      width: width != 0.0 ? width : null,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0.r),
        border: Border.all(
          color: AppColors.borderColor,
          width: 1.5,
        ),
      ),
      child: FadeInImage(
          placeholder: const AssetImage('assets/icons/placeHolder.png'),
          image: FileImage(
            File(url ?? ""),
          ), //NetworkImage(url ?? ''),
          imageErrorBuilder: (context, error, stackTrace) {
            return Image.asset('assets/icons/placeHolder.png',
                width: width != 0.0 ? width : null,
                height: height != 0.0 ? height : null);
          },
          fit: BoxFit.cover,
          width: width != 0.0 ? width : null,
          height: height != 0.0 ? height : null),
    );
  }
}
