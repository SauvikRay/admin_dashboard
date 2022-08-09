import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import '/constants/app_color.dart';
import '/constants/ui_helpers.dart';
import '/helpers/navigation_service.dart';

import '../../constants/app_constants.dart';
import '../../constants/text_font_style.dart';
import '../../helpers/helper.dart';
import '../../networks/api_acess.dart';
import '../../widgets/lebel_text_button.dart';

class Horario extends StatefulWidget {
  const Horario({Key? key}) : super(key: key);

  @override
  State<Horario> createState() => _HorarioState();
}

class _HorarioState extends State<Horario> {
  //CheckBox
  bool isSunChecked = false;
  bool isMonChecked = false;
  bool isTueChecked = false;
  bool isWedChecked = false;
  bool isThuChecked = false;
  bool isFriChecked = false;
  bool isSatChecked = false;
//Opening Time
  String? sunOpeniongTimeSt;
  late TimeOfDay sunOpeningTime = sunOpeniongTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(sunOpeniongTimeSt!);

  _selectSunOpeningTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: sunOpeningTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        sunOpeningTime = timeOfDay;
        sunOpeniongTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? monOpeningTimeSt;
  late TimeOfDay monOpeningTime = monOpeningTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(monOpeningTimeSt!);

  _selectMonOpeningTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: monOpeningTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        monOpeningTime = timeOfDay;
        monOpeningTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? tueOpeningTimeSt;
  late TimeOfDay tueOpeningTime = tueOpeningTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(tueOpeningTimeSt!);

  _selectTueOpeningTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: tueOpeningTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        tueOpeningTime = timeOfDay;
        tueOpeningTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? wedOpeningTimeSt;
  late TimeOfDay wedOpeningTime = wedOpeningTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(wedOpeningTimeSt!);
  _selectWedOpeningTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: wedOpeningTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        wedOpeningTime = timeOfDay;
        wedOpeningTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? thuOpeningTimeSt;
  late TimeOfDay thuOpeningTime = thuOpeningTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(thuOpeningTimeSt!);
  _selectThuOpeningTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: thuOpeningTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        thuOpeningTime = timeOfDay;
        thuOpeningTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? friOpeningTimeSt;
  late TimeOfDay friOpeningTime = friOpeningTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(friOpeningTimeSt!);
  _selectFriOpeningTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: friOpeningTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        friOpeningTime = timeOfDay;
        friOpeningTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? satOpeningTimeSt;
  late TimeOfDay satOpeningTime = satOpeningTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(satOpeningTimeSt!);
  _selectSatOpeningTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: satOpeningTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        satOpeningTime = timeOfDay;
        satOpeningTimeSt = timeOfDay.to24hours();
      });
    }
  }

//Break Start Time
  String? sunBreakStartTimeSt;
  late TimeOfDay sunBreakStartTime = sunBreakStartTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(sunBreakStartTimeSt!);
  _selectSunBreakStartTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: sunBreakStartTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        sunBreakStartTime = timeOfDay;
        sunBreakStartTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? monBreakStartTimeSt;
  late TimeOfDay monBreakStartTime = monBreakStartTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(monBreakStartTimeSt!);

  _selectMonBreakStartTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: monBreakStartTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        monBreakStartTime = timeOfDay;
        monBreakStartTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? tueBreakStartTimeSt;
  late TimeOfDay tueBreakStartTime = tueBreakStartTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(tueBreakStartTimeSt!);
  _selectTueBreakStartTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: tueBreakStartTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        tueBreakStartTime = timeOfDay;
        tueBreakStartTimeSt == timeOfDay.to24hours();
      });
    }
  }

  String? wedBreakStartTimeSt;
  late TimeOfDay wedBreakStartTime = wedBreakStartTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(wedBreakStartTimeSt!);
  _selectWedBreakStartTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: wedBreakStartTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        wedBreakStartTime = timeOfDay;
        wedBreakStartTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? thuBreakStartTimeSt;
  late TimeOfDay thuBreakStartTime = thuBreakStartTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(thuBreakStartTimeSt!);

  _selectThuBreakStartTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: thuBreakStartTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null && timeOfDay != thuBreakStartTime) {
      setState(() {
        thuBreakStartTime = timeOfDay;
        thuBreakStartTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? friBreakStartTimeSt;
  late TimeOfDay friBreakStartTime = friBreakStartTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(friBreakStartTimeSt!);
  _selectFriBreakStartTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: friBreakStartTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        friBreakStartTime = timeOfDay;
        friBreakStartTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? satBreakStartTimeSt;
  late TimeOfDay satBreakStartTime = satBreakStartTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(satBreakStartTimeSt!);
  _selectSatBreakStartTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: satBreakStartTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        satBreakStartTime = timeOfDay;
        satBreakStartTimeSt = timeOfDay.to24hours();
      });
    }
  }

//Break End Time

  String? sunBreakEndTimeSt;
  late TimeOfDay sunBreakEndTime = sunBreakEndTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(sunBreakEndTimeSt!);
  _selectSunBreakEndTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: sunBreakEndTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        sunBreakEndTime = timeOfDay;
        sunBreakEndTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? monBreakEndTimeSt;
  late TimeOfDay monBreakEndTime = monBreakEndTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(monBreakEndTimeSt!);

  _selectMonBreakEndTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: monBreakEndTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        monBreakEndTime = timeOfDay;
        monBreakEndTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? tueBreakEndTimeSt;
  late TimeOfDay tueBreakEndTime = monBreakEndTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(tueBreakEndTimeSt!);

  _selectTueBreakEndTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: tueBreakEndTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        tueBreakEndTime = timeOfDay;
        tueBreakEndTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? wedBreakEndTimeSt;
  late TimeOfDay wedBreakEndTime = wedBreakEndTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(wedBreakEndTimeSt!);
  _selectWedBreakEndTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: wedBreakEndTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        wedBreakEndTime = timeOfDay;
        wedBreakEndTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? thuBreakEndTimeSt;
  late TimeOfDay thuBreakEndTime = thuBreakEndTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(thuBreakEndTimeSt!);

  _selectThuBreakEndTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: thuBreakEndTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        thuBreakEndTime = timeOfDay;
        thuBreakEndTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? friBreakEndTimeSt;
  late TimeOfDay friBreakEndTime = friBreakEndTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(friBreakEndTimeSt!);
  _selectFriBreakEndTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: friBreakEndTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        friBreakEndTime = timeOfDay;
        friBreakEndTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? satBreakEndTimeSt;
  late TimeOfDay satBreakEndTime = satBreakEndTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(satBreakEndTimeSt!);

  _selectSatBreakEndTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: satBreakEndTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        satBreakEndTime = timeOfDay;
        satBreakEndTimeSt = timeOfDay.toString();
      });
    }
  }

//Closing Time

  String? sunClosingTimeSt;
  late TimeOfDay sunClosingTime = sunClosingTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(sunClosingTimeSt!);
  _selectSunClosingTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: sunClosingTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        sunClosingTime = timeOfDay;
        sunClosingTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? monClosingTimeSt;
  late TimeOfDay monClosingTime = monClosingTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(monClosingTimeSt!);

  _selectMonClosingTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: monClosingTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        monClosingTime = timeOfDay;
        monClosingTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? tueClosingTimeSt;
  late TimeOfDay tueClosingTime = tueClosingTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(tueClosingTimeSt!);

  _selectTueClosingTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: tueClosingTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        tueClosingTime = timeOfDay;
        tueClosingTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? wedClosingTimeSt;
  late TimeOfDay wedClosingTime = wedClosingTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(wedClosingTimeSt!);
  _selectWedClosingTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: wedClosingTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        wedClosingTime = timeOfDay;
        wedClosingTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? thuClosingTimeSt;
  late TimeOfDay thuClosingTime = thuClosingTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(thuClosingTimeSt!);

  _selectThuClosingTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: thuClosingTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        thuClosingTime = timeOfDay;
        thuClosingTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? friClosingTimeSt;
  late TimeOfDay friClosingTime = friClosingTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(friClosingTimeSt!);

  _selectFriClosingTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: friClosingTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        friClosingTime = timeOfDay;
        friClosingTimeSt = timeOfDay.to24hours();
      });
    }
  }

  String? satClosingTimeSt;
  late TimeOfDay satClosingTime = satClosingTimeSt == null
      ? const TimeOfDay(hour: 00, minute: 00)
      : formattedTnD(satClosingTimeSt!);
  _selectSatClosingTime() async {
    final TimeOfDay? timeOfDay = await showTimePicker(
      context: NavigationService.context,
      initialTime: satClosingTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (timeOfDay != null) {
      setState(() {
        satClosingTime = timeOfDay;
        satClosingTimeSt = timeOfDay.to24hours();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getShopHolidaysListApiRXobj.getShopHolidayResData.first.then(
      (value) {
        List d = value["data"]["shopSchedule"];

        setState(() {
          //sunday
          isSunChecked = d[0]['weekend'] == 0 ? false : true;
          sunOpeniongTimeSt = d[0]['opening'];
          sunClosingTimeSt = d[0]['closing'];
          sunBreakStartTimeSt = d[0]['break_start'];
          sunBreakEndTimeSt = d[0]['break_end'];
          //mon
          isMonChecked = d[1]['weekend'] == 0 ? false : true;
          monOpeningTimeSt = d[1]['opening'];
          monClosingTimeSt = d[1]['closing'];
          monBreakStartTimeSt = d[1]['break_start'];
          monBreakEndTimeSt = d[1]['break_end'];
          //tue
          isTueChecked = d[2]['weekend'] == 0 ? false : true;
          tueOpeningTimeSt = d[2]['opening'];
          tueClosingTimeSt = d[2]['closing'];
          tueBreakStartTimeSt = d[2]['break_start'];
          tueBreakEndTimeSt = d[2]['break_end'];
          //wed
          isWedChecked = d[3]['weekend'] == 0 ? false : true;
          wedOpeningTimeSt = d[3]['opening'];
          wedClosingTimeSt = d[3]['closing'];
          wedBreakStartTimeSt = d[3]['break_start'];
          wedBreakEndTimeSt = d[3]['break_end'];
          //thu
          isTueChecked = d[4]['weekend'] == 0 ? false : true;
          thuOpeningTimeSt = d[4]['opening'];
          thuClosingTimeSt = d[4]['closing'];
          thuBreakStartTimeSt = d[4]['break_start'];
          thuBreakEndTimeSt = d[4]['break_end'];
          //fri
          isFriChecked = d[5]['weekend'] == 0 ? false : true;
          friOpeningTimeSt = d[5]['opening'];
          friClosingTimeSt = d[5]['closing'];
          friBreakStartTimeSt = d[5]['break_start'];
          friBreakEndTimeSt = d[5]['break_end'];
          //sat
          isSatChecked = d[6]['weekend'] == 0 ? false : true;
          satOpeningTimeSt = d[6]['opening'];
          satClosingTimeSt = d[6]['closing'];
          satBreakStartTimeSt = d[6]['break_start'];
          satBreakEndTimeSt = d[6]['break_end'];
          log(d.toString());
        });
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Theme(
              data: Theme.of(context)
                  .copyWith(dividerColor: AppColors.scaffoldColor),
              child: DataTable(
                columnSpacing: 45.w,
                dataRowHeight: 80.h,
                horizontalMargin: 5,
                dividerThickness: 0,
                dataTextStyle: TextFontStyle.headline2RegularStyle,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text('Dias',
                        style: TextFontStyle.tableHeader,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left),
                  ),
                  DataColumn(
                    label: Text('Fim de semana',
                        style: TextFontStyle.tableHeader,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left),
                  ),
                  DataColumn(
                    label: Text('Abertura',
                        style: TextFontStyle.tableHeader,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left),
                  ),
                  DataColumn(
                    label: Text('Fecho intermédio',
                        style: TextFontStyle.tableHeader,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left),
                  ),
                  DataColumn(
                    label: Text('Abertura intermédia',
                        style: TextFontStyle.tableHeader,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left),
                  ),
                  DataColumn(
                    label: Text('Encerramento',
                        style: TextFontStyle.tableHeader,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left),
                  ),
                  DataColumn(
                    label: Text('Reiniciar',
                        style: TextFontStyle.tableHeader,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left),
                  ),
                ],
                rows: createRow(),
              ),
            ),
          ),
          UIHelper.verticalSpaceMedium,
          LabelTextButton(
            icon: SvgPicture.asset(
              AssetIcons.buttonPlusIcon,
            ),
            onCallBack: () async {
              await postShopScheduleRXobj.postShopSchedule(
                weekend_Sunday: isSunChecked == false ? '0' : '1',
                day_opening_Sunday: sunOpeniongTimeSt == null
                    ? null
                    : sunOpeningTime.to24hours(),
                day_break_start_Sunday: sunBreakStartTimeSt == null
                    ? null
                    : sunBreakStartTime.to24hours(),
                day_break_end_Sunday: sunBreakEndTimeSt == null
                    ? null
                    : sunBreakEndTime.to24hours(),
                day_closing_Sunday: sunClosingTimeSt == null
                    ? null
                    : sunClosingTime.to24hours(),
                weekend_Monday: isMonChecked == false ? '0' : '1',
                day_opening_Monday: monOpeningTimeSt == null
                    ? null
                    : monOpeningTime.to24hours(),
                day_break_start_Monday: monBreakStartTimeSt == null
                    ? null
                    : monBreakStartTime.to24hours(),
                day_break_end_Monday: monBreakEndTimeSt == null
                    ? null
                    : monBreakEndTime.to24hours(),
                day_closing_Monday: monClosingTimeSt == null
                    ? null
                    : monClosingTime.to24hours(),
                weekend_Tuesday: isTueChecked == false ? '0' : '1',
                day_opening_Tuesday: tueOpeningTimeSt == null
                    ? null
                    : tueOpeningTime.to24hours(),
                day_break_start_Tuesday: tueBreakStartTimeSt == null
                    ? null
                    : tueBreakStartTime.to24hours(),
                day_break_end_Tuesday: tueBreakEndTimeSt == null
                    ? null
                    : tueBreakEndTime.to24hours(),
                day_closing_Tuesday: tueClosingTimeSt == null
                    ? null
                    : tueClosingTime.to24hours(),
                weekend_Wednesday: isWedChecked == false ? '0' : '1',
                day_opening_Wednesday: wedOpeningTimeSt == null
                    ? null
                    : wedOpeningTime.to24hours(),
                day_break_start_Wednesday: wedBreakStartTimeSt == null
                    ? null
                    : wedBreakStartTime.to24hours(),
                day_break_end_Wednesday: wedClosingTimeSt == null
                    ? null
                    : wedBreakEndTime.to24hours(),
                day_closing_Wednesday: sunOpeniongTimeSt == null
                    ? null
                    : wedClosingTime.to24hours(),
                weekend_Thursday: isThuChecked == false ? '0' : '1',
                day_opening_Thursday: thuOpeningTimeSt == null
                    ? null
                    : thuOpeningTime.to24hours(),
                day_break_start_Thursday: thuBreakStartTimeSt == null
                    ? null
                    : thuBreakStartTime.to24hours(),
                day_break_end_Thursday: thuBreakEndTimeSt == null
                    ? null
                    : thuBreakEndTime.to24hours(),
                day_closing_Thursday: thuClosingTimeSt == null
                    ? null
                    : thuClosingTime.to24hours(),
                weekend_Friday: isFriChecked == false ? '0' : '1',
                day_opening_Friday: friOpeningTimeSt == null
                    ? null
                    : friOpeningTime.to24hours(),
                day_break_start_Friday: friBreakStartTimeSt == null
                    ? null
                    : friBreakStartTime.to24hours(),
                day_break_end_Friday: friBreakEndTimeSt == null
                    ? null
                    : friBreakEndTime.to24hours(),
                day_closing_Friday: friClosingTimeSt == null
                    ? null
                    : friClosingTime.to24hours(),
                weekend_Saturday: isSatChecked == false ? '0' : '1',
                day_opening_Saturday: satOpeningTimeSt == null
                    ? null
                    : satOpeningTime.to24hours(),
                day_break_start_Saturday: satBreakStartTimeSt == null
                    ? null
                    : satBreakStartTime.to24hours(),
                day_break_end_Saturday: satBreakEndTimeSt == null
                    ? null
                    : satBreakEndTime.to24hours(),
                day_closing_Saturday: satClosingTimeSt == null
                    ? null
                    : satClosingTime.to24hours(),
              );
              await getShopHolidaysListApiRXobj.getShopHolidayListData();
            },
            text: 'Gravar',
          ),
        ],
      ),
    );
  }

  List<DataRow> createRow() {
    return [
      DataRow(cells: [
        DataCell(
          Text(
            'Sunday',
            style: TextFontStyle.subtitle1RegularStyle.copyWith(
              letterSpacing: 1,
            ),
          ),
        ),
        DataCell(
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              value: isSunChecked,
              onChanged: (bool? value) {
                setState(() {
                  isSunChecked = value!;
                });
              },
            ),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectSunOpeningTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: sunOpeniongTimeSt == null
                ? "--:-- --"
                : sunOpeningTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectSunBreakStartTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: sunBreakStartTimeSt == null
                ? "--:-- --"
                : sunBreakStartTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectSunBreakEndTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: sunBreakEndTimeSt == null
                ? "--:-- --"
                : sunBreakEndTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectSunClosingTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: sunClosingTimeSt == null
                ? "--:-- --"
                : sunClosingTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.primaryColor,
            elevation: 5.0,
            onPressed: () {
              setState(() {
                isSunChecked = false;
                sunOpeningTime = const TimeOfDay(hour: 00, minute: 00);
                sunBreakStartTime = const TimeOfDay(hour: 00, minute: 00);
                sunBreakEndTime = const TimeOfDay(hour: 00, minute: 00);
                sunClosingTime = const TimeOfDay(hour: 00, minute: 00);
                sunOpeniongTimeSt = null;
              });
            },
            icon: const Icon(Icons.refresh),
            text: 'Redefinir',
            textStyle: TextFontStyle.headline2RegularStyle
                .copyWith(color: Colors.white),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          Text(
            'Monday',
            style: TextFontStyle.subtitle1RegularStyle.copyWith(
              letterSpacing: 1,
            ),
          ),
        ),
        DataCell(
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              value: isMonChecked,
              onChanged: (bool? value) {
                setState(() {
                  isMonChecked = value!;
                });
              },
            ),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectMonOpeningTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: monOpeningTimeSt == null
                ? "--:-- --"
                : monOpeningTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectMonBreakStartTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: monBreakStartTimeSt == null
                ? "--:-- --"
                : monBreakStartTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectMonBreakEndTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: monBreakEndTimeSt == null
                ? "--:-- --"
                : monBreakEndTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectMonClosingTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: monClosingTimeSt == null
                ? "--:-- --"
                : monClosingTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.primaryColor,
            elevation: 5.0,
            onPressed: () {
              setState(() {
                isMonChecked = false;
                monOpeningTime = const TimeOfDay(hour: 00, minute: 00);
                monBreakStartTime = const TimeOfDay(hour: 00, minute: 00);
                monBreakEndTime = const TimeOfDay(hour: 00, minute: 00);
                monClosingTime = const TimeOfDay(hour: 00, minute: 00);
              });
            },
            icon: const Icon(Icons.refresh),
            text: 'Redefinir',
            textStyle: TextFontStyle.headline2RegularStyle
                .copyWith(color: Colors.white),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          Text(
            'Tuesday',
            style: TextFontStyle.subtitle1RegularStyle.copyWith(
              letterSpacing: 1,
            ),
          ),
        ),
        DataCell(
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              value: isTueChecked,
              onChanged: (bool? value) {
                setState(() {
                  isTueChecked = value!;
                });
              },
            ),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectTueOpeningTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: tueOpeningTimeSt == null
                ? "--:-- --"
                : tueOpeningTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectTueBreakStartTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: tueBreakStartTimeSt == null
                ? "--:-- --"
                : tueBreakStartTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectTueBreakEndTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: tueBreakEndTimeSt == null
                ? "--:-- --"
                : tueBreakEndTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectTueClosingTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: tueClosingTimeSt == null
                ? "--:-- --"
                : tueClosingTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.primaryColor,
            elevation: 5.0,
            onPressed: () {
              setState(() {
                isTueChecked = false;
                tueOpeningTime = const TimeOfDay(hour: 00, minute: 00);
                tueBreakStartTime = const TimeOfDay(hour: 00, minute: 00);
                tueBreakEndTime = const TimeOfDay(hour: 00, minute: 00);
                tueClosingTime = const TimeOfDay(hour: 00, minute: 00);
              });
            },
            icon: const Icon(Icons.refresh),
            text: 'Redefinir',
            textStyle: TextFontStyle.headline2RegularStyle
                .copyWith(color: Colors.white),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          Text(
            'Wednesday',
            style: TextFontStyle.subtitle1RegularStyle.copyWith(
              letterSpacing: 1,
            ),
          ),
        ),
        DataCell(
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              value: isWedChecked,
              onChanged: (bool? value) {
                setState(() {
                  isWedChecked = value!;
                });
              },
            ),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectWedOpeningTime();
              //   _selectTime(context, wedOpeningTime);
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: wedOpeningTimeSt == null
                ? "--:-- --"
                : wedOpeningTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectWedBreakStartTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: wedBreakStartTimeSt == null
                ? "--:-- --"
                : wedBreakStartTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectWedBreakEndTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: wedBreakEndTimeSt == null
                ? "--:-- --"
                : wedBreakEndTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectWedClosingTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: wedClosingTimeSt == null
                ? "--:-- --"
                : wedClosingTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.primaryColor,
            elevation: 5.0,
            onPressed: () {
              setState(() {
                isWedChecked = false;
                wedOpeningTime = const TimeOfDay(hour: 00, minute: 00);
                wedBreakStartTime = const TimeOfDay(hour: 00, minute: 00);
                wedBreakEndTime = const TimeOfDay(hour: 00, minute: 00);
                wedClosingTime = const TimeOfDay(hour: 00, minute: 00);
              });
            },
            icon: const Icon(Icons.refresh),
            text: 'Redefinir',
            textStyle: TextFontStyle.headline2RegularStyle
                .copyWith(color: Colors.white),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          Text(
            'Thursday',
            style: TextFontStyle.subtitle1RegularStyle.copyWith(
              letterSpacing: 1,
            ),
          ),
        ),
        DataCell(
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              value: isThuChecked,
              onChanged: (bool? value) {
                setState(() {
                  isThuChecked = value!;
                });
              },
            ),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectThuOpeningTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: thuOpeningTimeSt == null
                ? "--:-- --"
                : thuOpeningTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectThuBreakStartTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: thuBreakStartTimeSt == null
                ? "--:-- --"
                : thuBreakStartTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectThuBreakEndTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: thuBreakEndTimeSt == null
                ? "--:-- --"
                : thuBreakEndTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectThuClosingTime();
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: thuClosingTimeSt == null
                ? "--:-- --"
                : thuClosingTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.primaryColor,
            elevation: 5.0,
            onPressed: () {
              setState(() {
                isThuChecked = false;
                thuOpeningTime = const TimeOfDay(hour: 00, minute: 00);
                thuBreakStartTime = const TimeOfDay(hour: 00, minute: 00);
                thuBreakEndTime = const TimeOfDay(hour: 00, minute: 00);
                thuClosingTime = const TimeOfDay(hour: 00, minute: 00);
              });
            },
            icon: const Icon(Icons.refresh),
            text: 'Redefinir',
            textStyle: TextFontStyle.headline2RegularStyle
                .copyWith(color: Colors.white),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          Text(
            'Friday',
            style: TextFontStyle.subtitle1RegularStyle.copyWith(
              letterSpacing: 1,
            ),
          ),
        ),
        DataCell(
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              value: isFriChecked,
              onChanged: (bool? value) {
                setState(() {
                  isFriChecked = value!;
                });
              },
            ),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectFriOpeningTime();
              //_selectTime(context, friOpeningTime);
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: friOpeningTimeSt == null
                ? "--:-- --"
                : friOpeningTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectFriBreakStartTime();
              // _selectTime(context, friBreakStartTime);
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: friBreakStartTimeSt == null
                ? "--:-- --"
                : friBreakStartTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectFriBreakEndTime();
              // _selectTime(context, friBreakEndTime);
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: friBreakEndTimeSt == null
                ? "--:-- --"
                : friBreakEndTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectFriClosingTime();
              //_selectTime(context, friClosingTime);
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: friClosingTimeSt == null
                ? "--:-- --"
                : friClosingTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.primaryColor,
            elevation: 5.0,
            onPressed: () {
              setState(() {
                isFriChecked = false;
                friOpeningTime = const TimeOfDay(hour: 00, minute: 00);
                friBreakStartTime = const TimeOfDay(hour: 00, minute: 00);
                friBreakEndTime = const TimeOfDay(hour: 00, minute: 00);
                friClosingTime = const TimeOfDay(hour: 00, minute: 00);
              });
            },
            icon: const Icon(Icons.refresh),
            text: 'Redefinir',
            textStyle: TextFontStyle.headline2RegularStyle
                .copyWith(color: Colors.white),
          ),
        ),
      ]),
      DataRow(cells: [
        DataCell(
          Text(
            'Saturday',
            style: TextFontStyle.subtitle1RegularStyle.copyWith(
              letterSpacing: 1,
            ),
          ),
        ),
        DataCell(
          Transform.scale(
            scale: 1.2,
            child: Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
              value: isSatChecked,
              onChanged: (bool? value) {
                setState(() {
                  isSatChecked = value!;
                });
              },
            ),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectSatOpeningTime();
              //_selectTime(context, satOpeningTime);
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: satOpeningTimeSt == null
                ? "--:-- --"
                : satOpeningTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectSatBreakStartTime();
              //_selectTime(context, satBreakStartTime);
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: satBreakStartTimeSt == null
                ? "--:-- --"
                : satBreakStartTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectSatBreakEndTime();
              // _selectTime(context, satBreakEndTime);
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: satBreakEndTimeSt == null
                ? "--:-- --"
                : satBreakEndTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.white,
            elevation: 5.0,
            onPressed: () {
              _selectSatClosingTime();
              //_selectTime(context, satClosingTime);
            },
            icon: const Icon(Icons.watch_later_outlined),
            text: satClosingTimeSt == null
                ? "--:-- --"
                : satClosingTime.format(context),
            textStyle:
                TextFontStyle.buttonBoldStyle.copyWith(color: Colors.black),
          ),
        ),
        DataCell(
          GFButton(
            position: GFPosition.end,
            shape: GFButtonShape.standard,
            color: AppColors.primaryColor,
            elevation: 5.0,
            onPressed: () {
              setState(() {
                isSatChecked = false;
                satOpeningTime = const TimeOfDay(hour: 00, minute: 00);
                satBreakStartTime = const TimeOfDay(hour: 00, minute: 00);
                satBreakEndTime = const TimeOfDay(hour: 00, minute: 00);
                satClosingTime = const TimeOfDay(hour: 00, minute: 00);
              });
            },
            icon: const Icon(Icons.refresh),
            text: 'Redefinir',
            textStyle: TextFontStyle.headline2RegularStyle
                .copyWith(color: Colors.white),
          ),
        ),
      ]),
    ];
  }
}
