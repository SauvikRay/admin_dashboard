import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:getwidget/getwidget.dart';
import '/helpers/table_model/addon_id.dart';
import '/networks/api_acess.dart';
import '/networks/rx_post_product_addon_save/rx.dart';
import '/networks/rx_post_show_product_addon/api.dart';
import '/widgets/loading_indicators.dart';
import '/widgets/popup_number_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../../constants/app_color.dart';
import '../../constants/app_constants.dart';
import '../../constants/text_font_style.dart';
import '../../constants/ui_helpers.dart';
import '../../helpers/di.dart';
import '../../helpers/helper.dart';
import '../../helpers/table_model/food_options_id.dart';
import '../../screens/tabs/button_pen_nome.dart';
import '../custome_textfield.dart';
import '../image_view.dart';
import '../inkwell_button.dart';
import '../lebel_text_button.dart';

class Extras extends StatefulWidget {
  const Extras({Key? key}) : super(key: key);

  @override
  State<Extras> createState() => _ExtrasState();
}

class _ExtrasState extends State<Extras> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String? imagePath;

  bool status = true;
  String? nameValidation;
  bool validation = false;
  File? imgfile;
  Uint8List? _bytesImage;
  List<dynamic> addonItems = [];
  int? foodId;
  int? addonId;
  @override
  void initState() {
    showPostProductAddon();
    showPostProductAddonRxobj.getShowPostProductAddonData.first.then((event) {
      setState(() {
        addonItems = event['data']['addons']['data'];
        log(addonItems.toString());
        // for (var element in addonItems) {
        //   int addonId = element['id'];
        //   log(addonId.toString());
        // }
      });

      // for (var element in addonItems) {
      //   String addonId = element['image_full_path'];
      //   log(addonId.toString());
      // }
    });

    super.initState();
  }

  showPostProductAddon() async {
    foodId = locator<FoodId>().getFoodId;
    if (foodId != null) {
      await showPostProductAddonRxobj.fetchShowPostProductAddon(
          foodId.toString(), //locator<FoodId>().getFoodId.toString(),
          record: 10,
          page: 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: (ScreenUtil().screenWidth < 600)
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Adicionar/Editar extras',
                          style: TextFontStyle.mobileBold,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          "Nome",
                          style: TextFontStyle.mobileBold,
                        ),
                        UIHelper.verticalSpaceSmall,
                        CustomNumberFormField(
                          hintText: 'Nome',
                          labelText: 'a',
                          inputType: TextInputType.name,
                          textEditingController: _nameTextController,
                          fieldHeight: nameValidation != null ? 50.h : 50.h,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              nameValidation = value;
                              return 'Enter Nome';
                            }
                            nameValidation = null;
                            return null;
                          },
                          validation: validation,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          "Preço",
                          style: TextFontStyle.mobileBold,
                        ),
                        UIHelper.verticalSpaceSmall,
                        CustomNumberFormField(
                          hintText: '00.00',
                          labelText: 'price',
                          inputType: TextInputType.name,
                          textEditingController: _priceController,
                          fieldHeight: nameValidation != null ? 50.h : 50.h,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              nameValidation = value;
                              return 'Enter price';
                            }
                            nameValidation = null;
                            return null;
                          },
                          validation: validation,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          "Ícone",
                          style: TextFontStyle.mobileBold,
                        ),
                        UIHelper.verticalSpaceMedium,
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
                          "Descrição longa",
                          style: TextFontStyle.mobileBold,
                        ),
                        UIHelper.verticalSpaceSmall,
                        CustomNumberFormField(
                          maxline: 50,
                          labelText: 'a',
                          inputType: TextInputType.name,
                          textEditingController: _descriptionTextController,
                          fieldHeight: nameValidation != null ? 60.h : 60.h,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              nameValidation = value;
                              return 'Enter description';
                            }
                            nameValidation = null;
                            return null;
                          },
                          validation: validation,
                        ),
                        UIHelper.verticalSpaceMedium,

                        //Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LabelTextButton(
                              width: .35.sw,
                              icon: SvgPicture.asset(
                                AssetIcons.buttonPlusIcon,
                              ),
                              text: 'Gravar',
                              onCallBack: () async {
                                if (_formkey.currentState!.validate()) {
                                  if (_nameTextController
                                          .value.text.isNotEmpty &&
                                      _priceController.value.text.isNotEmpty) {
                                    validation = true;

                                    await postProductAddonRXobj
                                        .postProductAddonData(
                                      foodId,
                                      _nameTextController.value.text,
                                      _priceController.value.text,
                                      imgfile,
                                      _descriptionTextController.value.text,
                                      addonId,
                                    );

                                    setState(() {
                                      showPostProductAddonRxobj
                                          .getShowPostProductAddonData
                                          .listen((event) {
                                        //   setState(() {
                                        Map data = event['data']['addons'];
                                        addonItems = data['data'];

                                        for (var element in addonItems) {
                                          String addonId =
                                              element['image_full_path'];
                                          log(addonId.toString());
                                        }
                                      });
                                    });

                                    showPostProductAddon();
                                  }
                                }
                              },
                            ),
                            LabelTextButton(
                              width: .3.sw,
                              borderSide: const BorderSide(
                                color: AppColors.disabledColor,
                              ),
                              color: AppColors.scaffoldColor,
                              icon: SvgPicture.asset(
                                AssetIcons.reload,
                                color: AppColors.disabledColor,
                              ),
                              onCallBack: () {
                                postProductAddonRXobj.clean();
                                clean();
                              },
                              text: 'Reinicia',
                              textFontStyle: TextFontStyle.headline2BoldStyle,
                            ),
                          ],
                        ),
                        UIHelper.verticalSpaceLarge,
                      ]),
                ),
                UIHelper.horizontalSpaceSemiLarge,
                Text(
                  'Show Addon List',
                  style: TextFontStyle.mobileBold,
                ),
                UIHelper.verticalSpaceMedium,
                Text(
                  'Here goes the addon list',
                  style: TextFontStyle.mobileBold,
                ),
                UIHelper.verticalSpaceMedium,
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
                  ],
                ),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: AppColors.scaffoldColor),
                    child: DataTable(
                      columnSpacing: MediaQuery.of(context).orientation ==
                              Orientation.portrait
                          ? .05.sw
                          : .1.sw,
                      headingTextStyle: TextFontStyle.tableHeader.copyWith(
                        color: const Color(0xFF8D949B),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                      headingRowColor:
                          MaterialStateProperty.all(const Color(0xFFDEE2E6)),
                      dataRowHeight: 50,
                      // horizontalMargin: 10,
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
                          label: Text('Ícone',
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
                          label: Text('Preco',
                              style: TextFontStyle.tableHeader,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left),
                        ),
                        DataColumn(
                          label: Text('Descricao',
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
                      rows: addonItems
                          .map((addonItems) => DataRow(cells: [
                                DataCell(SizedBox(
                                  width: 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Image.network(
                                        addonItems['image_full_path']),
                                  ),
                                )),
                                DataCell(Text(addonItems['name'])),
                                DataCell(Text(addonItems['price'])),
                                DataCell(Text(addonItems['description'])),
                                DataCell(
                                  Row(
                                    children: [
                                      InkWell(
                                        child: Icon(
                                          Icons.edit,
                                          size: 25.sp,
                                          color: Colors.blueAccent,
                                        ),
                                        onTap: () async {
                                          _formkey.currentState!.reset();
                                          clean();
                                          String? imgBase64Str =
                                              await networkImageToBase64(
                                                  addonItems[
                                                      'image_full_path']);
                                          http.Response response = await http
                                              .get(Uri.parse(addonItems[
                                                  'image_full_path']));
                                          Uint8List uint8list =
                                              response.bodyBytes;
                                          var buffer = uint8list.buffer;
                                          ByteData byteData =
                                              ByteData.view(buffer);
                                          var tempDir =
                                              await getTemporaryDirectory();
                                          File file = await File(
                                                  '${tempDir.path}/img')
                                              .writeAsBytes(buffer.asUint8List(
                                                  byteData.offsetInBytes,
                                                  byteData.lengthInBytes));
                                          setState(() {
                                            addonId = addonItems['id'];
                                            _nameTextController.text =
                                                addonItems['name'].toString();
                                            _priceController.text =
                                                addonItems['price'].toString();
                                            _bytesImage = const Base64Decoder()
                                                .convert(imgBase64Str!);
                                            imgfile = file;
                                            imagePath = imgfile.toString();
                                            _descriptionTextController.text =
                                                addonItems['description'];
                                          });
                                        },
                                      ),
                                      UIHelper.horizontalSpaceSmall,
                                      InkWell(
                                        child: Icon(
                                          Icons.delete,
                                          size: 25.sp,
                                          color: Colors.red,
                                        ),
                                        onTap: () async {
                                          await deleteProductAddOnRxobj
                                              .deleteProductAddon(
                                                  addonItems['id'].toString());
                                          await showPostProductAddonRxobj
                                              .fetchShowPostProductAddon(
                                                  foodId
                                                      .toString(), //locator<FoodId>().getFoodId.toString(),
                                                  record: 10,
                                                  page: 1);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ]))
                          .toList(),
                    ),
                  ),
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
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Form(
                    key: _formkey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Adicionar/Editar extras',
                            style: TextFontStyle.headline1BoldStyle,
                          ),
                          UIHelper.verticalSpaceMedium,
                          Text(
                            "Nome",
                            style: TextFontStyle.headline2BoldStyle,
                          ),
                          UIHelper.verticalSpaceSmall,
                          CustomNumberFormField(
                            hintText: 'Nome',
                            labelText: 'a',
                            inputType: TextInputType.name,
                            textEditingController: _nameTextController,
                            fieldHeight: nameValidation != null ? 50.h : 50.h,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                nameValidation = value;
                                return 'Enter Nome';
                              }
                              nameValidation = null;
                              return null;
                            },
                            validation: validation,
                          ),
                          UIHelper.verticalSpaceMedium,
                          Text(
                            "Preço",
                            style: TextFontStyle.headline2BoldStyle,
                          ),
                          UIHelper.verticalSpaceSmall,
                          CustomNumberFormField(
                            hintText: '00.00',
                            labelText: 'price',
                            inputType: TextInputType.name,
                            textEditingController: _priceController,
                            fieldHeight: nameValidation != null ? 50.h : 50.h,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                nameValidation = value;
                                return 'Enter price';
                              }
                              nameValidation = null;
                              return null;
                            },
                            validation: validation,
                          ),
                          UIHelper.verticalSpaceMedium,
                          Text(
                            "Ícone",
                            style: TextFontStyle.headline2BoldStyle,
                          ),
                          UIHelper.verticalSpaceMedium,
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
                            "Descrição longa",
                            style: TextFontStyle.headline2BoldStyle,
                          ),
                          UIHelper.verticalSpaceSmall,
                          CustomNumberFormField(
                            maxline: 50,
                            labelText: 'a',
                            inputType: TextInputType.name,
                            textEditingController: _descriptionTextController,
                            fieldHeight: nameValidation != null ? 60.h : 60.h,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                nameValidation = value;
                                return 'Enter description';
                              }
                              nameValidation = null;
                              return null;
                            },
                            validation: validation,
                          ),
                          UIHelper.verticalSpaceMedium,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LabelTextButton(
                                width: .15.sw,
                                icon: SvgPicture.asset(
                                  AssetIcons.buttonPlusIcon,
                                ),
                                text: 'Gravar',
                                onCallBack: () async {
                                  if (_formkey.currentState!.validate()) {
                                    if (_nameTextController
                                            .value.text.isNotEmpty &&
                                        _priceController
                                            .value.text.isNotEmpty) {
                                      validation = true;

                                      await postProductAddonRXobj
                                          .postProductAddonData(
                                        foodId,
                                        _nameTextController.value.text,
                                        _priceController.value.text,
                                        imgfile,
                                        _descriptionTextController.value.text,
                                        addonId,
                                      );

                                      setState(() {
                                        showPostProductAddonRxobj
                                            .getShowPostProductAddonData
                                            .listen((event) {
                                          //   setState(() {
                                          Map data = event['data']['addons'];
                                          addonItems = data['data'];

                                          for (var element in addonItems) {
                                            String addonId =
                                                element['image_full_path'];
                                            log(addonId.toString());
                                          }
                                        });
                                      });

                                      showPostProductAddon();
                                    }
                                  }
                                },
                              ),
                              LabelTextButton(
                                width: .2.sw,
                                borderSide: const BorderSide(
                                  color: AppColors.disabledColor,
                                ),
                                color: AppColors.scaffoldColor,
                                icon: SvgPicture.asset(
                                  AssetIcons.reload,
                                  color: AppColors.disabledColor,
                                ),
                                onCallBack: () {
                                  postProductAddonRXobj.clean();
                                  clean();
                                },
                                text: 'Reinicia',
                                textFontStyle: TextFontStyle.headline2BoldStyle,
                              ),
                            ],
                          ),
                          UIHelper.verticalSpaceExtraLarge,
                          UIHelper.verticalSpaceExtraLarge,
                        ]),
                  ),
                ),
                UIHelper.horizontalSpaceSemiLarge,
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Addon List',
                      style: TextFontStyle.headline1BoldStyle,
                    ),
                    UIHelper.verticalSpaceMedium,
                    Text(
                      'Here goes the addon list',
                      style: TextFontStyle.subtitle1RegularStyle,
                    ),
                    UIHelper.verticalSpaceMedium,
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
                      ],
                    ),
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
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: AppColors.scaffoldColor),
                        child: DataTable(
                          columnSpacing: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? .05.sw
                              : .1.sw,
                          headingTextStyle: TextFontStyle.tableHeader.copyWith(
                            color: const Color(0xFF8D949B),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                          headingRowColor: MaterialStateProperty.all(
                              const Color(0xFFDEE2E6)),
                          dataRowHeight: 50,
                          // horizontalMargin: 10,
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
                              label: Text('Ícone',
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
                              label: Text('Preco',
                                  style: TextFontStyle.tableHeader,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left),
                            ),
                            DataColumn(
                              label: Text('Descricao',
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
                          rows: addonItems
                              .map((addonItems) => DataRow(cells: [
                                    DataCell(SizedBox(
                                      width: 50,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Image.network(
                                            addonItems['image_full_path']),
                                      ),
                                    )),
                                    DataCell(Text(addonItems['name'])),
                                    DataCell(Text(addonItems['price'])),
                                    DataCell(Text(addonItems['description'])),
                                    DataCell(
                                      Row(
                                        children: [
                                          InkWell(
                                            child: Icon(
                                              Icons.edit,
                                              size: 25.sp,
                                              color: Colors.blueAccent,
                                            ),
                                            onTap: () async {
                                              _formkey.currentState!.reset();
                                              clean();
                                              String? imgBase64Str =
                                                  await networkImageToBase64(
                                                      addonItems[
                                                          'image_full_path']);
                                              http.Response response =
                                                  await http.get(Uri.parse(
                                                      addonItems[
                                                          'image_full_path']));
                                              Uint8List uint8list =
                                                  response.bodyBytes;
                                              var buffer = uint8list.buffer;
                                              ByteData byteData =
                                                  ByteData.view(buffer);
                                              var tempDir =
                                                  await getTemporaryDirectory();
                                              File file = await File(
                                                      '${tempDir.path}/img')
                                                  .writeAsBytes(
                                                      buffer.asUint8List(
                                                          byteData
                                                              .offsetInBytes,
                                                          byteData
                                                              .lengthInBytes));
                                              setState(() {
                                                addonId = addonItems['id'];
                                                _nameTextController.text =
                                                    addonItems['name']
                                                        .toString();
                                                _priceController.text =
                                                    addonItems['price']
                                                        .toString();
                                                _bytesImage =
                                                    const Base64Decoder()
                                                        .convert(imgBase64Str!);
                                                imgfile = file;
                                                imagePath = imgfile.toString();
                                                _descriptionTextController
                                                        .text =
                                                    addonItems['description'];
                                              });
                                            },
                                          ),
                                          UIHelper.horizontalSpaceSmall,
                                          InkWell(
                                            child: Icon(
                                              Icons.delete,
                                              size: 25.sp,
                                              color: Colors.red,
                                            ),
                                            onTap: () async {
                                              await deleteProductAddOnRxobj
                                                  .deleteProductAddon(
                                                      addonItems['id']
                                                          .toString());
                                              await showPostProductAddonRxobj
                                                  .fetchShowPostProductAddon(
                                                      foodId
                                                          .toString(), //locator<FoodId>().getFoodId.toString(),
                                                      record: 10,
                                                      page: 1);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]))
                              .toList(),
                        ),
                      ),
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
                )),
              ],
            ),
    );
  }

  void clean() {
    setState(() {
      _nameTextController.text = "";
      validation = false;
      nameValidation = null;
      // selectValidation = null;
      imgfile = null;
      // isUpdate = false;
      imagePath = null;
      _bytesImage = null;
      addonItems.clear();
    });
  }
}
