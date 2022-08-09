import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '/constants/app_color.dart';
import '/helpers/all_routes.dart';
import '/helpers/navigation_service.dart';
import '/helpers/table_model/food_options_id.dart';
import '/widgets/appbar_widget.dart';

import '../constants/app_constants.dart';
import '../constants/text_font_style.dart';
import '../constants/ui_helpers.dart';
import '../helpers/di.dart';
import '../helpers/table_model/order_type.dart';
import '../helpers/table_model/table_item.dart';
import '../networks/api_acess.dart';
import '../widgets/custom_button.dart';
import '../widgets/custome_textfield.dart';
import '../widgets/inkwell_button.dart';
import '../widgets/lebel_text_button.dart';
import '../widgets/popup_number_widget.dart';

class Produtos extends StatefulWidget {
  const Produtos({Key? key}) : super(key: key);

  @override
  State<Produtos> createState() => _ProdutosState();
}

class _ProdutosState extends State<Produtos> {
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
    _recordSearchController.addListener(onSearchTextChanged);
    getItemListRXobj.getItemListData.listen((value) {
      setState(() {
        items = value['data']['productList']['data'];
        totalRec = value['data']['total'];
        startRec = value['data']['start'];
        endRec = value['data']['end'];
      });
    });

    numberController.addListener(
      () {
        int record = int.parse(numberController.value.text);
        getItemListRXobj.fetchItemListData(record: record, page: _page);
      },
    );

    getItemListRXobj.getItemListData.first.then((value) {
      setState(() {
        items = value['data']['productList']['data'];
        serachList = value['data']['productList']['data'];
      });
    });
    super.initState();
  }

  onSearchTextChanged() async {
    String text = _recordSearchController.value.text;

    List<dynamic> newItems = [];

    if (text.isNotEmpty) {
      for (var detail in serachList) {
        if (detail['name'].contains(text)) newItems.add(detail);
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
                    LabelTextButton(
                      width: .48.sw,
                      icon: SvgPicture.asset(
                        AssetIcons.buttonPlusIcon,
                      ),
                      text: 'Criar Produto',
                      onCallBack: () {
                        locator<FoodId>().setFoodId = null;
                        getProductShowRxobj.clean();
                        NavigationService.navigateTo(Routes.produtosPenIcon);
                      },
                    ),
                    UIHelper.verticalSpaceSmall,
                    //Search Bar
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

                        Text(
                          'Entries',
                          style: TextFontStyle.headline2RegularStyle,
                        ),
                        const Spacer(),
                        Container(
                          height: 35.h,
                          width:
                              (ScreenUtil().screenWidth < 600) ? 150.w : 250.w,
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
                    UIHelper.verticalSpaceMedium,

                    (ScreenUtil().screenWidth < 600)
                        ? ListView.separated(
                            separatorBuilder: (_, index) =>
                                UIHelper.verticalSpaceMedium,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (_, index) {
                              return Card(
                                elevation: 3.0,
                                child: Padding(
                                  padding: EdgeInsets.all(10..w),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Name',
                                                style: TextFontStyle.mobileBold,
                                              ),
                                              SizedBox(
                                                width: .6.sw,
                                                child: Text(
                                                  items[index]['name'],
                                                  overflow: TextOverflow.fade,
                                                  style: TextFontStyle
                                                      .mobileBold
                                                      .copyWith(
                                                          color: AppColors
                                                              .disabledColor),
                                                ),
                                              ),
                                              UIHelper.verticalSpaceSmall,
                                              //Active Status
                                              Text(
                                                'Estado',
                                                style: TextFontStyle.mobileBold,
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w,
                                                    vertical: 3.h),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: items[index]
                                                                ['status'] ==
                                                            1
                                                        ? AppColors.activeColor
                                                        : AppColors
                                                            .inactiveColor),
                                                child: Text(
                                                  items[index]['status'] == 1
                                                      ? "Active"
                                                      : "Inactive",
                                                  style:
                                                      TextFontStyle.smallText,
                                                ),
                                              ),
                                            ],
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.r),
                                            child: Image.network(
                                              items[index]['image_full_path'],
                                              height: 80.h,
                                              width: 80.h,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpaceMedium,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Ação',
                                            style: TextFontStyle.mobileBold,
                                          ),
                                          InkWellButton(
                                            icon: AssetIcons.edit,
                                            height: 20.h,
                                            width: 20.h,
                                            onCallBack: () async {
                                              int foodId =
                                                  locator<FoodId>().setFoodId =
                                                      items[index]['id'];
                                              await getProductShowRxobj
                                                  .fetchProductShowData(
                                                      foodId.toString());
                                              await showPostProductAddonRxobj
                                                  .fetchShowPostProductAddon(
                                                      foodId.toString(),
                                                      record: 10,
                                                      page: 1);
                                              // NavigationService.goBack;
                                              NavigationService.navigateTo(
                                                  Routes.produtosPenIcon);
                                            },
                                          ),
                                        ],
                                      ),
                                      UIHelper.verticalSpaceMedium,
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Theme(
                              data: Theme.of(context).copyWith(
                                  dividerColor: AppColors.scaffoldColor),
                              child: DataTable(
                                columnSpacing:
                                    MediaQuery.of(context).orientation ==
                                            Orientation.portrait
                                        ? .22.sw
                                        : .24.sw,
                                headingTextStyle:
                                    TextFontStyle.tableHeader.copyWith(
                                  color: const Color(0xFF8D949B),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                ),
                                headingRowColor: MaterialStateProperty.all(
                                    const Color(0xFFDEE2E6)),
                                dataRowHeight: 50,
                                horizontalMargin: 10,
                                dividerThickness: 5,
                                dataTextStyle: TextFontStyle.headline2BoldStyle,
                                border: TableBorder(
                                  horizontalInside: BorderSide.lerp(
                                      const BorderSide(color: Colors.black12),
                                      const BorderSide(color: Colors.black12),
                                      10),
                                ),
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
                                rows: items
                                    .map((items) => DataRow(cells: [
                                          DataCell(SizedBox(
                                            width: 50,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Image.network(
                                                  items['image_full_path']),
                                            ),
                                          )),
                                          DataCell(Text(items['name'])),
                                          DataCell(
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 3.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  color: items['status'] == 1
                                                      ? AppColors.activeColor
                                                      : AppColors
                                                          .inactiveColor),
                                              child: items['status'] == 1
                                                  ? Text(
                                                      'Active',
                                                      style: TextFontStyle
                                                          .smallText,
                                                    )
                                                  : Text(
                                                      'Inactive',
                                                      style: TextFontStyle
                                                          .smallText,
                                                    ),
                                            ),
                                          ),
                                          DataCell(Row(
                                            children: [
                                              InkWellButton(
                                                icon: AssetIcons.edit,
                                                onCallBack: () async {
                                                  int foodId = locator<FoodId>()
                                                      .setFoodId = items['id'];
                                                  await getProductShowRxobj
                                                      .fetchProductShowData(
                                                          foodId.toString());
                                                  await showPostProductAddonRxobj
                                                      .fetchShowPostProductAddon(
                                                          foodId.toString(),
                                                          record: 10,
                                                          page: 1);
                                                  // NavigationService.goBack;
                                                  NavigationService.navigateTo(
                                                      Routes.produtosPenIcon);
                                                },
                                              ),
                                              UIHelper.horizontalSpaceSmall,
                                            ],
                                          )),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.h),
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
                                      int record = int.parse(
                                          numberController.value.text);
                                      getItemListRXobj.fetchItemListData(
                                          record: record, page: _page);
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
                                  int record =
                                      int.parse(numberController.value.text);
                                  if (items.length == record) {
                                    setState(() {
                                      _page += 1;
                                      getItemListRXobj.fetchItemListData(
                                          record: record, page: _page);
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Aqui pode ver a lista de lojas',
                          style: TextFontStyle.headline1RegularStyle,
                        ),
                        LabelTextButton(
                          width: .25.sw,
                          icon: SvgPicture.asset(
                            AssetIcons.buttonPlusIcon,
                          ),
                          text: 'Criar Produto',
                          onCallBack: () {
                            locator<FoodId>().setFoodId = null;
                            getProductShowRxobj.clean();
                            NavigationService.navigateTo(
                                Routes.produtosPenIcon);
                          },
                        ),
                      ],
                    ),
                    UIHelper.verticalSpaceSmall,
                    //Search Bar
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: AppColors.scaffoldColor),
                        child: DataTable(
                          columnSpacing: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? .22.sw
                              : .24.sw,
                          headingTextStyle: TextFontStyle.tableHeader.copyWith(
                            color: const Color(0xFF8D949B),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                          headingRowColor: MaterialStateProperty.all(
                              const Color(0xFFDEE2E6)),
                          dataRowHeight: 50,
                          horizontalMargin: 10,
                          dividerThickness: 5,
                          dataTextStyle: TextFontStyle.headline2BoldStyle,
                          border: TableBorder(
                            horizontalInside: BorderSide.lerp(
                                const BorderSide(color: Colors.black12),
                                const BorderSide(color: Colors.black12),
                                10),
                          ),
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
                          rows: items
                              .map((items) => DataRow(cells: [
                                    DataCell(SizedBox(
                                      width: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.network(
                                            items['image_full_path']),
                                      ),
                                    )),
                                    DataCell(Text(items['name'])),
                                    DataCell(
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 3.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            color: items['status'] == 1
                                                ? AppColors.activeColor
                                                : AppColors.inactiveColor),
                                        child: items['status'] == 1
                                            ? Text(
                                                'Active',
                                                style: TextFontStyle.smallText,
                                              )
                                            : Text(
                                                'Inactive',
                                                style: TextFontStyle.smallText,
                                              ),
                                      ),
                                    ),
                                    DataCell(Row(
                                      children: [
                                        InkWellButton(
                                          icon: AssetIcons.edit,
                                          onCallBack: () async {
                                            int foodId = locator<FoodId>()
                                                .setFoodId = items['id'];
                                            await getProductShowRxobj
                                                .fetchProductShowData(
                                                    foodId.toString());
                                            await showPostProductAddonRxobj
                                                .fetchShowPostProductAddon(
                                                    foodId.toString(),
                                                    record: 10,
                                                    page: 1);
                                            // NavigationService.goBack;
                                            NavigationService.navigateTo(
                                                Routes.produtosPenIcon);
                                          },
                                        ),
                                        UIHelper.horizontalSpaceSmall,
                                      ],
                                    )),
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 3.h),
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
                                      int record = int.parse(
                                          numberController.value.text);
                                      getItemListRXobj.fetchItemListData(
                                          record: record, page: _page);
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
                                  int record =
                                      int.parse(numberController.value.text);
                                  if (items.length == record) {
                                    setState(() {
                                      _page += 1;
                                      getItemListRXobj.fetchItemListData(
                                          record: record, page: _page);
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
                  ],
                ),
        ),
      ),
    );
  }
}

radiusDialouge(BuildContext context) {
  TextEditingController radiusController = TextEditingController();
  return Dialog(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),

      // height: 400.h,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 200.h, maxWidth: 400.w),
        child: Column(
          children: [
            Text(
              'Definir raio de clientes',
              style: TextFontStyle.headline1BoldStyle
                  .copyWith(color: Colors.black),
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              children: [
                Text(
                  'Intervalo de Raio (km)',
                  style: TextFontStyle.headline2BoldStyle,
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: AppColors.disabledColor.withOpacity(0.1),
                  spreadRadius: 0.5,
                  blurRadius: 7,
                  offset: const Offset(0.0, 1.0),
                ),
              ]),
              child: CustomNumberFormField(
                inputType: TextInputType.number,
                labelText: '',
                textEditingController: radiusController,
              ),
            ),
            //Gravar Button
            Row(
              children: [
                customeButton(
                    name: 'Gravar',
                    onCallBack: () {},
                    height: 30.h,
                    minWidth: 130.w,
                    borderRadius: 8.r,
                    color: AppColors.primaryColor,
                    textStyle: TextFontStyle.headline2BoldStyle
                        .copyWith(color: AppColors.white),
                    context: context),
                UIHelper.horizontalSpaceSmall,
                //Cancelar
                customeButton(
                    name: 'Cancelar',
                    onCallBack: () {},
                    height: 30.h,
                    minWidth: 130.w,
                    borderRadius: 8.r,
                    color: AppColors.headLine1Color,
                    textStyle: TextFontStyle.headline2BoldStyle
                        .copyWith(color: AppColors.white),
                    context: context),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

plusButtonDialouge(BuildContext context) {
  TextEditingController radiusController = TextEditingController();
  return Dialog(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),

      // height: 400.h,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 200.h, maxWidth: 400.w),
        child: Column(
          children: [
            Text(
              'Loja(fresh-new-shop)',
              style: TextFontStyle.headline1BoldStyle
                  .copyWith(color: Colors.black),
            ),
            UIHelper.verticalSpaceMedium,
            Row(
              children: [
                Text(
                  'Designar estafeta *',
                  style: TextFontStyle.headline2BoldStyle,
                ),
              ],
            ),
            UIHelper.verticalSpaceMedium,
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: AppColors.disabledColor.withOpacity(0.1),
                  spreadRadius: 0.5,
                  blurRadius: 7,
                  offset: const Offset(0.0, 1.0),
                ),
              ]),
              child: CustomNumberFormField(
                inputType: TextInputType.number,
                labelText: '',
                textEditingController: radiusController,
              ),
            ),
            //Gravar Button
            Row(
              children: [
                customeButton(
                    name: 'Submeter',
                    onCallBack: () {},
                    height: 30.h,
                    minWidth: 130.w,
                    borderRadius: 8.r,
                    color: AppColors.primaryColor,
                    textStyle: TextFontStyle.headline2BoldStyle
                        .copyWith(color: AppColors.white),
                    context: context),
                UIHelper.horizontalSpaceSmall,
                //Cancelar
                customeButton(
                    name: 'Cancelar',
                    onCallBack: () {},
                    height: 30.h,
                    minWidth: 130.w,
                    borderRadius: 8.r,
                    color: AppColors.headLine1Color,
                    textStyle: TextFontStyle.headline2BoldStyle
                        .copyWith(color: AppColors.white),
                    context: context),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

deleteButtonDialouge(BuildContext context,
    {required int stausNo,
    required int page,
    required int record,
    required orderno}) {
  TextEditingController radiusController = TextEditingController();
  return Dialog(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),

      // height: 400.h,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 200.h, maxWidth: 400.w),
        child: Column(
          children: [
            SvgPicture.asset(AssetIcons.i),
            Text(
              'Are you sure?',
              style: TextFontStyle.headline1BoldStyle
                  .copyWith(color: Colors.black),
            ),
            UIHelper.verticalSpaceMedium,
            Text(
              'Do you really want to delete this ?',
              style: TextFontStyle.headline2BoldStyle,
            ),
            UIHelper.verticalSpaceMedium,

            //Gravar Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                customeButton(
                    name: 'Gravar',
                    onCallBack: () {},
                    height: 30.h,
                    minWidth: 130.w,
                    borderRadius: 8.r,
                    color: AppColors.primaryColor,
                    textStyle: TextFontStyle.headline2BoldStyle
                        .copyWith(color: AppColors.white),
                    context: context),
                UIHelper.horizontalSpaceSmall,
                //Cancelar
                customeButton(
                    name: 'Cancelar',
                    onCallBack: () {},
                    height: 30.h,
                    minWidth: 130.w,
                    borderRadius: 8.r,
                    color: AppColors.headLine1Color,
                    textStyle: TextFontStyle.headline2BoldStyle
                        .copyWith(color: AppColors.white),
                    context: context),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
