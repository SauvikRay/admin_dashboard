import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import '/helpers/di.dart';
import '/helpers/table_model/food_options_id.dart';
import '/networks/api_acess.dart';

import '../../constants/app_color.dart';
import '../../constants/app_constants.dart';
import '../../constants/text_font_style.dart';
import '../../constants/ui_helpers.dart';
import '../../helpers/helper.dart';
import '../../provider/product_id_provider.dart';
import '../../screens/tabs/button_pen_nome.dart';
import '../custome_textfield.dart';
import '../image_view.dart';
import '../lebel_text_button.dart';
import '../popup_product_category_widget.dart';

class InfoBasica extends StatefulWidget {
  const InfoBasica({Key? key}) : super(key: key);

  @override
  State<InfoBasica> createState() => _InfoBasicaState();
}

class _InfoBasicaState extends State<InfoBasica> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController productCategoryController =
  TextEditingController();
  final TextEditingController productCategoryValueController =
  TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _descriptionShortController =
  TextEditingController();

  final _formkey = GlobalKey<FormState>();
  late String dropdownValue = 'a';
  File? imgfile;
  String? imagePath;
  Uint8List? _bytesImage;
  bool status = false;
  bool validation = false;
  String? nameValidation;
  String? selectValidation;
  String statusId = '0';
  String? img64;
  String? foodId;
  String? imgBase64Str;
  int? id;
  @override
  void initState() {
    getProductShowData();
    super.initState();
  }

  getProductShowData() {
    id = locator<FoodId>().getFoodId;
    if (id != null) {
      getProductShowRxobj.getProductShowData.first.then((value) async {
        Map data = value['data']['food'];
        Map catDatadata = value['data']['foodCategory'];
        log(data.toString());
        log(catDatadata.toString());
        imgBase64Str = await networkImageToBase64(data['image_full_path']);
        _bytesImage = const Base64Decoder().convert(imgBase64Str!);

        _nameTextController.text = data['name'];
        _descriptionController.text = data['description'];
        statusId = data['status'].toString();
        if (statusId == '1') {
          status = true;
        } else {
          status = false;
        }
        productCategoryController.text = catDatadata["name"];
        productCategoryValueController.text = catDatadata["id"].toString();
        _descriptionShortController.text = data['short_description'];
      }).then((_) {
        setState(() {});
      });
    }
  }

  void clean() {
    setState(() {
      _nameTextController.text = '';
      _descriptionController.text = '';
      status = false;
      _descriptionShortController.text = '';
      _bytesImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    final storage = GetStorage();
    String restaurantId = storage.read(kKeyShopID);
    return SingleChildScrollView(
      primary: false,
      scrollDirection: Axis.vertical,
      child: (ScreenUtil().screenWidth < 600)
          ? Column(
        children: [
          Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nome",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceSmall,
                CustomNumberFormField(
                  hintText: 'Sede Santiago Do Cacém',
                  labelText: 'a',
                  inputType: TextInputType.name,
                  fieldHeight: nameValidation != null ? 50.h : 50.h,
                  textEditingController: _nameTextController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      nameValidation = value;
                      return 'Enter The category';
                    }
                    nameValidation = null;
                    return null;
                  },
                  validation: validation,
                ),
                UIHelper.verticalSpaceMedium,
                Text(
                  "Categoria",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceSmall,
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: AppColors.borderColor, width: 0.5)),
                  child: ProductCategoryPopupWidget(
                    productCategory: productCategoryValueController,
                    value: productCategoryController.text,
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                UIHelper.verticalSpaceMedium,
                Text(
                  "Descrição longa",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceSmall,
                CustomNumberFormField(
                  fieldHeight: 60.h,
                  maxline: 50,
                  labelText: 'a',
                  inputType: TextInputType.name,
                  textEditingController: _descriptionController,
                ),
                UIHelper.verticalSpaceSemiLarge,
                Row(
                  children: [
                    FlutterSwitch(
                      width: 40.0,
                      height: 20.0,
                      valueFontSize: 20.0,
                      toggleSize: 20.0,
                      value: status,
                      borderRadius: 50.0,
                      padding: 1.0,
                      inactiveColor: Colors.white,
                      inactiveToggleColor: AppColors.disabledColor,
                      switchBorder: Border.all(
                          color: AppColors.unselectedButtonTextColor),
                      activeColor: AppColors.unselectedButtonTextColor,
                      // showOnOff: true,
                      onToggle: (val) {
                        setState(() {
                          status = val;
                          if (status == true) {
                            statusId = '1';
                          } else {
                            statusId = '0';
                          }
                        });
                      },
                    ),
                    UIHelper.horizontalSpaceSmall,
                    Text(
                      'Estado ativo',
                      style: TextFontStyle.headline2BoldStyle,
                    ),
                  ],
                ),
                // Container(
                //   alignment: Alignment.centerRight,
                //   child: Text(
                //     "Value: $statusId",
                //   ),
                // ),
                UIHelper.verticalSpaceMedium,
                UIHelper.horizontalSpaceSemiLarge,
                Text(
                  """Imagem de destaque (Tamanho máximo:2048 KB,Largura:480,Altura:300)Para redimensionar vai para https://resizeimage.net/""",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceSmall,
                GestureDetector(
                  onTap: () async {
                    FilePickerResult? result =
                    await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.image,
                    );

                    if (result != null) {
                      setState(() {
                        imgfile = File(result.files.single.path!);
                        imagePath = imgfile.toString();
                        _bytesImage = File(result.files.single.path!)
                            .readAsBytesSync();
                        imgBase64Str = base64Encode(_bytesImage!);
                        log(imagePath!.toString());
                        log(imgBase64Str.toString());
                      });
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Nenhum arquivo selecionado'),
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(snackBar);
                    }
                  },
                  child: (_bytesImage != null)
                      ? Image.memory(
                    _bytesImage!,
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.contain,
                  )
                      : ImageView(
                      url: imagePath,
                      width: double.infinity,
                      height: 200),
                ),
                UIHelper.verticalSpaceMedium,
                Text(
                  "Descrição curta",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceSmall,
                CustomNumberFormField(
                  fieldHeight: 65,
                  maxline: 10,
                  labelText: 'a',
                  inputType: TextInputType.name,
                  textEditingController: _descriptionShortController,
                ),
                UIHelper.verticalSpaceMedium,
              ],
            ),
          ),
          UIHelper.verticalSpaceMedium,
          Align(
            alignment: Alignment.centerLeft,
            child: LabelTextButton(
              icon: SvgPicture.asset(
                AssetIcons.buttonPlusIcon,
              ),
              onCallBack: () async {
                // int categoryId = int.parse(productCategory.value.text);
                log(_nameTextController.value.text);
                log(productCategoryValueController.value.text);
                log(_descriptionController.value.text);

                if (_formkey.currentState!.validate()) {
                  await postProductBasicRXobj.postProductBasicData(
                    _nameTextController.value.text,
                    productCategoryValueController.value.text,
                    _descriptionController.value.text,
                    statusId,
                    _descriptionShortController.value.text,
                    restaurantId,
                    imgBase64Str,
                    id: id.toString(),
                  );
                  await getItemListRXobj.fetchItemListData();

                  // postProductBasicRXobj.getFileData.listen((event) {
                  //   int id = event['data']['food']['id'];
                  //   locator<FoodId>().foodId = id;
                  //   // Provider.of<ProductIdProvider>(context, listen: false)
                  //   // .changeId(id);
                  //   // log(id);
                  //   // storage.write(kKeyproductID, id);
                  // });
                }
              },
              text: 'Gravar',
            ),
          )
        ],
      )
          : Column(
        children: [
          Form(
            key: _formkey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Nome",
                        style: TextFontStyle.headline2BoldStyle,
                      ),
                      UIHelper.verticalSpaceSmall,
                      CustomNumberFormField(
                        hintText: 'Sede Santiago Do Cacém',
                        labelText: 'a',
                        inputType: TextInputType.name,
                        fieldHeight: nameValidation != null ? 50.h : 50.h,
                        textEditingController: _nameTextController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            nameValidation = value;
                            return 'Enter The category';
                          }
                          nameValidation = null;
                          return null;
                        },
                        validation: validation,
                      ),
                      UIHelper.verticalSpaceMedium,
                      Text(
                        "Categoria",
                        style: TextFontStyle.headline2BoldStyle,
                      ),
                      UIHelper.verticalSpaceSmall,
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                        ),
                        height: 45.h,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                color: AppColors.borderColor,
                                width: 0.5)),
                        child: ProductCategoryPopupWidget(
                          productCategory: productCategoryValueController,
                          value: productCategoryController.text,
                        ),
                      ),
                      UIHelper.verticalSpaceMedium,
                      UIHelper.verticalSpaceMedium,
                      Text(
                        "Descrição longa",
                        style: TextFontStyle.headline2BoldStyle,
                      ),
                      UIHelper.verticalSpaceSmall,
                      CustomNumberFormField(
                        fieldHeight: 60.h,
                        maxline: 50,
                        labelText: 'a',
                        inputType: TextInputType.name,
                        textEditingController: _descriptionController,
                      ),
                      UIHelper.verticalSpaceSemiLarge,
                      Row(
                        children: [
                          FlutterSwitch(
                            width: 40.0,
                            height: 20.0,
                            valueFontSize: 20.0,
                            toggleSize: 20.0,
                            value: status,
                            borderRadius: 50.0,
                            padding: 1.0,
                            inactiveColor: Colors.white,
                            inactiveToggleColor: AppColors.disabledColor,
                            switchBorder: Border.all(
                                color:
                                AppColors.unselectedButtonTextColor),
                            activeColor:
                            AppColors.unselectedButtonTextColor,
                            // showOnOff: true,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                                if (status == true) {
                                  statusId = '1';
                                } else {
                                  statusId = '0';
                                }
                              });
                            },
                          ),
                          UIHelper.horizontalSpaceSmall,
                          Text(
                            'Estado ativo',
                            style: TextFontStyle.headline2BoldStyle,
                          ),
                        ],
                      ),
                      // Container(
                      //   alignment: Alignment.centerRight,
                      //   child: Text(
                      //     "Value: $statusId",
                      //   ),
                      // ),
                      UIHelper.verticalSpaceMedium,
                    ],
                  ),
                ),
                UIHelper.horizontalSpaceSemiLarge,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        """Imagem de destaque (Tamanho máximo:2048 KB,Largura:480,Altura:300)Para redimensionar vai para https://resizeimage.net/""",
                        style: TextFontStyle.headline2BoldStyle,
                      ),
                      UIHelper.verticalSpaceSmall,
                      GestureDetector(
                        onTap: () async {
                          FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                            allowMultiple: false,
                            type: FileType.image,
                          );

                          if (result != null) {
                            setState(() {
                              imgfile = File(result.files.single.path!);
                              imagePath = imgfile.toString();
                              _bytesImage =
                                  File(result.files.single.path!)
                                      .readAsBytesSync();
                              imgBase64Str = base64Encode(_bytesImage!);
                              log(imagePath!.toString());
                              log(imgBase64Str.toString());
                            });
                          } else {
                            const snackBar = SnackBar(
                              content: Text('Nenhum arquivo selecionado'),
                            );
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: (_bytesImage != null)
                            ? Image.memory(
                          _bytesImage!,
                          width: double.infinity,
                          height: 200.h,
                          fit: BoxFit.contain,
                        )
                            : ImageView(
                            url: imagePath,
                            width: double.infinity,
                            height: 200),
                      ),
                      UIHelper.verticalSpaceMedium,
                      Text(
                        "Descrição curta",
                        style: TextFontStyle.headline2BoldStyle,
                      ),
                      UIHelper.verticalSpaceSmall,
                      CustomNumberFormField(
                        fieldHeight: 65,
                        maxline: 10,
                        labelText: 'a',
                        inputType: TextInputType.name,
                        textEditingController:
                        _descriptionShortController,
                      ),
                      UIHelper.verticalSpaceMedium,
                    ],
                  ),
                ),
              ],
            ),
          ),
          UIHelper.verticalSpaceMedium,
          Align(
            alignment: Alignment.centerLeft,
            child: LabelTextButton(
              icon: SvgPicture.asset(
                AssetIcons.buttonPlusIcon,
              ),
              onCallBack: () async {
                // int categoryId = int.parse(productCategory.value.text);
                log(_nameTextController.value.text);
                log(
                  productCategoryValueController.value.text,
                );
                log(_descriptionController.value.text);

                if (_formkey.currentState!.validate()) {
                  await postProductBasicRXobj.postProductBasicData(
                      _nameTextController.value.text,
                      productCategoryValueController.value.text,
                      _descriptionController.value.text,
                      statusId,
                      _descriptionShortController.value.text,
                      restaurantId,
                      imgBase64Str,
                      id: id.toString());
                  await getItemListRXobj.fetchItemListData();

                  // postProductBasicRXobj.getFileData.listen((event) {
                  //   int id = event['data']['food']['id'];
                  //   locator<FoodId>().foodId = id;
                  //   // Provider.of<ProductIdProvider>(context, listen: false)
                  //   // .changeId(id);
                  //   // log(id);
                  //   // storage.write(kKeyproductID, id);
                  // });
                }
              },
              text: 'Gravar',
            ),
          )
        ],
      ),
    );
  }
}
