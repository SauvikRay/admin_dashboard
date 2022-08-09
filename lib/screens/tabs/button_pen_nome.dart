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
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wede_restaurant/helpers/helper.dart';
import '/constants/text_font_style.dart';
import '/constants/ui_helpers.dart';
import '/networks/api_acess.dart';
import '/widgets/lebel_text_button.dart';

import '../../constants/app_color.dart';
import '../../constants/app_constants.dart';
import '../../provider/sub_category.dart';
import '../../widgets/custome_textfield.dart';
import '../../widgets/image_view.dart';
import '../../widgets/popup_group_category_widget.dart';
import '../../widgets/popup_group_widget.dart';

class ButtonPenNome extends StatefulWidget {
  const ButtonPenNome({Key? key}) : super(key: key);

  @override
  State<ButtonPenNome> createState() => _ButtonPenNomeState();
}

class _ButtonPenNomeState extends State<ButtonPenNome> {
  final TextEditingController _nameTextController = TextEditingController();

  final TextEditingController _groupPopupTextController =
      TextEditingController();
  final TextEditingController _groupPopupValueController =
      TextEditingController();

  final TextEditingController _categoryPopupTextController =
      TextEditingController();
  final TextEditingController _categoryPopupValueController =
      TextEditingController();
  final TextEditingController _subcategoryPopupTextController =
      TextEditingController();
  final TextEditingController _shortDescriptionTextController =
      TextEditingController();
  final TextEditingController _ibanTextController = TextEditingController();
  final TextEditingController _nifTaxidTextController = TextEditingController();
  final TextEditingController _descriptionTextController =
      TextEditingController();

  late String dropdownValue = 'a';
  final storage = GetStorage();

  final _formKey = GlobalKey<FormState>();
  String? nameValidation;
  bool validation = false;
  bool status = false;
  String? selectValidation;
  String? imagePath;
  String? imageUrl;
  File? imgfile;
  Uint8List? _bytesImage;
  String categoryGroupText = "-Select-";
  bool isLoading = true;
  List<Animal>? animals = [];
  List animal = [];
  bool activeButton = true;
  String? imgBase64Str;

  @override
  void initState() {
    getShopRXobj.getShopData.first.then((value) async {
      if (value["data"] != null) {
        // setState(() {

        imgBase64Str =
            await networkImageToBase64(value['data']['image_full_path']);
        _bytesImage = const Base64Decoder().convert(imgBase64Str!);
        log(imgBase64Str.toString());
        _nameTextController.text = value["data"]["name"];

        _groupPopupTextController.text = value["data"]["group"]["name"];
        _groupPopupValueController.text =
            value["data"]["group"]["id"].toString();

        _categoryPopupTextController.text = value["data"]["category"]["name"];
        _categoryPopupValueController.text =
            value["data"]["category"]["id"].toString();

        _shortDescriptionTextController.text =
            value["data"]["short_description"];
        _ibanTextController.text = value["data"]["iban"];
        _nifTaxidTextController.text = value["data"]["owner"]["nif"];

        imageUrl = value["data"]["image_full_path"];
        _descriptionTextController.text = value["data"]["description"];

        animal = value["data"]["sub_categories"];
        for (var element in animal) {
          animals!.add(Animal(id: element["id"], name: element['name']));
        }
        log(animals.toString());
        status = value["data"]["status"] == 1 ? true : false;
        if (value["data"]["latitude"] != null &&
            value["data"]["longitude"] != null &&
            value["data"]["address"] != null) {
          activeButton = false;
        }
        isLoading = false;
        // });
      } else {
        setState(() {
          _categoryPopupTextController.text = "-Select-";
          isLoading = false;
        });
      }
    }).then(
      (_) {
        setState(() {});
        // getShopSubCategoryPopUpListRXobj.fetchSubCategoryData(
        //     _categoryPopupValueController.text); //need work
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //   double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: (ScreenUtil().screenWidth < 600)
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  "Nome",
                  style: TextFontStyle.mobileBold,
                ),
                UIHelper.verticalSpaceSmall,
                CustomNumberFormField(
                  hintText: 'Sede Santiago Do Cacém',
                  labelText: 'Select',
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
                  "Group",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceMedium,
                //Group
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: AppColors.borderColor, width: 0.5)),
                  child: GroupPopupWidget(
                    groupPopupText: _groupPopupValueController,
                    value: _groupPopupTextController.text,
                  ),
                ),

                UIHelper.verticalSpaceMedium,
                Visibility(
                  visible: selectValidation != null ? true : false,
                  child: Text(
                    selectValidation ?? "",
                    style: TextFontStyle.errorStyle,
                  ),
                ),

                UIHelper.verticalSpaceMedium,
                Text(
                  "Categoria",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceMedium,
                //Category

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.w,
                  ),
                  height: 45.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: AppColors.borderColor, width: 0.5)),
                  child: CategoryGroupPopupWidget(
                    categorygroupPopupText: _categoryPopupValueController,
                    value: _categoryPopupTextController.text,
                  ),
                ),
                UIHelper.verticalSpaceMedium,
                Visibility(
                  visible: selectValidation != null ? true : false,
                  child: Text(
                    selectValidation ?? "",
                    style: TextFontStyle.errorStyle,
                  ),
                ),

                UIHelper.verticalSpaceSmall,
                Text(
                  "Sub-categoria",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceSmall,
                // "Sub-categoria",
                // SubCategoryPopupList(initVal: animals), //need to work
                UIHelper.verticalSpaceMedium,
                Text(
                  "Descrição curta",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceSmall,
                CustomNumberFormField(
                  fieldHeight: 60.h,
                  maxline: 50,
                  labelText: 'a',
                  inputType: TextInputType.name,
                  textEditingController: _shortDescriptionTextController,
                ),
                UIHelper.verticalSpaceMedium,
                Text(
                  "IBAN",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceSmall,
                CustomNumberFormField(
                  labelText: 'iban',
                  inputType: TextInputType.name,
                  textEditingController: _ibanTextController,
                ),

                UIHelper.verticalSpaceMedium,
                Text(
                  "NIF",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceSmall,
                CustomNumberFormField(
                  labelText: 'NIF',
                  inputType: TextInputType.name,
                  textEditingController: _nifTaxidTextController,
                ),
                UIHelper.verticalSpaceMedium,
                Text(
                  """Imagem de destaque (Tamanho máximo:2048 KB,Largura:480,Altura:300)Para redimensionar vai para https://resizeimage.net/""",
                  style: TextFontStyle.headline2BoldStyle,
                ),
                UIHelper.verticalSpaceSmall,
                //imagePic
                GestureDetector(
                  onTap: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      allowMultiple: false,
                      type: FileType.image,
                    );

                    if (result != null) {
                      setState(() {
                        // for (var element in result.files) {
                        //   log(element.path!);
                        //   imagePath = element.path!;
                        // }
                        imgfile = File(result.files.single.path!);
                        imagePath = imgfile.toString();
                        _bytesImage =
                            File(result.files.single.path!).readAsBytesSync();
                        imgBase64Str = base64Encode(_bytesImage!);
                        log(imgBase64Str.toString());
                        log("path is  ${imagePath!.toString()}");
                      });
                    } else {
                      const snackBar = SnackBar(
                        content: Text('Nenhum arquivo selecionado'),
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: (_bytesImage != null)
                      ? Image.memory(
                          _bytesImage!,
                          width: double.infinity,
                          height: 200.h,
                          fit: BoxFit.contain,
                        )
                      : (imageUrl != null)
                          ? Image.network(
                              imageUrl!,
                              height: 200.h,
                              fit: BoxFit.fill,
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
                  fieldHeight: 65,
                  maxline: 10,
                  labelText: 'a',
                  inputType: TextInputType.name,
                  textEditingController: _descriptionTextController,
                ),
                UIHelper.verticalSpaceMedium,
                Row(
                  children: [
                    FlutterSwitch(
                      disabled: activeButton,
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
                UIHelper.verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LabelTextButton(
                      icon: SvgPicture.asset(
                        AssetIcons.buttonPlusIcon,
                      ),
                      onCallBack: () async {
                        List<String> subcatIds = [];
                        List<Animal>? selectedsubcat =
                            context.read<SubCategory>().selectedAnimals;
                        selectedsubcat?.forEach(
                          (element) => subcatIds.add(element.id.toString()),
                        );
                        print(_groupPopupValueController.text);
                        int groupPopupInt =
                            int.parse(_groupPopupValueController.text);
                        print('GroupPopup $groupPopupInt');
                        int catgroupPopupInt =
                            int.parse(_categoryPopupValueController.text);

                        print('CategoryGroupPopup $catgroupPopupInt');

                        print('name ${_nameTextController.value.text}');

                        print(_shortDescriptionTextController.value.text);
                        print(_ibanTextController.value.text);
                        print(_nifTaxidTextController.value.text);
                        print(_descriptionTextController.value.text);

                        String userId = storage.read(kKeyUserID);
                        String? restaurentId = storage.read(kKeyShopID);

                        await postSaveShopBasicRXobj.postSaveShopBasicData(
                          _nameTextController.value.text,
                          _groupPopupValueController.value.text,
                          userId,
                          _categoryPopupValueController.value.text,
                          subcatIds,
                          _ibanTextController.value.text,
                          _nifTaxidTextController.value.text,
                          _shortDescriptionTextController.value.text,
                          _descriptionTextController.value.text,
                          status: restaurentId == null
                              ? null
                              : status
                                  ? '1'
                                  : '0',
                          id: restaurentId,
                          featuredImage: imgfile,
                        );
                        await getShopRXobj.fetchShopData();
                        await getShopListRXobj.fetchShopListData();
                      },
                      text: 'Gravar',
                    ),
                  ],
                ),
              ])
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    //width: MediaQuery.of(context).size.width / 2 - 62,
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
                            labelText: 'Select',
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
                            "Group",
                            style: TextFontStyle.headline2BoldStyle,
                          ),
                          UIHelper.verticalSpaceMedium,
                          //Group
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            height: 45.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColors.borderColor, width: 0.5)),
                            child: GroupPopupWidget(
                              groupPopupText: _groupPopupValueController,
                              value: _groupPopupTextController.text,
                            ),
                          ),

                          UIHelper.verticalSpaceMedium,
                          Visibility(
                            visible: selectValidation != null ? true : false,
                            child: Text(
                              selectValidation ?? "",
                              style: TextFontStyle.errorStyle,
                            ),
                          ),

                          UIHelper.verticalSpaceMedium,
                          Text(
                            "Categoria",
                            style: TextFontStyle.headline2BoldStyle,
                          ),
                          UIHelper.verticalSpaceMedium,
                          //Category

                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5.w,
                            ),
                            height: 45.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: AppColors.borderColor, width: 0.5)),
                            child: CategoryGroupPopupWidget(
                              categorygroupPopupText:
                                  _categoryPopupValueController,
                              value: _categoryPopupTextController.text,
                            ),
                          ),
                          UIHelper.verticalSpaceMedium,
                          Visibility(
                            visible: selectValidation != null ? true : false,
                            child: Text(
                              selectValidation ?? "",
                              style: TextFontStyle.errorStyle,
                            ),
                          ),

                          UIHelper.verticalSpaceSmall,
                          Text(
                            "Sub-categoria",
                            style: TextFontStyle.headline2BoldStyle,
                          ),
                          UIHelper.verticalSpaceSmall,
                          // "Sub-categoria",
                          SubCategoryPopupList(initVal: animals), //need to work
                          UIHelper.verticalSpaceMedium,
                          Text(
                            "Descrição curta",
                            style: TextFontStyle.headline2BoldStyle,
                          ),
                          UIHelper.verticalSpaceSmall,
                          CustomNumberFormField(
                            fieldHeight: 60.h,
                            maxline: 50,
                            labelText: 'a',
                            inputType: TextInputType.name,
                            textEditingController:
                                _shortDescriptionTextController,
                          ),
                          UIHelper.verticalSpaceSemiLarge,
                          LabelTextButton(
                            icon: SvgPicture.asset(
                              AssetIcons.buttonPlusIcon,
                            ),
                            onCallBack: () async {
                              List<String> subcatIds = [];
                              List<Animal>? selectedsubcat =
                                  context.read<SubCategory>().selectedAnimals;
                              selectedsubcat?.forEach(
                                (element) =>
                                    subcatIds.add(element.id.toString()),
                              );
                              print(_groupPopupValueController.text);
                              int groupPopupInt =
                                  int.parse(_groupPopupValueController.text);
                              print('GroupPopup $groupPopupInt');
                              int catgroupPopupInt =
                                  int.parse(_categoryPopupValueController.text);

                              print('CategoryGroupPopup $catgroupPopupInt');

                              print('name ${_nameTextController.value.text}');

                              print(_shortDescriptionTextController.value.text);
                              print(_ibanTextController.value.text);
                              print(_nifTaxidTextController.value.text);
                              print(_descriptionTextController.value.text);

                              String userId = storage.read(kKeyUserID);
                              String? restaurentId = storage.read(kKeyShopID);

                              await postSaveShopBasicRXobj
                                  .postSaveShopBasicData(
                                _nameTextController.value.text,
                                _groupPopupValueController.value.text,
                                userId,
                                _categoryPopupValueController.value.text,
                                subcatIds,
                                _ibanTextController.value.text,
                                _nifTaxidTextController.value.text,
                                _shortDescriptionTextController.value.text,
                                _descriptionTextController.value.text,
                                status: restaurentId == null
                                    ? null
                                    : status
                                        ? '1'
                                        : '0',
                                id: restaurentId,
                                featuredImage: imgfile,
                              );
                              await getShopRXobj.fetchShopData();
                              await getShopListRXobj.fetchShopListData();
                            },
                            text: 'Gravar',
                          ),
                          UIHelper.verticalSpaceMedium,
                        ]),
                  ),
                  UIHelper.horizontalSpaceMedium,
                  Expanded(
                    // width: MediaQuery.of(context).size.width / 2 - 62,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "IBAN",
                          style: TextFontStyle.headline2BoldStyle,
                        ),
                        UIHelper.verticalSpaceSmall,
                        CustomNumberFormField(
                          labelText: 'iban',
                          inputType: TextInputType.name,
                          textEditingController: _ibanTextController,
                        ),

                        UIHelper.verticalSpaceMedium,
                        Text(
                          "NIF",
                          style: TextFontStyle.headline2BoldStyle,
                        ),
                        UIHelper.verticalSpaceSmall,
                        CustomNumberFormField(
                          labelText: 'NIF',
                          inputType: TextInputType.name,
                          textEditingController: _nifTaxidTextController,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          """Imagem de destaque (Tamanho máximo:2048 KB,Largura:480,Altura:300)Para redimensionar vai para https://resizeimage.net/""",
                          style: TextFontStyle.headline2BoldStyle,
                        ),
                        UIHelper.verticalSpaceSmall,
                        //imagePic
                        GestureDetector(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.image,
                            );

                            if (result != null) {
                              setState(() {
                                // for (var element in result.files) {
                                //   log(element.path!);
                                //   imagePath = element.path!;
                                // }
                                imgfile = File(result.files.single.path!);
                                imagePath = imgfile.toString();
                                _bytesImage = File(result.files.single.path!)
                                    .readAsBytesSync();
                                imgBase64Str = base64Encode(_bytesImage!);
                                log(imgBase64Str.toString());
                                log("path is  ${imagePath!.toString()}");
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
                              : (imageUrl != null)
                                  ? Image.network(
                                      imageUrl!,
                                      height: 200.h,
                                      fit: BoxFit.fill,
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
                          fieldHeight: 65,
                          maxline: 10,
                          labelText: 'a',
                          inputType: TextInputType.name,
                          textEditingController: _descriptionTextController,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Row(
                          children: [
                            FlutterSwitch(
                              disabled: activeButton,
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
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class SubCategoryPopupList extends StatefulWidget {
  SubCategoryPopupList({Key? key, required this.initVal}) : super(key: key);
  List<Animal>? initVal;

  @override
  State<SubCategoryPopupList> createState() => _SubCategoryPopupListState();
}

class _SubCategoryPopupListState extends State<SubCategoryPopupList> {
  List<MultiSelectItem<Animal>> animalLst = [];
  List<Animal> selectedList = [];
  List<Animal> animals = [];
  @override
  void initState() {
    getShopSubCategoryPopUpListRXobj.getShopSubCategoryPopupListData.listen(
      (snapShot) {
        dynamic data = snapShot;
        // log(snapShot.toString());
        if (data != null && data['data'] != null) {
          // log(data.toString());
          List<dynamic> animalData = data['data']['subCategories'];
          log(animalData.toString());
          selectedList = widget.initVal!;
          setState(() {
            animals = List<Animal>.generate(
              animalData.length,
              (i) =>
                  Animal(id: animalData[i]["id"], name: animalData[i]["name"]),
            );
            animalLst = animals
                .map((animal) => MultiSelectItem(animal, animal.name!))
                .toList();
          });
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return animalLst == null || animalLst.isEmpty
        ? Text("")
        : Container(
            padding: const EdgeInsets.all(5),
            child: MultiSelectDialogField<Animal>(
              items: animalLst,
              initialValue: selectedList,
              separateSelectedItems: true,
              buttonIcon: const Icon(Icons.arrow_drop_down),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0.r),
                border: Border.all(
                  color: AppColors.borderColor,
                  width: 1.5,
                ),
              ),
              searchHint: 'Sede Santiago Do Cacém',
              listType: MultiSelectListType.LIST,
              searchable: true,
              onConfirm: (values) {
                Provider.of<SubCategory>(context, listen: false).clearSubcat();
                Provider.of<SubCategory>(context, listen: false)
                    .selectedAnimals = values.cast<Animal>();
                setState(() {
                  selectedList = values;
                  selectedList.forEach(
                    (element) {
                      log(element.id.toString() + element.name.toString());
                    },
                  );
                });
              },
            ),
          );
  }
}

class Animal {
  int? id;
  String? name;
  Animal({this.id, this.name});
}
