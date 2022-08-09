import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../networks/stream_cleaner.dart';
import '/constants/app_color.dart';
import '/constants/app_constants.dart';
import '/constants/text_font_style.dart';
import '/constants/ui_helpers.dart';
import '/networks/api_acess.dart';
import '/networks/rx_get_logout/rx.dart';
import '/widgets/custom_button.dart';

import '../screens/test_navigation_screen.dart';

class ProfileDialoge extends StatefulWidget {
  const ProfileDialoge({Key? key}) : super(key: key);

  @override
  State<ProfileDialoge> createState() => _ProfileDialogeState();
}

class _ProfileDialogeState extends State<ProfileDialoge> {
  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    String? _user = storage.read(kKeyUser);
    return Padding(
      padding: EdgeInsets.only(top: 100.h),
      child: Dialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.zero)),
        alignment: Alignment.topRight,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Container(
          // color: Colors.green,
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.w),
          width: 50.w,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              //ICON
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.r),
                    color: AppColors.primaryColor),
                child: SvgPicture.asset(
                  AssetIcons.shop,
                  color: AppColors.white,
                ),
              ),
              UIHelper.verticalSpaceMedium,
              Text(
                _user!,
                style: TextFontStyle.headline2RegularStyle,
              ),
              UIHelper.verticalSpaceMedium,
              UIHelper.customDivider(),
              UIHelper.verticalSpaceMedium,
              //For Profile
              // InkWell(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       SvgPicture.asset(AssetIcons.man),
              //       Expanded(
              //         flex: 8,
              //         child: Text('Definições do perfil',
              //             textAlign: TextAlign.center,
              //             style: TextFontStyle.headline2RegularStyle.copyWith(
              //                 letterSpacing: 2,
              //                 wordSpacing: 1,
              //                 color: AppColors.headLine1Color)),
              //       ),
              //       const Spacer(),
              //     ],
              //   ),
              //   onTap: () {
              //     Navigator.pop(context);
              //     // Navigator.push(
              //     //     context,
              //     //     MaterialPageRoute(
              //     //         builder: (BuildContext context) =>
              //     //             const TextNavigation()));
              //   },
              // ),
              // UIHelper.verticalSpaceMedium,
              // //For change Password
              // InkWell(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       SvgPicture.asset(AssetIcons.password),
              //       Expanded(
              //         flex: 8,
              //         child: Text('Alteração de password',
              //             textAlign: TextAlign.center,
              //             style: TextFontStyle.headline2RegularStyle.copyWith(
              //                 letterSpacing: 2,
              //                 wordSpacing: 1,
              //                 color: AppColors.headLine1Color)),
              //       ),
              //       const Spacer(),
              //     ],
              //   ),
              //   onTap: () {},
              // ),

              UIHelper.verticalSpaceMedium,
              customeButton(
                  name: 'Logout',
                  onCallBack: () async {
                    getLogOutRXobj.fetchLogoutData();
                    totalDataClean();
                  },
                  height: 40.h,
                  minWidth: MediaQuery.of(context).size.width,
                  borderRadius: 20.r,
                  color: AppColors.headLine1Color,
                  textStyle: GoogleFonts.montserrat(
                      fontSize: 14.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w800),
                  context: context)
            ],
          ),
        ),
      ),
    );
  }
}
