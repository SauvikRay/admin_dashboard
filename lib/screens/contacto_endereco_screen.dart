import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import '/constants/app_constants.dart';
import '/constants/text_font_style.dart';
import '/constants/ui_helpers.dart';
import '/helpers/all_routes.dart';
import '/helpers/navigation_service.dart';
import '/screens/tabs/avaliacao.dart';
import '/screens/tabs/ferias.dart';
import '/screens/tabs/horario.dart';
import '/widgets/lebel_text_button.dart';

import '../constants/app_color.dart';
import '../widgets/appbar_widget.dart';
import 'tabs/button_pen_nome.dart';
import 'tabs/contactoandenerco.dart';

class ContactoEnderco extends StatefulWidget {
  const ContactoEnderco({Key? key}) : super(key: key);

  @override
  State<ContactoEnderco> createState() => _ContactoEndercoState();
}

class _ContactoEndercoState extends State<ContactoEnderco>
    with TickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    TabController tabController = TabController(length: 5, vsync: this);
    final storage = GetStorage();

    return Scaffold(
        appBar: const MainAppBarWidget(),
        body: Container(
          padding: EdgeInsets.symmetric(
              horizontal: UIHelper.kDefaulutPadding(),
              vertical: UIHelper.kDefaulutPadding()),
          child: Card(
            margin: const EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r)),
            elevation: 1.0,
            color: AppColors.white,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
              child: (ScreenUtil().screenWidth < 600)
                  ? Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          LabelTextButton(
                            width: .55.sw,
                            icon: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                            onCallBack: () {
                              NavigationService.navigateTo(Routes.lojas);
                            },
                            text: "Lista de lojas",
                          ),
                          UIHelper.verticalSpaceSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Categoria de produto Adicionar/Editar',
                                style: TextFontStyle.mobileBold,
                              ),
                            ],
                          ),
                          UIHelper.verticalSpaceMedium,
                          Container(
                            child: TabBar(
                              // indicatorWeight: 15,
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
                              onTap: (val) async {
                                String shopID = storage.read(kKeyShopID) ?? '';
                                if (shopID == '') {
                                  tabController.index = 0;
                                }
                                print(val);
                              },
                              // automaticIndicatorColorAdjustment: true,
                              // isScrollable: false,
                              labelColor: AppColors.primaryColor,

                              tabs: const [
                                Text(
                                  "Basic",
                                ),
                                Text(
                                  "Contacto & Endereço",
                                ),
                                Text(
                                  "Horario",
                                ),
                                Text(
                                  "Férias",
                                ),
                                Text(
                                  "Avaliação",
                                ),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpaceMedium,
                          Flexible(
                            fit: FlexFit.loose,
                            child: TabBarView(
                              controller: tabController,
                              children: const [
                                ButtonPenNome(),
                                Contacto(),
                                Horario(),
                                Ferias(),
                                Avaliacao(),
                              ],
                            ),
                          ),
                          UIHelper.verticalSpaceSemiLarge,
                        ])
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categoria de produto Adicionar/Editar',
                              style: TextFontStyle.headline1BoldStyle,
                            ),
                            LabelTextButton(
                              width: 200.w,
                              icon: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                              onCallBack: () {
                                NavigationService.navigateTo(Routes.lojas);
                              },
                              text: "Lista de lojas",
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
                            onTap: (val) async {
                              String shopID = storage.read(kKeyShopID) ?? '';
                              if (shopID == '') {
                                tabController.index = 0;
                              }
                              print(val);
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
                            tabs: const [
                              Text(
                                "Basic",
                              ),
                              Text(
                                "Contacto & Endereço",
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Horario",
                              ),
                              Text(
                                "Férias",
                              ),
                              Text(
                                "Avaliação",
                              ),
                            ],
                          ),
                        ),
                        UIHelper.verticalSpaceSmall,
                        Flexible(
                          fit: FlexFit.loose,
                          child: TabBarView(
                            controller: tabController,
                            children: const [
                              ButtonPenNome(),
                              Contacto(),
                              Horario(),
                              Ferias(),
                              Avaliacao(),
                            ],
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ));
  }
}
