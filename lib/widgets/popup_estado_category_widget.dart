import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '/constants/app_color.dart';
import '/constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../provider/catpopup_status.dart';

class PopupCategoryWidget extends StatefulWidget {
  const PopupCategoryWidget(
      {Key? key, required this.textController, required this.categoryGlobalkey})
      : super(key: key);
  final TextEditingController textController;
  final GlobalKey<PopupMenuButtonState<String>> categoryGlobalkey;

  @override
  State<PopupCategoryWidget> createState() => _PopupCategoryWidgetState();
}

class _PopupCategoryWidgetState extends State<PopupCategoryWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PopUpStatus>(context);
    return GestureDetector(
      onTap: () {
        widget.categoryGlobalkey.currentState!.showButtonMenu();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Consumer<PopUpStatus>(
            builder: (context, value, child) => Text(
              value.name,
              style: TextFontStyle.popUpselectedText
                  .copyWith(color: AppColors.headLine1Color),
            ),
          ),
          PopupMenuButton<String>(
            key: widget.categoryGlobalkey,
            splashRadius: 10.r,
            icon: Icon(
              Icons.keyboard_arrow_down_sharp,
              size: 25.r,
            ),
            onSelected: (String value) {
              print(value);
              //   setState(() {
              provider.changename(value);
              widget.textController.text = value;
              //  });
            },
            color: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
            ),
            offset: const Offset(0, kToolbarHeight),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'Active',
                height: 25.h,
                child: Text(
                  'Active',
                  style: TextFontStyle.popUpselectedText,
                ),
              ),
              PopupMenuItem(
                value: 'Inactive',
                height: 25.h,
                child: Text(
                  'Inactive',
                  style: TextFontStyle.popUpselectedText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
