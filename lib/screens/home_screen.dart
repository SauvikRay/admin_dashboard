import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getwidget/getwidget.dart';
import '../widgets/table_card.dart';
import '/constants/app_color.dart';
import '/constants/app_constants.dart';
import '/constants/text_font_style.dart';
import '/constants/ui_helpers.dart';
import '/helpers/all_routes.dart';
import '/helpers/navigation_service.dart';
import '/networks/api_acess.dart';
import '/widgets/appbar_widget.dart';
import '../helpers/di.dart';
import '../helpers/table_model/order_type.dart';
import '../helpers/table_model/table_item.dart';
import '../widgets/card_widget.dart';
import '../widgets/custome_table.dart';
import '../widgets/delete_dilouge_widget.dart';
import '../widgets/inkwell_button.dart';
import '../widgets/lebel_text_button.dart';
import '../widgets/loading_indicators.dart';
import '../widgets/plus_button_dilouge_widget.dart';
import '../widgets/popup_number_widget.dart';
import '../widgets/radius_dilouge_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController _recordSearchController = TextEditingController();
  OrderType order = locator<OrderType>();

  List<dynamic> items = [];
  int totalRec = 0;
  int startRec = 0;
  int endRec = 0;
  List<dynamic> serachList = [];
  int _page = 1;

  @override
  void initState() {
    numberController.text = '10';
    _recordSearchController.addListener(onSearchTextChanged);
    getDashBoardOrderListRXobj.getDashBoardOrderListData.listen((value) {
      setState(() {
        items = value['data']['orders']['data'];
        totalRec = value['data']['total'];
        startRec = value['data']['start'];
        endRec = value['data']['end'];
      });
    });

    numberController.addListener(
      () {
        int record = int.parse(numberController.value.text);
        getDashBoardOrderListRXobj.fetchDashBoardOrderListData(
            record: record, page: _page);
      },
    );

    getDashBoardOrderListRXobj.getDashBoardOrderListData.first.then((value) {
      setState(() {
        items = value['data']['orders']['data'];
        serachList = value['data']['orders']['data'];
      });
    });
    super.initState();
  }

  onSearchTextChanged() async {
    String text = _recordSearchController.value.text;

    List<dynamic> newItems = [];

    if (text.isNotEmpty) {
      for (var detail in serachList) {
        if (detail['order_code'].contains(text) ||
            detail['total_price'].contains(text) ||
            detail['change'].contains(text) ||
            detail['admin_income'].contains(text) ||
            detail['created_at'].contains(text)) newItems.add(detail);
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
//For Data Table
    // double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const MainAppBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: UIHelper.kDefaulutPadding()),
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              UIHelper.verticalSpaceMedium,
              //This For First Card

              StreamBuilder(
                  stream: getDashBoardRXobj.getDashBoardData,
                  builder: (context, AsyncSnapshot dashBoardData) {
                    if (dashBoardData.hasData) {
                      Map data = dashBoardData.data['data'];
                      return Column(
                        children: [
                          CardWidget(
                            icon: SvgPicture.asset(
                              AssetIcons.balance,
                            ),
                            numText: "${data['balance']}" ' €',
                            text: 'Balança da Cart',
                            buttonWidget: LabelTextButton(
                              onCallBack: () {
                                NavigationService.navigateTo(Routes.verButton);
                              },
                              text: 'Ver',
                              icon: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ),
                          CardWidget(
                            icon: SvgPicture.asset(
                              AssetIcons.orderslist,
                            ),
                            numText: "${data['orders']}",
                            text: 'Total Orders',
                          ),
                          CardWidget(
                            numText: "${data['foods']}",
                            text: 'Total Products',
                            icon: SvgPicture.asset(
                              AssetIcons.box,
                            ),
                          ),
                        ],
                      );
                    } else if (dashBoardData.hasError) {
                      return const SizedBox.shrink();
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height - 100,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: loadingIndicatorCircle(context: context),
                      ),
                    );
                  }),

              UIHelper.verticalSpaceMedium,
              UIHelper.verticalSpaceSmall,
              Text(
                'All Order List',
                style: TextFontStyle.headline1BoldStyle,
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                'Here goes the order list',
                style: TextFontStyle.headline1RegularStyle,
              ),
              UIHelper.verticalSpaceMedium,
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
                    width: 150.w,
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
              (ScreenUtil().screenWidth < 600)
                  ? ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (_, index) {
                        return DataCard(
                          items: items,
                          numberController: numberController,
                          page: _page,
                          index: index,
                        );
                      })

                  // Data Table
                  : CustomTable(
                      items: items,
                      numberController: numberController,
                      page: _page),
              UIHelper.verticalSpaceMedium,
              UIHelper.customDivider(),
              UIHelper.verticalSpaceLarge,
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
