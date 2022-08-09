import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import '/helpers/all_routes.dart';
import '/helpers/navigation_service.dart';
import '/widgets/appbar_widget.dart';
import '../constants/app_color.dart';
import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../constants/ui_helpers.dart';
import '../networks/api_acess.dart';
import '../widgets/delete_dilouge_widget.dart';
import '../widgets/inkwell_button.dart';
import '../widgets/lebel_text_button.dart';
import '../widgets/plus_button_dilouge_widget.dart';
import '../widgets/radius_dilouge_widget.dart';

class LojasScreen extends StatefulWidget {
  const LojasScreen({Key? key}) : super(key: key);

  @override
  State<LojasScreen> createState() => _LojasScreenState();
}

class _LojasScreenState extends State<LojasScreen> {
  final storage = GetStorage();
  final TextEditingController numberController = TextEditingController();
  List<dynamic> items = [];
  List<dynamic> deliverBoyList = [];
  List<dynamic> shopdeliverBoyList = [];

  @override
  void initState() {
    getShopListRXobj.getShopListData.listen(
      (shopData) {
        if (shopData != null && shopData['data'] != null) {
          dynamic shop = shopData['data'];
          setState(() {
            items.add(shop);
          });
        }
      },
    );

    getDeliveyBoyRXobj.getGetDeliveyBoyData.listen((deliVeryBoy) {
      if (deliVeryBoy != null && deliVeryBoy['data'] != null) {
        deliverBoyList = deliVeryBoy['data']['deliveryMan'];
      }
    });

    getShopDeliveyBoyRXobj.getGetShopDeliveyBoyData.listen((shopDeliveryBoy) {
      if (shopDeliveryBoy != null && shopDeliveryBoy['data'] != null) {
        shopdeliverBoyList = shopDeliveryBoy['data'];
      }
    });

    super.initState();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lista de lojas',
                    style: TextFontStyle.headline1BoldStyle,
                    textAlign: TextAlign.left,
                  ),
                  (storage.read(kKeyShopID) == null)
                      ? LabelTextButton(
                          width: 200.w,
                          color: AppColors.headLine2Color,
                          onCallBack: () {
                            NavigationService.navigateTo(
                                Routes.contactoEnderco);
                          },
                          text: 'Criar loja',
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 15.sp,
                          ),
                        )
                      : Text(""),
                ],
              ),
              UIHelper.verticalSpaceSmall,
              Text(
                'Aqui pode ver a lista de lojas',
                style: TextFontStyle.headline1RegularStyle,
              ),
              UIHelper.verticalSpaceSmall,
              UIHelper.verticalSpaceSmall,
              (ScreenUtil().screenWidth <= 599)
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (_, index) {
                        return Container(
                          width: double.infinity,
                          child: Card(
                            elevation: 3.0,
                            child: Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Nome do Menu',
                                            style: TextFontStyle.mobileBold,
                                          ),
                                          Text(
                                            items[index]['name'],
                                            style: TextFontStyle.mobileBold
                                                .copyWith(
                                                    color: AppColors
                                                        .disabledColor),
                                          ),
                                          UIHelper.verticalSpaceSmall,
                                          Text(
                                            'Saldo',
                                            style: TextFontStyle.mobileBold,
                                          ),
                                          Text(
                                            items[index]['balance'],
                                            style: TextFontStyle.mobileNormal
                                                .copyWith(
                                                    color: AppColors
                                                        .disabledColor),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            child: Image.network(
                                              items[index]['featured_image'],
                                              fit: BoxFit.cover,
                                              width: 80.h,
                                              height: 80.h,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpaceMedium,
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Comissão por encomenda (%)',
                                            style: TextFontStyle.mobileBold,
                                          ),
                                          Text(
                                            items[index]['admin_commission'],
                                            style: TextFontStyle.mobileNormal
                                                .copyWith(
                                                    color: AppColors
                                                        .disabledColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpaceMedium,
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Estado',
                                            style: TextFontStyle.mobileBold,
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w, vertical: 3.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: items[index]['status'] ==
                                                        1
                                                    ? AppColors.activeColor
                                                    : AppColors.inactiveColor),
                                            child: Text(
                                              items[index]['status'] == 1
                                                  ? "Active"
                                                  : "Inactive",
                                              style: TextFontStyle.smallText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpaceMedium,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWellButton(
                                        icon: AssetIcons.arrowForward,
                                        height: 20.h,
                                        width: 20.h,
                                        onCallBack: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return radiusDialouge(context);
                                              });
                                        },
                                      ),
                                      UIHelper.horizontalSpaceSmall,
                                      InkWellButton(
                                        icon: AssetIcons.add,
                                        height: 20.h,
                                        width: 20.h,
                                        onCallBack: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return plusButtonDialouge(
                                                    context,
                                                    deliverBoyList,
                                                    shopdeliverBoyList);
                                              });
                                        },
                                      ),
                                      UIHelper.horizontalSpaceSmall,
                                      InkWellButton(
                                        icon: AssetIcons.edit,
                                        height: 20.h,
                                        width: 20.h,
                                        onCallBack: () async {
                                          await getShopRXobj.fetchShopData();
                                          NavigationService.navigateTo(
                                              Routes.contactoEnderco);
                                        },
                                      ),
                                      UIHelper.horizontalSpaceSmall,
                                      // InkWellButton(
                                      //   icon: AssetIcons.minus,
                                      //   height: 20.h,
                                      //   width: 20.h,
                                      //   onCallBack: () async {
                                      //     await showDialog(
                                      //         context: context,
                                      //         builder: (BuildContext context) {
                                      //           return deleteButtonDialouge(
                                      //               context);
                                      //         });
                                      //   },
                                      // ),
                                    ],
                                  ),
                                  UIHelper.verticalSpaceMedium,
                                ],
                              ),
                            ),
                          ),
                        );
                      })
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: AppColors.scaffoldColor),
                        child: DataTable(
                          columnSpacing: .08.sw,
                          dataRowHeight: 100.h,
                          horizontalMargin: 0,
                          dividerThickness: 0,
                          dataTextStyle: TextFontStyle.headline2RegularStyle,
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text('Imagem',
                                  style: TextFontStyle.tableHeader,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left),
                            ),
                            DataColumn(
                              label: Text('Nome',
                                  style: TextFontStyle.tableHeader,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left),
                            ),
                            DataColumn(
                              label: Text('Saldo',
                                  style: TextFontStyle.tableHeader,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left),
                            ),
                            DataColumn(
                              label: Text('Comissão por encomenda (%)',
                                  style: TextFontStyle.tableHeader,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left),
                            ),
                            DataColumn(
                              label: Text('Estado',
                                  style: TextFontStyle.tableHeader,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left),
                            ),
                            DataColumn(
                              label: Text('Ação',
                                  style: TextFontStyle.tableHeader,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left),
                            ),
                          ],
                          rows: (items.isNotEmpty && items != [])
                              ? items
                                  .map((items) => DataRow(cells: [
                                        DataCell(SizedBox(
                                          width: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Image.network(
                                              items['featured_image'],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                                        DataCell(Text(items!['name'])),
                                        DataCell(Text(items!['balance'])),
                                        DataCell(
                                            Text(items!['admin_commission'])),
                                        DataCell(
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.w, vertical: 3.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                                color: items!['status'] == 1
                                                    ? AppColors.activeColor
                                                    : AppColors.inactiveColor),
                                            child: Text(
                                              items['status'] == 1
                                                  ? "Active"
                                                  : "Inactive",
                                              style: TextFontStyle.smallText,
                                            ),
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWellButton(
                                                icon: AssetIcons.arrowForward,
                                                onCallBack: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return radiusDialouge(
                                                            context);
                                                      });
                                                },
                                              ),
                                              UIHelper.horizontalSpaceSmall,
                                              InkWellButton(
                                                icon: AssetIcons.add,
                                                onCallBack: () async {
                                                  await showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return plusButtonDialouge(
                                                            context,
                                                            deliverBoyList,
                                                            shopdeliverBoyList);
                                                      });
                                                },
                                              ),
                                              UIHelper.horizontalSpaceSmall,
                                              InkWellButton(
                                                icon: AssetIcons.edit,
                                                onCallBack: () {
                                                  NavigationService.navigateTo(
                                                      Routes.contactoEnderco);
                                                },
                                              ),
                                              UIHelper.horizontalSpaceSmall,
                                              // InkWellButton(
                                              //   icon: AssetIcons.minus,
                                              //   onCallBack: () async {
                                              //     await showDialog(
                                              //         context: context,
                                              //         builder: (BuildContext
                                              //             context) {
                                              //           return deleteButtonDialouge(
                                              //               context);
                                              //         });
                                              //   },
                                              // ),
                                            ],
                                          ),
                                        ),
                                      ]))
                                  .toList()
                              : [],
                        ),
                      ),
                    ),
              UIHelper.verticalSpaceMedium,
              UIHelper.verticalSpaceMedium,
              UIHelper.customDivider(),
              UIHelper.verticalSpaceSmall,
            ],
          ),
        ),
      ),
    );
  }
}
