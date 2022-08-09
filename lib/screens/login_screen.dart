import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../helpers/helper.dart';
import '/constants/app_color.dart';
import '/constants/app_constants.dart';
import '/constants/text_font_style.dart';
import '/constants/ui_helpers.dart';
import '/networks/api_acess.dart';
import '/widgets/custom_button.dart';

class LogeinScreen extends StatefulWidget {
  const LogeinScreen({Key? key}) : super(key: key);

  @override
  State<LogeinScreen> createState() => _LogeinScreenState();
}

class _LogeinScreenState extends State<LogeinScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? emailvalidation;
  bool validation = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                AssetIcons.deliveryman,
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: .15.sw),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(0.6),
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(
                    AssetIcons.splash,
                    height: 150.h,
                    width: 150.w,
                  ),
                  UIHelper.verticalSpaceLarge,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email or número de telemóvel (com o +indicativo de país)',
                          style: TextFontStyle.headline2BoldStyle.copyWith(
                              color: AppColors.white,
                              wordSpacing: 5,
                              letterSpacing: 3),
                        ),
                        UIHelper.verticalSpaceSmall,

                        //For Email
                        Container(
                          color: Colors.white.withOpacity(0.7),
                          child: TextFormField(
                            autovalidateMode: validation
                                ? AutovalidateMode.always
                                : AutovalidateMode.disabled,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter email';
                              }
                              return null;
                            },
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              letterSpacing: 1.5,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w100,
                              fontStyle: FontStyle.normal,
                              color: Colors.black,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 1.0, horizontal: 20),
                              hintText: 'Enter your email or phone',
                              hintStyle: TextStyle(
                                letterSpacing: 1,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                color: AppColors.disabledColor,
                              ),
                              //labelText: labelText,
                              labelStyle: TextStyle(
                                letterSpacing: 1,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w100,
                                fontStyle: FontStyle.normal,
                                color: AppColors.disabledColor,
                              ),

                              errorStyle: TextStyle(
                                letterSpacing: 1,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w100,
                                fontStyle: FontStyle.normal,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                        UIHelper.verticalSpaceLarge,
                        Text(
                          'Password',
                          style: TextFontStyle.headline2BoldStyle.copyWith(
                              color: AppColors.white,
                              wordSpacing: 5,
                              letterSpacing: 3),
                        ),
                        UIHelper.verticalSpaceSmall,
                        //For Password
                        Container(
                          color: Colors.white.withOpacity(0.7),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 9,
                                child: TextFormField(
                                  autovalidateMode: validation
                                      ? AutovalidateMode.always
                                      : AutovalidateMode.disabled,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter Password';
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                  obscureText: true,
                                  style: TextStyle(
                                    letterSpacing: 1.5,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w100,
                                    fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 1.0, horizontal: 20),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: AppColors.disabledColor,
                                    ),
                                    //labelText: labelText,
                                    labelStyle: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w100,
                                      fontStyle: FontStyle.normal,
                                      color: AppColors.disabledColor,
                                    ),

                                    errorStyle: TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 2,
                                  child: Icon(
                                    Icons.remove_red_eye_outlined,
                                    size: 30.sp,
                                    color: AppColors.disabledColor,
                                  ))
                            ],
                          ),
                        ),
                        UIHelper.verticalSpaceLarge,
                        customeButton(
                          name: 'LogIn',
                          height: .065.sh,
                          minWidth: double.infinity,
                          borderRadius: 5.r,
                          color: AppColors.primaryColor,
                          textStyle: TextFontStyle.headline1BoldStyle
                              .copyWith(color: AppColors.white),
                          context: context,
                          onCallBack: () async {
                            if (_formKey.currentState!.validate()) {
                              setId();
                              await getLoginRXobj.login(emailController.text,
                                  passwordController.text);

                              setState(() {
                                validation = true;
                              });
                            } else {
                              const snackBar = SnackBar(
                                  content:
                                      Text('Email or Password is not valid'));

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }

                            // getLoginRXobj.login(
                            //     'newrestaurant@gmail.com', '123456');
                          },
                        ),
                        UIHelper.verticalSpaceMedium,
                      ],
                    ),
                  ),
                  TextButton(
                    child: Text(
                      'Enter your password',
                      style: TextFontStyle.headline2BoldStyle,
                    ),
                    onPressed: () {},
                  ),
                  UIHelper.verticalSpaceSmall,
                  TextButton(
                    child: Text(
                      'Entrar como propietário da loja',
                      style: TextFontStyle.headline2BoldStyle,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
