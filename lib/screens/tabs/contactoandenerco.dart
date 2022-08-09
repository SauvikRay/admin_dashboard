import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '/networks/rx_post_shop_address/rx.dart';
import '/widgets/loading_indicators.dart';

import '../../constants/app_color.dart';
import '../../constants/app_constants.dart';
import '../../constants/text_font_style.dart';
import '../../constants/ui_helpers.dart';
import '../../helpers/di.dart';
import '../../networks/api_acess.dart';
import '../../widgets/custome_textfield.dart';
import '../../widgets/lebel_text_button.dart';

class Contacto extends StatefulWidget {
  const Contacto({Key? key}) : super(key: key);

  @override
  State<Contacto> createState() => _ContactoState();
}

class _ContactoState extends State<Contacto> {
  final TextEditingController phoneNumberTextController =
      TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _postalController = TextEditingController();
  bool isLoading = true;
  late String dropdownValue = 'a';
  String? imagePath;
  late double lat;
  late double long;
  Set<Marker> markers = {};
  bool status = true;
  int colorIndex = 1;
  String? addressHint;
  String? cityHint;
  String? postalHint;
  String countryCode = 'PT';
  String? countryPhone;

  //GoogleMap
  MapType mapType = MapType.normal;
  GoogleMapController? mapController;

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      isLoading = false;
      mapController = controller;
    });
  }

  Future<void> getAllAddress(double lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
    log(placemarks[0].toString());
    setState(() {
      _latitudeController.text = lat.toString();
      _longitudeController.text = long.toString();
      _addressController.text =
          '${placemarks[0].street},${placemarks[0].subAdministrativeArea},${placemarks[0].subLocality}';
      _cityController.text = '${placemarks[0].locality}';
      _postalController.text = '${placemarks[0].postalCode}';
    });
  }

  @override
  void initState() {
    getShopRXobj.getShopData.first.then(
      (value) {
        setState(() {
          lat = double.parse(value["data"]["latitude"] ?? "22.817869404135514");
          long =
              double.parse(value["data"]["longitude"] ?? "89.56025384366514");
          _emailTextController.text = value["data"]["email"] ?? "";
          _latitudeController.text = value["data"]["latitude"] ?? "";
          _longitudeController.text = value["data"]["longitude"] ?? "";
          _addressController.text = value["data"]["address"] ?? "";
          _cityController.text = value["data"]["city"] ?? "";
          _postalController.text = value["data"]["postal_code"] ?? "";
          phoneNumberTextController.text = value["data"]["phone"] ?? "";
          countryCode = value["data"]["country_code"] ?? "PT";
          countryPhone = value["data"]["country_phone"] ?? "";
          markers.add(
            Marker(
                markerId: const MarkerId('1'),
                position: LatLng(
                  lat,
                  long,
                )),
          );
          isLoading = false;
        });
        mapController!.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(lat, long), zoom: 14)));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    Orientation orientation = MediaQuery.of(context).orientation;

    return SingleChildScrollView(
      child: (ScreenUtil().screenWidth < 600)
          ? Column(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    children: [
                      Text(
                        "Telefone ",
                        style: TextFontStyle.mobileBold,
                      ),
                      Text(
                        "(Dont’t type the countrycode)",
                        style: TextFontStyle.mobileSemiBold.copyWith(
                            color: AppColors.primaryColor,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                  UIHelper.verticalSpaceSmall,
                  if (isLoading == false)
                    SizedBox(
                      height: 65.h,
                      child: IntlPhoneField(
                        initialValue: countryPhone,
                        decoration: InputDecoration(
                          contentPadding: orientation == Orientation.portrait
                              ? EdgeInsets.fromLTRB(20.w, 0.h, 0, 12.h)
                              : EdgeInsets.fromLTRB(20.w, 6.h, 0, 12.h),
                          hintStyle: TextStyle(
                            letterSpacing: 1,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            color: AppColors.disabledColor,
                          ),
                          //labelText: labelText,
                          labelStyle: TextStyle(
                            letterSpacing: 1,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                            color: AppColors.disabledColor,
                          ),
                          errorStyle: TextStyle(
                            letterSpacing: 1,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w100,
                            fontStyle: FontStyle.normal,
                            color: AppColors.disabledColor,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                            borderSide: const BorderSide(
                              color: AppColors.borderColor,
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                            borderSide: const BorderSide(
                              color: AppColors.disabledColor,
                              width: 1.5,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                            borderSide: const BorderSide(
                              color: AppColors.borderColor,
                              width: 1.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                            borderSide: const BorderSide(
                              color: AppColors.borderColor,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0.r),
                            borderSide: const BorderSide(
                              color: AppColors.borderColor,
                              width: 1.5,
                            ),
                          ),
                        ),
                        style: const TextStyle(
                          letterSpacing: 5,
                          height: 1.6,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          color: AppColors.headLine2Color,
                        ),
                        dropdownIconPosition: IconPosition.leading,
                        textAlignVertical: TextAlignVertical.center,
                        cursorHeight: 20,
                        initialCountryCode: countryCode.toUpperCase(),
                        onChanged: (phone) {
                          phone.countryCode;
                          countryCode = phone.countryISOCode;
                          countryPhone = phone.number;
                          phoneNumberTextController.text =
                              phone.completeNumber.toString();
                          print(phone.completeNumber);
                        },
                      ),
                    ),
                  UIHelper.verticalSpaceSmall,
                  Text(
                    "Email",
                    style: TextFontStyle.headline2BoldStyle,
                  ),
                  UIHelper.verticalSpaceSmall,
                  CustomNumberFormField(
                    hintText: 'Sede Santiago Do Cacém',
                    labelText: 'a',
                    inputType: TextInputType.name,
                    textEditingController: _emailTextController,
                  ),
                  UIHelper.verticalSpaceMedium,
                  Text(
                    "Address",
                    style: TextFontStyle.headline2BoldStyle,
                  ),
                  UIHelper.verticalSpaceSmall,
                  CustomNumberFormField(
                    labelText: 'a',
                    maxline: 2,
                    hintText: addressHint,
                    inputType: TextInputType.name,
                    textEditingController: _addressController,
                  ),
                  UIHelper.verticalSpaceMedium,
                  Text(
                    "Latitude",
                    style: TextFontStyle.headline2BoldStyle,
                  ),
                  UIHelper.verticalSpaceSmall,
                  CustomNumberFormField(
                    labelText: 'lat',
                    // hintText: lat.toString(),
                    inputType: TextInputType.name,
                    textEditingController: _latitudeController,
                  ),
                  UIHelper.verticalSpaceMedium,
                  Text(
                    "Longitude",
                    style: TextFontStyle.headline2BoldStyle,
                  ),
                  UIHelper.verticalSpaceSmall,
                  CustomNumberFormField(
                    labelText: 'long',
                    //hintText: long.toString(),
                    inputType: TextInputType.name,
                    textEditingController: _longitudeController,
                  ),
                  UIHelper.verticalSpaceMedium,
                  Text(
                    "City",
                    style: TextFontStyle.headline2BoldStyle,
                  ),
                  UIHelper.verticalSpaceSmall,
                  CustomNumberFormField(
                    labelText: 'city',
                    hintText: cityHint,
                    inputType: TextInputType.name,
                    textEditingController: _cityController,
                  ),
                  UIHelper.verticalSpaceMedium,
                  Text(
                    "Postal Code",
                    style: TextFontStyle.headline2BoldStyle,
                  ),
                  UIHelper.verticalSpaceSmall,
                  CustomNumberFormField(
                    labelText: 'zip code',
                    hintText: postalHint,
                    inputType: TextInputType.name,
                    textEditingController: _postalController,
                  ),
                  UIHelper.verticalSpaceSemiLarge,
                ]),
                UIHelper.verticalSpaceSmall,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //'Ir para a localização atual
                    Material(
                      elevation: 3.0,
                      child: SizedBox(
                        height: 35.h,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Ir para a localização atual',
                            style: TextFontStyle.subtitle1BoldStyle,
                          ),
                        ),
                      ),
                    ),

                    UIHelper.verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Map Switching
                        Material(
                          elevation: 5.0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.white.withOpacity(0.5)),
                            child: SizedBox(
                              height: 35.h,
                              width: 130.w,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            colorIndex = 1;
                                            mapType = MapType.normal;
                                          });
                                        },
                                        child: Text(
                                          'Mapa',
                                          style: colorIndex == 1
                                              ? TextFontStyle.subtitle1BoldStyle
                                                  .copyWith(color: Colors.black)
                                              : TextFontStyle
                                                  .subtitle1RegularStyle,
                                        )),
                                    const VerticalDivider(
                                      color: AppColors.disabledColor,
                                      thickness: 0.5,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            colorIndex = 2;
                                            mapType = MapType.satellite;
                                          });
                                        },
                                        child: Text(
                                          'Satélite',
                                          style: colorIndex == 2
                                              ? TextFontStyle.subtitle1BoldStyle
                                                  .copyWith()
                                              : TextFontStyle
                                                  .subtitle1RegularStyle,
                                        )),

                                    // TextButton(onPressed: (){}, child: Text('Satélite')),
                                  ]),
                            ),
                          ),
                        ),

                        //boxButton
                        MaterialButton(
                          color: AppColors.white.withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r)),
                          minWidth: 30.w,
                          height: 40.h,
                          elevation: 3.0,
                          onPressed: () {},
                          child: SvgPicture.asset(AssetIcons.dashBox),
                        ),
                      ],
                    ),

                    UIHelper.verticalSpaceMedium,

                    //Google Map
                    SizedBox(
                      height: 310.w,
                      child: isLoading
                          ? loadingIndicatorCircle(context: context)
                          : GoogleMap(
                              scrollGesturesEnabled: true,
                              gestureRecognizers:
                                  <Factory<OneSequenceGestureRecognizer>>[
                                Factory<OneSequenceGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                                ),
                              ].toSet(),
                              zoomGesturesEnabled: true,
                              compassEnabled: true,
                              myLocationButtonEnabled: true,
                              myLocationEnabled: true,
                              onTap: (val) {
                                log(val.toString());

                                setState(() {
                                  lat = val.latitude;
                                  long = val.longitude;
                                  markers.add(
                                    Marker(
                                        markerId: const MarkerId('1'),
                                        position: LatLng(
                                          val.latitude,
                                          val.longitude,
                                        )),
                                  );
                                  getAllAddress(val.latitude, val.longitude);
                                });
                                mapController!.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: LatLng(
                                                val.latitude, val.longitude),
                                            zoom: 14)));
                              },
                              onMapCreated: _onMapCreated,
                              mapType: mapType,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(lat, long),
                                zoom: 14.0,
                              ),
                              markers: markers,
                            ),
                    ),
                    UIHelper.verticalSpaceMedium,
                    LabelTextButton(
                      icon: SvgPicture.asset(
                        AssetIcons.buttonPlusIcon,
                      ),
                      onCallBack: () async {
                        await postShopAddressRXobj.postShopAddress(
                            email: _emailTextController.text,
                            lat: _latitudeController.text,
                            long: _longitudeController.text,
                            address: _addressController.text,
                            city: _cityController.text,
                            phone: phoneNumberTextController.text,
                            countyCode: countryCode,
                            countyPhone: countryPhone,
                            postalcode: _postalController.text);
                        await getShopRXobj.fetchShopData();
                      },
                      text: 'Gravar',
                    )
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Telefone ",
                              style: TextFontStyle.headline2BoldStyle,
                            ),
                            Text(
                              "(Dont’t type the countrycode with the number)",
                              style: TextFontStyle.headline2BoldStyle
                                  .copyWith(color: AppColors.primaryColor),
                            )
                          ],
                        ),
                        UIHelper.verticalSpaceSmall,
                        if (isLoading == false)
                          SizedBox(
                            height: 65.h,
                            child: IntlPhoneField(
                              initialValue: countryPhone,
                              decoration: InputDecoration(
                                contentPadding: orientation ==
                                        Orientation.portrait
                                    ? EdgeInsets.fromLTRB(20.w, 0.h, 0, 12.h)
                                    : EdgeInsets.fromLTRB(20.w, 6.h, 0, 12.h),
                                hintStyle: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                  color: AppColors.disabledColor,
                                ),
                                //labelText: labelText,
                                labelStyle: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w100,
                                  fontStyle: FontStyle.normal,
                                  color: AppColors.disabledColor,
                                ),
                                errorStyle: TextStyle(
                                  letterSpacing: 1,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w100,
                                  fontStyle: FontStyle.normal,
                                  color: AppColors.disabledColor,
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.borderColor,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.disabledColor,
                                    width: 1.5,
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.borderColor,
                                    width: 1.5,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.borderColor,
                                    width: 1.5,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0.r),
                                  borderSide: const BorderSide(
                                    color: AppColors.borderColor,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              style: const TextStyle(
                                letterSpacing: 5,
                                height: 1.6,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: AppColors.headLine2Color,
                              ),
                              dropdownIconPosition: IconPosition.leading,
                              textAlignVertical: TextAlignVertical.center,
                              cursorHeight: 20,
                              initialCountryCode: countryCode.toUpperCase(),
                              onChanged: (phone) {
                                phone.countryCode;
                                countryCode = phone.countryISOCode;
                                countryPhone = phone.number;
                                phoneNumberTextController.text =
                                    phone.completeNumber.toString();
                                print(phone.completeNumber);
                              },
                            ),
                          ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          "Email",
                          style: TextFontStyle.headline2BoldStyle,
                        ),
                        UIHelper.verticalSpaceSmall,
                        CustomNumberFormField(
                          hintText: 'Sede Santiago Do Cacém',
                          labelText: 'a',
                          inputType: TextInputType.name,
                          textEditingController: _emailTextController,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          "Address",
                          style: TextFontStyle.headline2BoldStyle,
                        ),
                        UIHelper.verticalSpaceSmall,
                        CustomNumberFormField(
                          labelText: 'a',
                          maxline: 2,
                          hintText: addressHint,
                          inputType: TextInputType.name,
                          textEditingController: _addressController,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          "Latitude",
                          style: TextFontStyle.headline2BoldStyle,
                        ),
                        UIHelper.verticalSpaceSmall,
                        CustomNumberFormField(
                          labelText: 'lat',
                          // hintText: lat.toString(),
                          inputType: TextInputType.name,
                          textEditingController: _latitudeController,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          "Longitude",
                          style: TextFontStyle.headline2BoldStyle,
                        ),
                        UIHelper.verticalSpaceSmall,
                        CustomNumberFormField(
                          labelText: 'long',
                          //hintText: long.toString(),
                          inputType: TextInputType.name,
                          textEditingController: _longitudeController,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          "City",
                          style: TextFontStyle.headline2BoldStyle,
                        ),
                        UIHelper.verticalSpaceSmall,
                        CustomNumberFormField(
                          labelText: 'city',
                          hintText: cityHint,
                          inputType: TextInputType.name,
                          textEditingController: _cityController,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          "Postal Code",
                          style: TextFontStyle.headline2BoldStyle,
                        ),
                        UIHelper.verticalSpaceSmall,
                        CustomNumberFormField(
                          labelText: 'zip code',
                          hintText: postalHint,
                          inputType: TextInputType.name,
                          textEditingController: _postalController,
                        ),
                        UIHelper.verticalSpaceMedium,
                        LabelTextButton(
                          icon: SvgPicture.asset(
                            AssetIcons.buttonPlusIcon,
                          ),
                          onCallBack: () async {
                            await postShopAddressRXobj.postShopAddress(
                                email: _emailTextController.text,
                                lat: _latitudeController.text,
                                long: _longitudeController.text,
                                address: _addressController.text,
                                city: _cityController.text,
                                phone: phoneNumberTextController.text,
                                countyCode: countryCode,
                                countyPhone: countryPhone,
                                postalcode: _postalController.text);
                            await getShopRXobj.fetchShopData();
                          },
                          text: 'Gravar',
                        )
                      ]),
                ),
                UIHelper.horizontalSpaceSmall,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Map Switching
                          Material(
                            elevation: 5.0,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.white.withOpacity(0.5)),
                              child: SizedBox(
                                height: 35.h,
                                width: 130.w,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              colorIndex = 1;
                                              mapType = MapType.normal;
                                            });
                                          },
                                          child: Text(
                                            'Mapa',
                                            style: colorIndex == 1
                                                ? TextFontStyle
                                                    .subtitle1BoldStyle
                                                    .copyWith(
                                                        color: Colors.black)
                                                : TextFontStyle
                                                    .subtitle1RegularStyle,
                                          )),
                                      const VerticalDivider(
                                        color: AppColors.disabledColor,
                                        thickness: 0.5,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              colorIndex = 2;
                                              mapType = MapType.satellite;
                                            });
                                          },
                                          child: Text(
                                            'Satélite',
                                            style: colorIndex == 2
                                                ? TextFontStyle
                                                    .subtitle1BoldStyle
                                                    .copyWith()
                                                : TextFontStyle
                                                    .subtitle1RegularStyle,
                                          )),

                                      // TextButton(onPressed: (){}, child: Text('Satélite')),
                                    ]),
                              ),
                            ),
                          ),

                          //'Ir para a localização atual
                          Material(
                            elevation: 3.0,
                            child: SizedBox(
                              height: 35.h,
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Ir para a localização atual',
                                  style: TextFontStyle.subtitle1BoldStyle,
                                ),
                              ),
                            ),
                          ),

                          //boxButton
                          MaterialButton(
                            color: AppColors.white.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r)),
                            minWidth: 30.w,
                            height: 40.h,
                            elevation: 3.0,
                            onPressed: () {},
                            child: SvgPicture.asset(AssetIcons.dashBox),
                          ),
                        ],
                      ),

                      UIHelper.verticalSpaceMedium,

                      //Google Map
                      SizedBox(
                        height: 310.w,
                        child: isLoading
                            ? loadingIndicatorCircle(context: context)
                            : GoogleMap(
                                compassEnabled: true,
                                myLocationButtonEnabled: true,
                                myLocationEnabled: true,
                                onTap: (val) {
                                  log(val.toString());

                                  setState(() {
                                    lat = val.latitude;
                                    long = val.longitude;
                                    markers.add(
                                      Marker(
                                          markerId: const MarkerId('1'),
                                          position: LatLng(
                                            val.latitude,
                                            val.longitude,
                                          )),
                                    );
                                    getAllAddress(val.latitude, val.longitude);
                                  });
                                  mapController!.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          CameraPosition(
                                              target: LatLng(
                                                  val.latitude, val.longitude),
                                              zoom: 14)));
                                },
                                onMapCreated: _onMapCreated,
                                scrollGesturesEnabled: true,
                                zoomGesturesEnabled: true,
                                mapType: mapType,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(lat, long),
                                  zoom: 14.0,
                                ),
                                markers: markers,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
