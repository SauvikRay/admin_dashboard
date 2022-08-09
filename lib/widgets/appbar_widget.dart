import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/constants/ui_helpers.dart';
import '/helpers/all_routes.dart';
import '/helpers/navigation_service.dart';
import '/widgets/profile_dialoge.dart';

import '../constants/app_constants.dart';
import 'option_button_widget.dart';
import 'popup_item_widget.dart';

class MainAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const MainAppBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<MainAppBarWidget> createState() => _MainAppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(100.h);
}

class _MainAppBarWidgetState extends State<MainAppBarWidget> {
  final TextEditingController languageTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    //final appBarTheme = Theme.of(context).appBarTheme;
    return AppBar(
      // title: Consumer<AppBarName>(
      //     builder: (context, value, child) => Text(value.name)),

      backgroundColor: Colors.black,
      leading: InkWell(
        onTap: () {
          NavigationService.navigateTo(Routes.loadingScreen);
        },
        child: Padding(
            padding: EdgeInsets.only(left: 10.w),
            child: SvgPicture.asset('assets/icons/splash.svg')),
      ),
      leadingWidth: (ScreenUtil().screenWidth < 600) ? 60.h : 100.h,
      toolbarHeight: 90.h,

      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // PopupWidget(
              //   language: languageTextController,
              // ),
              UIHelper.horizontalSpaceSmall,
              CircleAvatar(
                radius: 25.r,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: SvgPicture.asset(AssetIcons.shop),
                  splashRadius: 30.0.r,
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const ProfileDialoge();
                        });
                  },
                ),
              ),
              UIHelper.horizontalSpaceSmall,
              IconButton(
                icon: SvgPicture.asset(AssetIcons.seetings),
                splashRadius: 30.0.r,
                onPressed: () async {
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const OptionButtonDialoge();
                      });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
