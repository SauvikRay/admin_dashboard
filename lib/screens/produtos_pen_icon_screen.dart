import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../helpers/all_routes.dart';
import '../helpers/navigation_service.dart';
import '../networks/api_acess.dart';
import '/constants/app_constants.dart';
import '/helpers/di.dart';
import '/helpers/table_model/food_options_id.dart';

import '../constants/app_color.dart';
import '../constants/text_font_style.dart';
import '../constants/ui_helpers.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/edit_tabs/extras_widget.dart';
import '../widgets/edit_tabs/info_basica_widget.dart';
import '../widgets/lebel_text_button.dart';
import '../widgets/edit_tabs/option_prices_widget.dart';
import 'tabs/button_pen_nome.dart';
import 'tabs/contactoandenerco.dart';
import 'tabs/horario.dart';

class ProdutosPenIcon extends StatefulWidget {
  const ProdutosPenIcon({Key? key}) : super(key: key);

  @override
  State<ProdutosPenIcon> createState() => _ProdutosPenIconState();
}

class _ProdutosPenIconState extends State<ProdutosPenIcon>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    TabController tabController = TabController(length: 3, vsync: this);

    return Scaffold(
      appBar: const MainAppBarWidget(),
      body: (ScreenUtil().screenWidth < 600)
          ? Container(
        padding: EdgeInsets.symmetric(
          horizontal: UIHelper.kDefaulutPadding(),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15.h),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Categoria de produto Adicionar/Editar',
                  style: TextFontStyle.headline1BoldStyle,
                  softWrap: true,
                ),
                UIHelper.verticalSpaceSmall,
                LabelTextButton(
                  width: .48.sw,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  onCallBack: () {},
                  text: "Lista de lojas",
                ),
                UIHelper.verticalSpaceSmall,
                LabelTextButton(
                  width: .62.sw,
                  color: AppColors.headLine1Color,
                  icon: SvgPicture.asset(AssetIcons.buttonPlusIcon),
                  onCallBack: () {},
                  text: "Criar novo produto",
                ),
                UIHelper.verticalSpaceMedium,
                Container(
                  child: TabBar(
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicatorColor: AppColors.primaryColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: tabController,
                    unselectedLabelColor: AppColors.disabledColor,
                    labelStyle: TextFontStyle.mobileNormal.copyWith(
                        color: AppColors.primaryColor,
                        fontSize: 14.sp,
                        overflow: TextOverflow.ellipsis),
                    onTap: (val) {
                      print(val);
                      // tabController.index = val - 1;
                    },
                    automaticIndicatorColorAdjustment: true,
                    isScrollable: false,
                    labelColor: AppColors.primaryColor,
                    tabs: const <Widget>[
                      Text(
                        "Info Básica",
                      ),
                      Text(
                        "Opções e preços",
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Extras",
                      ),
                    ],
                  ),
                ),
                UIHelper.verticalSpaceSmall,
                Flexible(
                  fit: FlexFit.loose,
                  child: TabBarView(
                    controller: tabController,
                    children: const <Widget>[
                      InfoBasica(),
                      OptionAndPrices(),
                      Extras(),
                    ],
                  ),
                ),
              ]),
        ),
      )
          : Container(
        padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 15.h),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: .35.sw,
                    child: Text(
                      'Categoria de produto Adicionar/Editar',
                      style: TextFontStyle.headline1BoldStyle,
                      softWrap: true,
                    ),
                  ),
                  LabelTextButton(
                    width: .28.sw,
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    onCallBack: () {
                      locator<FoodId>().setFoodId = null;
                      NavigationService.navigateTo(Routes.produtos);
                    },
                    text: "Lista de produto",
                  ),
                  LabelTextButton(
                    width: .2.sw,
                    color: AppColors.headLine1Color,
                    icon: SvgPicture.asset(AssetIcons.buttonPlusIcon),
                    onCallBack: () {
                      locator<FoodId>().setFoodId = null;
                      getProductShowRxobj.clean();
                      NavigationService.navigateTo(
                          Routes.produtosPenIcon);
                    },
                    text: "Novo ",
                  ),
                ],
              ),
              UIHelper.verticalSpaceMedium,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.disabledColor),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TabBar(
                  labelPadding: EdgeInsets.all(10.r),
                  // indicatorWeight: 15,
                  controller: tabController,
                  onTap: (val) {
                    int? id = locator<FoodId>().getFoodId;
                    if (id == null) {
                      tabController.index = 0;
                    }
                    print(val);
                    // tabController.index = val - 1;
                  },
                  automaticIndicatorColorAdjustment: true,
                  isScrollable: false,
                  labelColor: AppColors.scaffoldColor,
                  unselectedLabelColor:
                  AppColors.unselectedButtonTextColor,
                  labelStyle: TextFontStyle.buttonBoldStyle,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.disabledColor,
                  ),
                  tabs: const <Widget>[
                    Text(
                      "Info Básica",
                    ),
                    Text(
                      "Opções e preços",
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Extras",
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpaceSmall,
              Flexible(
                fit: FlexFit.loose,
                child: TabBarView(
                  controller: tabController,
                  children: const <Widget>[
                    InfoBasica(),
                    OptionAndPrices(),
                    Extras(),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
