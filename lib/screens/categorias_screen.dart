import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getwidget/getwidget.dart';

import 'package:provider/provider.dart';
import 'package:tree_view/tree_view.dart';
import '/constants/text_font_style.dart';
import '/networks/api_acess.dart';
import '/widgets/appbar_widget.dart';
import '/widgets/loading_indicators.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import '../constants/app_color.dart';
import '../constants/app_constants.dart';
import '../constants/ui_helpers.dart';
import '../helpers/all_routes.dart';
import '../helpers/helper.dart';
import '../helpers/navigation_service.dart';
import '../provider/catpopup_status.dart';
import '../widgets/custome_textfield.dart';
import '../widgets/image_view.dart';
import '../widgets/inkwell_button.dart';
import '../widgets/lebel_text_button.dart';
import '../widgets/popup_estado_category_widget.dart';

class Categorias extends StatefulWidget {
  const Categorias({Key? key}) : super(key: key);

  @override
  State<Categorias> createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController popUpController = TextEditingController();
  final categoryGlobalkey = GlobalKey<PopupMenuButtonState<String>>();

  String? nameValidation;
  String? priceValidation;
  bool validation = false;
  String? imagePath;
  File? imgfile;
  String status = '0';
  bool isUpdate = false;

  late Uint8List uint8list;

  Uint8List? _bytesImage;
  get validator => null;
  String? selectValidation;
  int? catId;

  @override
  void initState() {
    setState(() {
      selectValidation = null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    final storage = GetStorage();
    return Scaffold(
      appBar: const MainAppBarWidget(),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: UIHelper.kDefaulutPadding(),
            vertical: UIHelper.kDefaulutPadding()),
        child: SingleChildScrollView(
            child: (ScreenUtil().screenWidth < 600)
                ? Column(children: [
                    Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        elevation: 1.0,
                        color: AppColors.white,
                        child: Padding(
                          padding: EdgeInsets.all(15.0.w),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Categoria de produto Adicionar/Editar',
                                  style: TextFontStyle.headline2BoldStyle
                                      .copyWith(
                                          color: AppColors.headLine1Color),
                                ),
                                UIHelper.verticalSpaceSmall,
                                Text(
                                  'Nome da categoria',
                                  style: TextFontStyle.headline2BoldStyle,
                                ),
                                UIHelper.verticalSpaceSmall,
                                CustomNumberFormField(
                                  labelText: 'Food Category',
                                  // hintText: 'Food Category',
                                  inputType: TextInputType.name,
                                  textEditingController: _nameTextController,
                                  fieldHeight:
                                      nameValidation != null ? 50.h : 50.h,
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
                                UIHelper.verticalSpaceSmall,
                                Text(
                                  'Ícone (Tamanho máximo:2048 KB, Largura:300, Altura:300),Para redimensionar vai parahttps://resizeimage.net/',
                                  textAlign: TextAlign.left,
                                  style: TextFontStyle.subtitle1RegularStyle,
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
                                        imgfile =
                                            File(result.files.single.path!);
                                        imagePath = imgfile.toString();
                                        _bytesImage =
                                            File(result.files.single.path!)
                                                .readAsBytesSync();

                                        log(imagePath!.toString());
                                      });
                                    } else {
                                      const snackBar = SnackBar(
                                        content: Text('No file selected'),
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
                                  'Estado ativo',
                                  style: TextFontStyle.headline2BoldStyle,
                                ),
                                UIHelper.verticalSpaceSmall,
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 5.w,
                                  ),
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: AppColors.borderColor,
                                          width: 0.5)),
                                  child: PopupCategoryWidget(
                                    textController: popUpController,
                                    categoryGlobalkey: categoryGlobalkey,
                                  ),
                                ),
                                UIHelper.verticalSpaceMedium,
                                Visibility(
                                  visible:
                                      selectValidation != null ? true : false,
                                  child: Text(
                                    selectValidation ?? "",
                                    style: TextFontStyle.errorStyle,
                                  ),
                                ),
                                UIHelper.verticalSpaceMedium,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    LabelTextButton(
                                      width: .35.sw,
                                      height: 35.h,
                                      text: 'Gravar',
                                      icon: SvgPicture.asset(
                                        AssetIcons.buttonPlusIcon,
                                      ),
                                      onCallBack: () async {
                                        if (_formkey.currentState!.validate()) {
                                          if (popUpController
                                              .value.text.isEmpty) {
                                            setState(() {
                                              selectValidation =
                                                  'Enter Active state';
                                              validation = true;
                                            });
                                          } else {
                                            if (popUpController.value.text ==
                                                'Active') {
                                              setState(() {
                                                status = '1';
                                              });
                                            } else {
                                              setState(() {
                                                status = '0';
                                              });
                                            }
                                          }
                                          if (_bytesImage != null &&
                                              _nameTextController
                                                  .value.text.isNotEmpty) {
                                            String restaurantId =
                                                storage.read(kKeyShopID);
                                            if (!isUpdate) {
                                              await postProductCategoryRXobj
                                                  .postProductCategoryData(
                                                      _nameTextController
                                                          .value.text,
                                                      restaurantId,
                                                      imgfile,
                                                      status);
                                              await getProductCategoryRXobj
                                                  .fetchProductCategoryData(
                                                      restaurantId);
                                              clean();
                                            } else {
                                              await updateItemCategoryRXobj
                                                  .postUpdateCategory(
                                                      catId.toString(),
                                                      _nameTextController
                                                          .value.text,
                                                      status,
                                                      imgfile!);
                                              await getProductCategoryRXobj
                                                  .fetchProductCategoryData(
                                                      restaurantId);
                                              clean();
                                            }
                                          } else {
                                            const snackBar = SnackBar(
                                              content: Text(
                                                  'Verifique a Política de Privacidade'),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        } else {
                                          if (popUpController
                                              .value.text.isEmpty) {
                                            setState(() {
                                              selectValidation =
                                                  'Enter Active state';
                                              validation = true;
                                            });
                                          }
                                        }
                                      },
                                    ),
                                    LabelTextButton(
                                      width: .35.sw,
                                      height: 35.h,
                                      borderSide: const BorderSide(
                                        color: AppColors.disabledColor,
                                      ),
                                      color: AppColors.scaffoldColor,
                                      icon: SvgPicture.asset(
                                        AssetIcons.reload,
                                        color: AppColors.disabledColor,
                                      ),
                                      onCallBack: () {
                                        clean();

                                        //
                                      },
                                      text: 'Reinicia',
                                      textFontStyle:
                                          TextFontStyle.headline2BoldStyle,
                                    ),
                                  ],
                                ),
                                UIHelper.verticalSpaceLarge,
                              ],
                            ),
                          ),
                        )),
                    UIHelper.verticalSpaceMedium,
                    Card(
                      margin: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r)),
                      elevation: 1.0,
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //For showing image and text from
                            StreamBuilder(
                                stream: getProductCategoryRXobj
                                    .getProductCategoryData,
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (snapshot.hasData) {
                                    List<dynamic> data = snapshot.data['data']
                                        ["productCategory"];

                                    return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: data.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) => Row(
                                        children: [
                                          Container(
                                            margin:
                                                EdgeInsets.only(bottom: 10.h),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.r)),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  data[index]
                                                      ["image_full_path"],
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.fill,
                                                ),
                                                UIHelper.horizontalSpaceSmall,
                                                Text(
                                                  data[index]["name"]
                                                      .toString(),
                                                  style: TextFontStyle
                                                      .mobileNormal,
                                                ),
                                                UIHelper.horizontalSpaceSmall,
                                                InkWellButton(
                                                    icon: AssetIcons.edit,
                                                    height: 20.h,
                                                    width: 20.h,
                                                    onCallBack: () async {
                                                      _formkey.currentState!
                                                          .reset();
                                                      clean();
                                                      final imgBase64Str =
                                                          await networkImageToBase64(
                                                              data[index][
                                                                  "image_full_path"]);
                                                      http.Response response =
                                                          await http.get(Uri
                                                              .parse(data[index]
                                                                  [
                                                                  "image_full_path"]));
                                                      final uint8list =
                                                          response.bodyBytes;
                                                      var buffer =
                                                          uint8list.buffer;
                                                      ByteData byteData =
                                                          ByteData.view(buffer);
                                                      var tempDir =
                                                          await getTemporaryDirectory();

                                                      File file = await File(
                                                              '${tempDir.path}/img')
                                                          .writeAsBytes(buffer
                                                              .asUint8List(
                                                                  byteData
                                                                      .offsetInBytes,
                                                                  byteData
                                                                      .lengthInBytes));

                                                      setState(
                                                        () {
                                                          isUpdate = true;
                                                          _bytesImage =
                                                              const Base64Decoder()
                                                                  .convert(
                                                                      imgBase64Str!);
                                                          catId =
                                                              data[index]["id"];
                                                          _nameTextController
                                                                  .text =
                                                              data[index]
                                                                      ["name"]
                                                                  .toString();
                                                          imgfile = file;
                                                          imagePath = imgfile
                                                              .toString();
                                                        },
                                                      );

                                                      data[index]["status"] == 1
                                                          ? Provider.of<
                                                                      PopUpStatus>(
                                                                  context,
                                                                  listen: false)
                                                              .changename(
                                                                  'Active')
                                                          : Provider.of<
                                                                      PopUpStatus>(
                                                                  context,
                                                                  listen: false)
                                                              .changename(
                                                                  'Inactive');
                                                    }),
                                                UIHelper.horizontalSpaceSmall,
                                                InkWellButton(
                                                  icon: AssetIcons.minus,
                                                  height: 20.h,
                                                  width: 20.h,
                                                  onCallBack: () async {
                                                    String restaurantId =
                                                        storage
                                                            .read(kKeyShopID);
                                                    await deleteProductCategoryRXobj
                                                        .deleteProductCategoryData(
                                                            data[index]["id"]
                                                                .toString());
                                                    await getProductCategoryRXobj
                                                        .fetchProductCategoryData(
                                                            restaurantId);
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                          UIHelper.horizontalSpaceMedium,
                                        ],
                                      ),
                                    );
                                  } else if (snapshot.hasError) {
                                    return SizedBox(
                                      child: Center(
                                        child: loadingIndicatorCircle(
                                            context: context),
                                      ),
                                    );
                                  }
                                  return Container();
                                }),

                            UIHelper.verticalSpaceMedium,
                          ],
                        ),
                      ),
                    ),
                  ])
                : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                      child: Card(
                          margin: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r)),
                          elevation: 1.0,
                          color: AppColors.white,
                          child: Padding(
                            padding: EdgeInsets.all(15.0.w),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Categoria de produto Adicionar/Editar',
                                    style: TextFontStyle.headline2BoldStyle
                                        .copyWith(
                                            color: AppColors.headLine1Color),
                                  ),
                                  UIHelper.verticalSpaceSmall,
                                  Text(
                                    'Nome da categoria',
                                    style: TextFontStyle.headline2BoldStyle,
                                  ),
                                  UIHelper.verticalSpaceSmall,
                                  CustomNumberFormField(
                                    labelText: 'Food Category',
                                    // hintText: 'Food Category',
                                    inputType: TextInputType.name,
                                    textEditingController: _nameTextController,
                                    fieldHeight:
                                        nameValidation != null ? 50.h : 50.h,
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
                                  UIHelper.verticalSpaceSmall,
                                  Text(
                                    'Ícone (Tamanho máximo:2048 KB, Largura:300, Altura:300),Para redimensionar vai parahttps://resizeimage.net/',
                                    textAlign: TextAlign.left,
                                    style: TextFontStyle.subtitle1RegularStyle,
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
                                          imgfile =
                                              File(result.files.single.path!);
                                          imagePath = imgfile.toString();
                                          _bytesImage =
                                              File(result.files.single.path!)
                                                  .readAsBytesSync();

                                          log(imagePath!.toString());
                                        });
                                      } else {
                                        const snackBar = SnackBar(
                                          content: Text('No file selected'),
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
                                    'Estado ativo',
                                    style: TextFontStyle.headline2BoldStyle,
                                  ),
                                  UIHelper.verticalSpaceSmall,
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.w,
                                    ),
                                    height: 40.h,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: AppColors.borderColor,
                                            width: 0.5)),
                                    child: PopupCategoryWidget(
                                      textController: popUpController,
                                      categoryGlobalkey: categoryGlobalkey,
                                    ),
                                  ),
                                  UIHelper.verticalSpaceMedium,
                                  Visibility(
                                    visible:
                                        selectValidation != null ? true : false,
                                    child: Text(
                                      selectValidation ?? "",
                                      style: TextFontStyle.errorStyle,
                                    ),
                                  ),
                                  UIHelper.verticalSpaceMedium,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      LabelTextButton(
                                        width: .15.sw,
                                        text: 'Gravar',
                                        icon: SvgPicture.asset(
                                          AssetIcons.buttonPlusIcon,
                                        ),
                                        onCallBack: () async {
                                          if (_formkey.currentState!
                                              .validate()) {
                                            if (popUpController
                                                .value.text.isEmpty) {
                                              setState(() {
                                                selectValidation =
                                                    'Enter Active state';
                                                validation = true;
                                              });
                                            } else {
                                              if (popUpController.value.text ==
                                                  'Active') {
                                                setState(() {
                                                  status = '1';
                                                });
                                              } else {
                                                setState(() {
                                                  status = '0';
                                                });
                                              }
                                            }
                                            if (_bytesImage != null &&
                                                _nameTextController
                                                    .value.text.isNotEmpty) {
                                              String restaurantId =
                                                  storage.read(kKeyShopID);
                                              if (!isUpdate) {
                                                await postProductCategoryRXobj
                                                    .postProductCategoryData(
                                                        _nameTextController
                                                            .value.text,
                                                        restaurantId,
                                                        imgfile,
                                                        status);
                                                await getProductCategoryRXobj
                                                    .fetchProductCategoryData(
                                                        restaurantId);
                                                clean();
                                              } else {
                                                await updateItemCategoryRXobj
                                                    .postUpdateCategory(
                                                        catId.toString(),
                                                        _nameTextController
                                                            .value.text,
                                                        status,
                                                        imgfile!);
                                                await getProductCategoryRXobj
                                                    .fetchProductCategoryData(
                                                        restaurantId);
                                                clean();
                                              }
                                            } else {
                                              const snackBar = SnackBar(
                                                content: Text(
                                                    'Verifique a Política de Privacidade'),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                                            }
                                          } else {
                                            if (popUpController
                                                .value.text.isEmpty) {
                                              setState(() {
                                                selectValidation =
                                                    'Enter Active state';
                                                validation = true;
                                              });
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
                                          clean();

                                          //
                                        },
                                        text: 'Reinicia',
                                        textFontStyle:
                                            TextFontStyle.headline2BoldStyle,
                                      ),
                                    ],
                                  ),
                                  UIHelper.verticalSpaceLarge,
                                ],
                              ),
                            ),
                          )),
                    ),
                    UIHelper.horizontalSpaceMedium,
                    Expanded(
                      child: Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        elevation: 1.0,
                        color: AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //For showing image and text from
                              StreamBuilder(
                                  stream: getProductCategoryRXobj
                                      .getProductCategoryData,
                                  builder: (context, AsyncSnapshot snapshot) {
                                    if (snapshot.hasData) {
                                      List<dynamic> data = snapshot.data['data']
                                          ["productCategory"];

                                      return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        itemCount: data.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) => Row(
                                          children: [
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10.h),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.r)),
                                              child: Row(
                                                children: [
                                                  Image.network(
                                                    data[index]
                                                        ["image_full_path"],
                                                    width: 30,
                                                    height: 30,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  UIHelper.horizontalSpaceSmall,
                                                  Text(
                                                    data[index]["name"]
                                                        .toString(),
                                                  ),
                                                  UIHelper.horizontalSpaceSmall,
                                                  InkWellButton(
                                                      icon: AssetIcons.edit,
                                                      onCallBack: () async {
                                                        _formkey.currentState!
                                                            .reset();
                                                        clean();
                                                        final imgBase64Str =
                                                            await networkImageToBase64(
                                                                data[index][
                                                                    "image_full_path"]);
                                                        http.Response response =
                                                            await http.get(
                                                                Uri.parse(data[
                                                                        index][
                                                                    "image_full_path"]));
                                                        final uint8list =
                                                            response.bodyBytes;
                                                        var buffer =
                                                            uint8list.buffer;
                                                        ByteData byteData =
                                                            ByteData.view(
                                                                buffer);
                                                        var tempDir =
                                                            await getTemporaryDirectory();

                                                        File file = await File(
                                                                '${tempDir.path}/img')
                                                            .writeAsBytes(buffer
                                                                .asUint8List(
                                                                    byteData
                                                                        .offsetInBytes,
                                                                    byteData
                                                                        .lengthInBytes));

                                                        setState(
                                                          () {
                                                            isUpdate = true;
                                                            _bytesImage =
                                                                const Base64Decoder()
                                                                    .convert(
                                                                        imgBase64Str!);
                                                            catId = data[index]
                                                                ["id"];
                                                            _nameTextController
                                                                    .text =
                                                                data[index]
                                                                        ["name"]
                                                                    .toString();
                                                            imgfile = file;
                                                            imagePath = imgfile
                                                                .toString();
                                                          },
                                                        );

                                                        data[index]["status"] ==
                                                                1
                                                            ? Provider.of<
                                                                        PopUpStatus>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changename(
                                                                    'Active')
                                                            : Provider.of<
                                                                        PopUpStatus>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .changename(
                                                                    'Inactive');
                                                      }),
                                                  UIHelper.horizontalSpaceSmall,
                                                  InkWellButton(
                                                    icon: AssetIcons.minus,
                                                    onCallBack: () async {
                                                      String restaurantId =
                                                          storage
                                                              .read(kKeyShopID);
                                                      await deleteProductCategoryRXobj
                                                          .deleteProductCategoryData(
                                                              data[index]["id"]
                                                                  .toString());
                                                      await getProductCategoryRXobj
                                                          .fetchProductCategoryData(
                                                              restaurantId);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            UIHelper.horizontalSpaceMedium,
                                          ],
                                        ),
                                      );
                                    } else if (snapshot.hasError) {
                                      return SizedBox(
                                        child: Center(
                                          child: loadingIndicatorCircle(
                                              context: context),
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),

                              UIHelper.verticalSpaceMedium,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ])),
      ),
    );
  }

  void clean() {
    setState(() {
      _nameTextController.text = "";
      validation = false;
      nameValidation = null;
      selectValidation = null;
      imagePath = null;
      isUpdate = false;
      _bytesImage = null;
    });
    Provider.of<PopUpStatus>(context, listen: false).changename('Status Ativo');
    // _formkey.currentState!.reset();
  }
}
