import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_color.dart';

class TextFontStyle {
//Initialising Constractor
  TextFontStyle._();

  //Regular
  static final headline1RegularStyle = GoogleFonts.montserrat(
      color: AppColors.disabledColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.w400);

  static final headline2RegularStyle = GoogleFonts.montserrat(
      color: AppColors.disabledColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400);

  static final subtitle1RegularStyle = GoogleFonts.montserrat(
      color: AppColors.disabledColor,
      fontSize: 12.sp,
      fontWeight: FontWeight.w400);

  static final smallText = GoogleFonts.montserrat(
    color: Colors.white,
    fontSize: 9.sp,
    fontWeight: FontWeight.w400,
  );

  //Bold

  static final headline1BoldStyle = GoogleFonts.montserrat(
      color: AppColors.headLine1Color,
      fontSize: 16.sp,
      fontWeight: FontWeight.w800);

  static final headline2BoldStyle = GoogleFonts.montserrat(
      color: AppColors.disabledColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w800);

  static final subtitle1BoldStyle = GoogleFonts.montserrat(
      color: AppColors.headLine2Color,
      fontSize: 12.sp,
      fontWeight: FontWeight.w800);

  static final tableHeader = GoogleFonts.montserrat(
      color: AppColors.headLine2Color,
      fontSize: 12.sp,
      fontWeight: FontWeight.w800);

  static final popUpselectedText = GoogleFonts.montserrat(
      fontSize: 16.sp,
      color: AppColors.primaryColor,
      letterSpacing: 1,
      fontWeight: FontWeight.w400);

  static final headlineRegulardStyle = GoogleFonts.montserrat(
      color: AppColors.disabledColor,
      fontSize: 16.sp,
      fontWeight: FontWeight.normal);

  static final buttonBoldStyle = GoogleFonts.montserrat(
      color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.w800);

  static final errorStyle = GoogleFonts.montserrat(
      color: Colors.red, fontSize: 14.sp, fontWeight: FontWeight.w400);

  //For Mobile
  static final mobileSemiBold = GoogleFonts.montserrat(
      color: AppColors.secondaryColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400);

  static final mobileBold = GoogleFonts.montserrat(
      color: AppColors.secondaryColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold);
  static final mobileNormal = GoogleFonts.montserrat(
      color: AppColors.secondaryColor,
      fontSize: 14.sp,
      fontWeight: FontWeight.normal);
}
