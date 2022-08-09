import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_color.dart';
import '../../constants/text_font_style.dart';
import '../../constants/ui_helpers.dart';
import '../../helpers/table_model/table_item.dart';
import '../../widgets/popup_number_widget.dart';

class Avaliacao extends StatefulWidget {
  const Avaliacao({Key? key}) : super(key: key);

  @override
  State<Avaliacao> createState() => _AvaliacaoState();
}

class _AvaliacaoState extends State<Avaliacao> {
  TextEditingController numberController = TextEditingController();

  List<Item> items = [];

  @override
  void initState() {
    setState(() {
      items = <Item>[];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: (ScreenUtil().screenWidth < 600)
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lista de lojas',
                  style: TextFontStyle.headline1BoldStyle,
                  textAlign: TextAlign.left,
                ),
                UIHelper.verticalSpaceSmall,
                Text(
                  'Aqui pode ver a lista de lojas',
                  style: TextFontStyle.headline1RegularStyle,
                ),
                UIHelper.verticalSpaceSmall,
                Row(
                  children: [
                    //DropDown PopUp
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      height: 30.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: AppColors.borderColor, width: 0.5)),
                      child: PopupNumberWidget(
                        number: numberController,
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Text(
                      'Entries',
                      style: TextFontStyle.headline2RegularStyle,
                    ),
                    const Spacer(),
                    Container(
                      height: 35.h,
                      width: 150.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(
                              color: AppColors.borderColor, width: 0.5.h)),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.search,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceSmall,
                //Table
                Row(
                  children: [
                    //DataTable
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: AppColors.scaffoldColor),
                      child: DataTable(
                        columnSpacing: .06.sw,
                        dataRowHeight: 20.h,
                        horizontalMargin: 0,
                        dividerThickness: 0,
                        dataTextStyle: TextFontStyle.headline2RegularStyle,
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text('Avaliador',
                                style: TextFontStyle.tableHeader,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left),
                          ),
                          DataColumn(
                            label: Text('Avaliação',
                                style: TextFontStyle.tableHeader,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left),
                          ),
                          DataColumn(
                            label: Text('Rating',
                                style: TextFontStyle.tableHeader,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left),
                          ),
                        ],
                        rows: items
                            .map((items) => DataRow(cells: [
                                  DataCell(Text(items.encomenda)),
                                  DataCell(Text(items.entrega)),
                                  DataCell(Text(items.criado)),
                                ]))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium,
                UIHelper.customDivider(),
                UIHelper.verticalSpaceMedium,
                //No data
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No data available in table',
                      style: TextFontStyle.subtitle1RegularStyle,
                    )
                  ],
                ),
                UIHelper.verticalSpaceMedium,

                Row(
                  children: [
                    Text(
                      'Showing 0 to 0 of 0 entries',
                      style: TextFontStyle.subtitle1BoldStyle,
                    ),
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.disabledColor, width: 0.5),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: IntrinsicHeight(
                        child: Row(children: [
                          InkWell(
                            child: Icon(
                              Icons.arrow_left_sharp,
                              size: 30.sp,
                              color: AppColors.primaryColor,
                            ),
                            onTap: () {},
                          ),
                          const VerticalDivider(
                            color: AppColors.disabledColor,
                            thickness: 1,
                          ),
                          Text(
                            '1',
                            style: TextFontStyle.subtitle1RegularStyle,
                          ),
                          const VerticalDivider(
                            color: AppColors.disabledColor,
                            thickness: 1,
                          ),
                          InkWell(
                            child: Icon(
                              Icons.arrow_right_sharp,
                              size: 30.sp,
                              color: AppColors.primaryColor,
                            ),
                            onTap: () {},
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceSmall,
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lista de lojas',
                  style: TextFontStyle.headline1BoldStyle,
                  textAlign: TextAlign.left,
                ),
                UIHelper.verticalSpaceSmall,
                Text(
                  'Aqui pode ver a lista de lojas',
                  style: TextFontStyle.headline1RegularStyle,
                ),
                UIHelper.verticalSpaceSmall,
                Row(
                  children: [
                    //DropDown PopUp
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.w,
                      ),
                      height: 30.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                              color: AppColors.borderColor, width: 0.5)),
                      child: PopupNumberWidget(
                        number: numberController,
                      ),
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Text(
                      'Entries',
                      style: TextFontStyle.headline2RegularStyle,
                    ),
                    const Spacer(),
                    Container(
                      height: 35.h,
                      width: 250.w,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          border: Border.all(
                              color: AppColors.borderColor, width: 0.5.h)),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.search,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceSmall,
                //Table
                Row(
                  children: [
                    //DataTable
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: AppColors.scaffoldColor),
                      child: DataTable(
                        columnSpacing: 200.w,
                        dataRowHeight: 20.h,
                        horizontalMargin: 0,
                        dividerThickness: 0,
                        dataTextStyle: TextFontStyle.headline2RegularStyle,
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text('Avaliador',
                                style: TextFontStyle.tableHeader,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left),
                          ),
                          DataColumn(
                            label: Text('Avaliação',
                                style: TextFontStyle.tableHeader,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left),
                          ),
                          DataColumn(
                            label: Text('Rating',
                                style: TextFontStyle.tableHeader,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left),
                          ),
                        ],
                        rows: items
                            .map((items) => DataRow(cells: [
                                  DataCell(Text(items.encomenda)),
                                  DataCell(Text(items.entrega)),
                                  DataCell(Text(items.criado)),
                                ]))
                            .toList(),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceMedium,
                UIHelper.customDivider(),
                UIHelper.verticalSpaceMedium,
                //No data
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'No data available in table',
                      style: TextFontStyle.subtitle1RegularStyle,
                    )
                  ],
                ),
                UIHelper.verticalSpaceMedium,

                Row(
                  children: [
                    Text(
                      'Showing 0 to 0 of 0 entries',
                      style: TextFontStyle.subtitle1BoldStyle,
                    ),
                    const Spacer(),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.disabledColor, width: 0.5),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: IntrinsicHeight(
                        child: Row(children: [
                          InkWell(
                            child: Icon(
                              Icons.arrow_left_sharp,
                              size: 30.sp,
                              color: AppColors.primaryColor,
                            ),
                            onTap: () {},
                          ),
                          const VerticalDivider(
                            color: AppColors.disabledColor,
                            thickness: 1,
                          ),
                          Text(
                            '1',
                            style: TextFontStyle.subtitle1RegularStyle,
                          ),
                          const VerticalDivider(
                            color: AppColors.disabledColor,
                            thickness: 1,
                          ),
                          InkWell(
                            child: Icon(
                              Icons.arrow_right_sharp,
                              size: 30.sp,
                              color: AppColors.primaryColor,
                            ),
                            onTap: () {},
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
                UIHelper.verticalSpaceSmall,
              ],
            ),
    );
  }
}
