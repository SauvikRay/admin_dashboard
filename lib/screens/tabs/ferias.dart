import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';

import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' show DateFormat;
import '/constants/app_color.dart';
import '/networks/api_acess.dart';
import '/networks/rx_get_shop_schedule/rx.dart';
import '/widgets/custom_button.dart';

import '../../constants/app_constants.dart';
import '../../constants/text_font_style.dart';
import '../../constants/ui_helpers.dart';
import '../../helpers/helper.dart';
import '../../widgets/custome_textfield.dart';
import '../../widgets/lebel_text_button.dart';
import '../../widgets/popup_number_widget.dart';

class Ferias extends StatefulWidget {
  const Ferias({Key? key}) : super(key: key);

  @override
  State<Ferias> createState() => _FeriasState();
}

class _FeriasState extends State<Ferias> {
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _numberTextController = TextEditingController();

  List<dynamic> items = [];
  int totalRec = 0;
  int startRec = 0;
  int endRec = 0;
  List<dynamic> serachList = [];
  int _page = 1;

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );
  late String dropdownValue = 'a';
  String? imagePath;
  bool status = true;
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    _numberTextController.text = '10';

    getAllShopHolidaysRXobj.getAllShopHolidaysData.listen((value) {
      if (value['data'] != null) {
        items = value['data']!['holidayList'];
        for (var element in items) {
          _markedDateMap.add(
              formatDateTime(element),
              Event(
                id: 1,
                date: formatDateTime(element),
                title: 'Event',
                dot: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1.0),
                  color: Colors.red,
                  height: 5.0,
                  width: 5.0,
                ),
              ));
        }
      }
    });
    getShopHolidaysRXobj.getShopHolidaysData.listen((value) {
      if (value['data'] != null) {
        items = value['data']!['holidayList'];
        for (var element in items) {
          _markedDateMap.add(
              formatDateTime(element),
              Event(
                id: 1,
                date: formatDateTime(element),
                title: 'Event',
                dot: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 1.0),
                  color: Colors.red,
                  height: 5.0,
                  width: 5.0,
                ),
              ));
        }
        totalRec = value['data']['total'];
        startRec = value['data']['start'];
        endRec = value['data']['end'];
      } else {
        items = [];
        totalRec = 0;
        startRec = 0;
        endRec = 0;
      }
      setState(() {
        _markedDateMap.events.forEach((e, v) {
          String convertedDateTime =
              "${e.day.toString().padLeft(2, '0')}-${e.month.toString().padLeft(2, '0')}-${'${e.year},'}";
          // _nameTextController.text += convertedDateTime;
          print(convertedDateTime);
        });
      });
    });

    _numberTextController.addListener(
      () {
        int record = int.parse(_numberTextController.value.text);
        getShopHolidaysRXobj.fetchShopHolidaysData(record: record, page: _page);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: (ScreenUtil().screenWidth < 600)
          ? Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Adicionar férias',
                  style: TextFontStyle.headline1BoldStyle,
                ),
                UIHelper.verticalSpaceMedium,
                Text(
                  "Selecionar férias",
                  style: TextFontStyle.headline1BoldStyle,
                ),
                UIHelper.verticalSpaceMedium,
                CustomNumberFormField(
                  hintText: 'Sede Santiago Do Cacém',
                  labelText: 'a',
                  inputType: TextInputType.name,
                  textEditingController: _nameTextController,
                ),
                UIHelper.verticalSpaceMedium,
                CalendarCarousel<Event>(
                  weekFormat: false,
                  markedDatesMap: _markedDateMap,
                  selectedDayButtonColor: Colors.transparent,
                  markedDateShowIcon: true,
                  markedDateCustomShapeBorder: const CircleBorder(
                      side: BorderSide(color: AppColors.penIconColor)),
                  height: 420.0,
                  selectedDateTime: _currentDate,
                  daysHaveCircularBorder: false,
                  rightButtonIcon: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: AppColors.disabledColor,
                  ),
                  minSelectedDate: _currentDate,
                  leftButtonIcon: const Icon(
                    Icons.arrow_back_ios_sharp,
                    color: AppColors.disabledColor,
                  ),
                  selectedDayBorderColor: AppColors.headLine1Color,
                  todayTextStyle:
                      const TextStyle(color: AppColors.headLine2Color),
                  weekendTextStyle: const TextStyle(color: Colors.black),
                  headerTextStyle: TextFontStyle.headline1RegularStyle
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  onDayPressed: (DateTime date, List<Event> events) {
                    List<Event> events = _markedDateMap.getEvents(date);
                    setState(() {
                      if (events.isNotEmpty) {
                        _markedDateMap.removeAll(date);
                      } else {
                        _markedDateMap.add(
                            date,
                            Event(
                              id: 1,
                              date: date,
                              title: 'Event',
                              dot: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                color: Colors.red,
                                height: 5.0,
                                width: 5.0,
                              ),
                            ));
                      }
                      _nameTextController.text +=
                          "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${'${date.year},'}";
                    });
                  },
                ),
                UIHelper.verticalSpaceMedium,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    LabelTextButton(
                      width: .35.sw,
                      icon: SvgPicture.asset(
                        AssetIcons.buttonPlusIcon,
                      ),
                      onCallBack: () async {
                        int commaData =
                            _nameTextController.text.lastIndexOf(',');
                        String holidays = _nameTextController.text
                            .replaceRange(commaData, null, '');
                        await postShopHolidaysRXobj.postShopHolidays(
                            holidays: holidays);
                        await getShopHolidaysRXobj.fetchShopHolidaysData();
                      },
                      text: 'Gravar',
                    ),
                    LabelTextButton(
                      width: .35.sw,
                      borderSide: const BorderSide(
                        color: AppColors.disabledColor,
                      ),
                      color: AppColors.scaffoldColor,
                      icon: SvgPicture.asset(
                        AssetIcons.reload,
                        color: AppColors.disabledColor,
                      ),
                      onCallBack: () {
                        _nameTextController.text = "";
                      },
                      text: 'Reinicia',
                      textFontStyle: TextFontStyle.headline2BoldStyle,
                    ),
                  ],
                ),
                UIHelper.horizontalSpaceMedium,
                UIHelper.verticalSpace(20),
                Text(
                  'Lista de lojas',
                  style: TextFontStyle.headline1BoldStyle,
                ),
                UIHelper.verticalSpaceMedium,
                Text(
                  "Aqui pode ver a lista de lojas",
                  style: TextFontStyle.headlineRegulardStyle,
                ),
                UIHelper.verticalSpace(30),
                Row(
                  children: [
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
                        number: _numberTextController,
                      ),
                    ),
                    UIHelper.horizontalSpaceMedium,
                    Text(
                      'Entries',
                      style: TextFontStyle.headline2RegularStyle,
                    ),
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
                          ? .45.sw
                          : .24.sw,
                      headingTextStyle: TextFontStyle.tableHeader.copyWith(
                        color: const Color(0xFF8D949B),
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                      headingRowColor:
                          MaterialStateProperty.all(const Color(0xFFDEE2E6)),
                      dataRowHeight: 50,
                      horizontalMargin: 10,
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
                          label: Text('Date',
                              style: TextFontStyle.tableHeader,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left),
                        ),
                        DataColumn(
                          label: Text('Action',
                              style: TextFontStyle.tableHeader,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left),
                        ),
                      ],
                      rows: items
                          .map((items) => DataRow(cells: [
                                DataCell(Text(items)),
                                DataCell(InkWell(
                                  onTap: () async {
                                    await postShopHolidaysRemoveRXobj
                                        .postShopHolidaysRemove(holiday: items);
                                    int record = int.parse(
                                        _numberTextController.value.text);
                                    await getShopHolidaysRXobj
                                        .fetchShopHolidaysData(
                                            page: _page, record: record);
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: AppColors.primaryColor,
                                  ),
                                )),
                              ]))
                          .toList(),
                    ),
                  ),
                ),
                UIHelper.verticalSpaceSemiLarge,
                if (items.isEmpty)
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
                Row(
                  children: [
                    Text(
                      'Showing $startRec to $endRec of $totalRec entries',
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
                            onTap: () {
                              if (_page >= 2) {
                                setState(() {
                                  _page -= 1;
                                  int record = int.parse(
                                      _numberTextController.value.text);
                                  getShopHolidaysRXobj.fetchShopHolidaysData(
                                      page: _page, record: record);
                                });
                              }
                            },
                          ),
                          const VerticalDivider(
                            color: AppColors.disabledColor,
                            thickness: 1,
                          ),
                          Text(
                            _page.toString(),
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
                            onTap: () {
                              int record =
                                  int.parse(_numberTextController.value.text);
                              if (items.length == record) {
                                setState(() {
                                  _page += 1;
                                  getShopHolidaysRXobj.fetchShopHolidaysData(
                                      page: _page, record: record);
                                });
                              } else {
                                const snackBar = SnackBar(
                                  content: Text('No more records to show'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // width: MediaQuery.of(context).size.width / 2 - 62,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIHelper.verticalSpace(20),
                        Text(
                          'Adicionar férias',
                          style: TextFontStyle.headline1BoldStyle,
                        ),
                        UIHelper.verticalSpaceMedium,
                        Text(
                          "Selecionar férias",
                          style: TextFontStyle.headline1BoldStyle,
                        ),
                        UIHelper.verticalSpaceMedium,
                        CustomNumberFormField(
                          hintText: 'Sede Santiago Do Cacém',
                          labelText: 'a',
                          inputType: TextInputType.name,
                          textEditingController: _nameTextController,
                        ),
                        CalendarCarousel<Event>(
                          weekFormat: false,
                          markedDatesMap: _markedDateMap,
                          selectedDayButtonColor: Colors.transparent,
                          markedDateShowIcon: true,
                          markedDateCustomShapeBorder: const CircleBorder(
                              side: BorderSide(color: AppColors.penIconColor)),
                          height: 420.0,
                          selectedDateTime: _currentDate,
                          daysHaveCircularBorder: false,
                          rightButtonIcon: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            color: AppColors.disabledColor,
                          ),
                          minSelectedDate: _currentDate,
                          leftButtonIcon: const Icon(
                            Icons.arrow_back_ios_sharp,
                            color: AppColors.disabledColor,
                          ),
                          selectedDayBorderColor: AppColors.headLine1Color,
                          todayTextStyle:
                              const TextStyle(color: AppColors.headLine2Color),
                          weekendTextStyle:
                              const TextStyle(color: Colors.black),
                          headerTextStyle: TextFontStyle.headline1RegularStyle
                              .copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 18.sp),
                          onDayPressed: (DateTime date, List<Event> events) {
                            List<Event> events = _markedDateMap.getEvents(date);
                            setState(() {
                              if (events.isNotEmpty) {
                                _markedDateMap.removeAll(date);
                              } else {
                                _markedDateMap.add(
                                    date,
                                    Event(
                                      id: 1,
                                      date: date,
                                      title: 'Event',
                                      dot: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        color: Colors.red,
                                        height: 5.0,
                                        width: 5.0,
                                      ),
                                    ));
                              }
                              _nameTextController.text +=
                                  "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${'${date.year},'}";
                            });
                          },
                        ),
                        UIHelper.verticalSpaceSemiLarge,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LabelTextButton(
                              width: .18.sw,
                              icon: SvgPicture.asset(
                                AssetIcons.buttonPlusIcon,
                              ),
                              onCallBack: () async {
                                int commaData =
                                    _nameTextController.text.lastIndexOf(',');
                                String holidays = _nameTextController.text
                                    .replaceRange(commaData, null, '');
                                await postShopHolidaysRXobj.postShopHolidays(
                                    holidays: holidays);
                                await getShopHolidaysRXobj
                                    .fetchShopHolidaysData();
                              },
                              text: 'Gravar',
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
                                _nameTextController.text = "";
                              },
                              text: 'Reinicia',
                              textFontStyle: TextFontStyle.headline2BoldStyle,
                            ),
                          ],
                        ),
                      ]),
                ),
                UIHelper.horizontalSpaceMedium,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      UIHelper.verticalSpace(20),
                      Text(
                        'Lista de lojas',
                        style: TextFontStyle.headline1BoldStyle,
                      ),
                      UIHelper.verticalSpaceMedium,
                      Text(
                        "Aqui pode ver a lista de lojas",
                        style: TextFontStyle.headlineRegulardStyle,
                      ),
                      UIHelper.verticalSpace(30),
                      Row(
                        children: [
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
                              number: _numberTextController,
                            ),
                          ),
                          UIHelper.horizontalSpaceMedium,
                          Text(
                            'Entries',
                            style: TextFontStyle.headline2RegularStyle,
                          ),
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
                                ? .22.sw
                                : .24.sw,
                            headingTextStyle:
                                TextFontStyle.tableHeader.copyWith(
                              color: const Color(0xFF8D949B),
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                            headingRowColor: MaterialStateProperty.all(
                                const Color(0xFFDEE2E6)),
                            dataRowHeight: 50,
                            horizontalMargin: 10,
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
                                label: Text('Date',
                                    style: TextFontStyle.tableHeader,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left),
                              ),
                              DataColumn(
                                label: Text('Action',
                                    style: TextFontStyle.tableHeader,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left),
                              ),
                            ],
                            rows: items
                                .map((items) => DataRow(cells: [
                                      DataCell(Text(items)),
                                      DataCell(InkWell(
                                        onTap: () async {
                                          await postShopHolidaysRemoveRXobj
                                              .postShopHolidaysRemove(
                                                  holiday: items);
                                          int record = int.parse(
                                              _numberTextController.value.text);
                                          await getShopHolidaysRXobj
                                              .fetchShopHolidaysData(
                                                  page: _page, record: record);
                                        },
                                        child: const Icon(
                                          Icons.delete,
                                          color: AppColors.primaryColor,
                                        ),
                                      )),
                                    ]))
                                .toList(),
                          ),
                        ),
                      ),
                      UIHelper.verticalSpaceSemiLarge,
                      if (items.isEmpty)
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
                      Row(
                        children: [
                          Text(
                            'Showing $startRec to $endRec of $totalRec entries',
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
                                  onTap: () {
                                    if (_page >= 2) {
                                      setState(() {
                                        _page -= 1;
                                        int record = int.parse(
                                            _numberTextController.value.text);
                                        getShopHolidaysRXobj
                                            .fetchShopHolidaysData(
                                                page: _page, record: record);
                                      });
                                    }
                                  },
                                ),
                                const VerticalDivider(
                                  color: AppColors.disabledColor,
                                  thickness: 1,
                                ),
                                Text(
                                  _page.toString(),
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
                                  onTap: () {
                                    int record = int.parse(
                                        _numberTextController.value.text);
                                    if (items.length == record) {
                                      setState(() {
                                        _page += 1;
                                        getShopHolidaysRXobj
                                            .fetchShopHolidaysData(
                                                page: _page, record: record);
                                      });
                                    } else {
                                      const snackBar = SnackBar(
                                        content:
                                            Text('No more records to show'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    }
                                  },
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
