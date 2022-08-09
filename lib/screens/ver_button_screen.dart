import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/text_font_style.dart';
import '/networks/api_acess.dart';
import '/widgets/appbar_widget.dart';

import '../constants/app_color.dart';
import '../constants/ui_helpers.dart';
import '../helpers/table_model/balace_dec.dart';
import '../helpers/table_model/table_item.dart';
import '../widgets/popup_number_widget.dart';

class VerButtonScreen extends StatefulWidget {
  const VerButtonScreen({Key? key}) : super(key: key);

  @override
  State<VerButtonScreen> createState() => _VerButtonScreenState();
}

class _VerButtonScreenState extends State<VerButtonScreen> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController _recordSearchController = TextEditingController();
  List<dynamic> items = [];
  int totalRec = 0;
  int startRec = 0;
  int endRec = 0;
  List<dynamic> serachList = [];
  int _page = 1;

  @override
  void initState() {
    numberController.text = '10';
    getBalanceRecRXobj.getBalanceRecData.listen((value) {
      setState(() {
        items = value['data']['balanceRecord'];
        totalRec = value['data']['total'];
        startRec = value['data']['start'];
        endRec = value['data']['end'];
      });
    });

    numberController.addListener(
      () {
        int record = int.parse(numberController.value.text);
        getBalanceRecRXobj.fetchBalanceRecData(record: record, page: _page);
      },
    );

    _recordSearchController.addListener(onSearchTextChanged);
    getBalanceRecRXobj.getBalanceRecData.first.then((value) {
      setState(() {
        items = value['data']['balanceRecord'];
        serachList = value['data']['balanceRecord'];
      });
    });

    super.initState();
  }

  onSearchTextChanged() async {
    String text = _recordSearchController.value.text;

    List<dynamic> newItems = [];

    if (text.isNotEmpty) {
      for (var detail in serachList) {
        if (detail['date'].contains(text) ||
            detail['current_balance'].contains(text) ||
            detail['change'].contains(text) ||
            detail['previous_balance'].contains(text)) newItems.add(detail);
      }
    }
    if (newItems.isNotEmpty) {
      setState(() {
        items = newItems;
      });
    }

    if (text.isEmpty) {
      setState(() {
        items = serachList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const MainAppBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
            vertical: UIHelper.kDefaulutPadding()),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Histórico de saldos',
                style: TextFontStyle.headline1BoldStyle,
                textAlign: TextAlign.left,
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                'Aqui vai a lista de balanços registados',
                style: TextFontStyle.headline1RegularStyle,
              ),
              UIHelper.verticalSpaceSmall,

              //This Row for Entries
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
                    width: (ScreenUtil().screenWidth < 600) ? 150.w : 250.w,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(
                            color: AppColors.borderColor, width: 0.5.h)),
                    child: TextFormField(
                      controller: _recordSearchController,
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: AppColors.scaffoldColor),
                  child: DataTable(
                    columnSpacing: .15.sw,
                    dataRowHeight: 25.h,
                    horizontalMargin: 0,
                    dividerThickness: 0,
                    dataTextStyle: TextFontStyle.headline2RegularStyle,
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text('Data',
                            style: TextFontStyle.tableHeader,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left),
                      ),
                      DataColumn(
                        label: Text('Saldo anterior',
                            style: TextFontStyle.tableHeader,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left),
                      ),
                      DataColumn(
                        label: Text('Tipo',
                            style: TextFontStyle.tableHeader,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left),
                      ),
                      DataColumn(
                        label: Text('Alterar valore',
                            style: TextFontStyle.tableHeader,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left),
                      ),
                      DataColumn(
                        label: Text('Saldo atual',
                            style: TextFontStyle.tableHeader,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left),
                      ),
                    ],
                    rows: items
                        .map((item) => DataRow(cells: [
                              DataCell(Text(item['date'])),
                              DataCell(Text(item['current_balance'])),
                              DataCell(Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 3.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: item['type'] == 1
                                          ? AppColors.activeColor
                                          : AppColors.debitHighliteColor),
                                  child: Text(
                                    item['type'] == 1 ? "Credit" : "Debit",
                                    style: TextFontStyle.smallText,
                                  ))),
                              DataCell(Text(item['change'])),
                              DataCell(Text(item['previous_balance'])),
                            ]))
                        .toList(),
                  ),
                ),
              ),

              UIHelper.verticalSpaceMedium,
              UIHelper.customDivider(),
              UIHelper.verticalSpaceMedium,
              //No data
              if (items.isEmpty)
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
                    'Showing $startRec to $endRec of $totalRec entries',
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
                          onTap: () {
                            if (_page >= 2) {
                              setState(() {
                                _page -= 1;
                                int record =
                                    int.parse(numberController.value.text);
                                getBalanceRecRXobj.fetchBalanceRecData(
                                  record: record,
                                  page: _page,
                                );
                              });
                            }
                          },
                        ),
                        const VerticalDivider(
                          color: AppColors.disabledColor,
                          thickness: 1,
                        ),
                        Text(
                          _page.toString(),
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
                          onTap: () {
                            int record = int.parse(numberController.value.text);
                            if (items.length == record) {
                              setState(() {
                                _page += 1;
                                getBalanceRecRXobj.fetchBalanceRecData(
                                  record: record,
                                  page: _page,
                                );
                              });
                            } else {
                              const snackBar = SnackBar(
                                content: Text('No more records to show'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                        ),
                      ]),
                    ),
                  ),
                ],
              ),
              UIHelper.verticalSpaceSmall,
              UIHelper.verticalSpaceSmall,

              UIHelper.verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }
}
