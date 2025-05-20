import 'package:flutter/material.dart';
import 'package:kaliro_cometchat_uikit_shared/kaliro_cometchat_uikit_shared.dart';
import 'package:intl/intl.dart';

enum DateTimePattern { timeFormat, dayDateFormat, dayDateTimeFormat }

///[CometChatDate] is a widget that provides a customizable container to display date and time
/// ```dart
///   CometChatDate(
///    date: DateTime.now(),
///    customDateString: "some custome text to show in place of date",
///    pattern: DateTimePattern.dayDateTimeFormat,
///  );
/// ```
class CometChatDate extends StatelessWidget {
  const CometChatDate(
      {super.key,
      this.date,
      this.pattern,
      this.style = const DateStyle(),
      this.customDateString});

  ///[date] is the date to be shown
  final DateTime? date;

  ///[pattern] formats the DateTime object
  final DateTimePattern? pattern;

  ///[style] contains properties that affects the appearance of this widget
  final DateStyle style;

  ///[customDateString] if not null is shown instead of date from DateTime object
  final String? customDateString;

  bool _isSameDate(DateTime dt1, DateTime dt2) {
    return dt1.year == dt2.year && dt1.month == dt2.month && dt1.day == dt2.day;
  }

  bool _isSameWeek(DateTime dt1, DateTime dt2) {
    return dt1.difference(dt2) <= const Duration(days: 7) &&
        (dt1.add(Duration(days: -dt1.weekday)).day ==
            dt2.add(Duration(days: -dt2.weekday)).day);
  }

  String _getDateLogic1(DateTime date, {required String timeFormatter}) {
    return DateFormat(timeFormatter).format(date);
  }

  String _getDateLogic2(DateTime date, BuildContext context,
      {required String dateFormatter, required String weekFormatter}) {
    DateTime todayDate = DateTime.now();
    if (_isSameDate(todayDate, date)) {
      return Translations.of(context).today;
    } else if (_isSameDate(todayDate, date.add(const Duration(days: 1)))) {
      return Translations.of(context).yesterday;
    } else if (_isSameWeek(todayDate, date)) {
      return DateFormat(weekFormatter).format(date);
    } else {
      return DateFormat(dateFormatter).format(date);
    }
  }

  String _getDateLogic3(DateTime date, BuildContext context,
      {required String timeFormatter,
      required String dateFormatter2,
      required String weekFormatter}) {
    DateTime todayDate = DateTime.now();
    if (_isSameDate(todayDate, date)) {
      return DateFormat(timeFormatter).format(date);
    } else if (_isSameDate(todayDate, date.add(const Duration(days: 1)))) {
      return Translations.of(context).yesterday;
    } else if (_isSameWeek(todayDate, date)) {
      return DateFormat(weekFormatter).format(date);
    } else {
      return DateFormat(dateFormatter2).format(date);
    }
  }

  String _getDate(
    DateTimePattern? datePattern,
    DateTime date,
    BuildContext context, {
    String timeFormatter = "hh:mm a",
    String weekFormatter = "EEE",
    String dateFormatter = "d MMM, yyyy",
    String dateFormatter2 = "dd MM yyyy",
  }) {
    switch (datePattern) {
      case DateTimePattern.timeFormat:
        return _getDateLogic1(date, timeFormatter: timeFormatter);
      case DateTimePattern.dayDateFormat:
        return _getDateLogic2(date, context,
            dateFormatter: dateFormatter, weekFormatter: weekFormatter);
      case DateTimePattern.dayDateTimeFormat:
        return _getDateLogic3(date, context,
            weekFormatter: weekFormatter,
            timeFormatter: timeFormatter,
            dateFormatter2: dateFormatter2);
      default:
        return _getDateLogic1(date, timeFormatter: timeFormatter);
    }
  }

  @override
  Widget build(BuildContext context) {
    String timeFormatter = "hh:mm a";
    String weekFormatter = "EEE";
    String dateFormatter = "d MMM, yyyy";
    String dateFormatter2 = "dd-MM-yyyy";

    String date;

    if (customDateString != null) {
      date = customDateString!;
    } else {
      date = _getDate(pattern, this.date ?? DateTime.now(), context,
          timeFormatter: timeFormatter,
          weekFormatter: weekFormatter,
          dateFormatter: dateFormatter,
          dateFormatter2: dateFormatter2);
    }

    return Container(
      padding: style.contentPadding ?? const EdgeInsets.all(2.0),
      height: style.height,
      width: style.width,
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius:
              BorderRadius.all(Radius.circular(style.borderRadius ?? 4.0)),
          border: style.border ??
              Border.all(
                  width: 1.0, color: const Color(0xff141414).withOpacity(0.14)),
          color: style.gradient == null
              ? style.isTransparentBackground == true
                  ? style.background?.withOpacity(0)
                  : style.background
              : (style.isTransparentBackground == true
                  ? const Color(0xff141414).withOpacity(0.84)
                  : const Color(0xff141414).withOpacity(0.04)),
          gradient:
              style.isTransparentBackground == true ? null : style.gradient),
      child: Text(
        date,
        style: style.textStyle ??
            TextStyle(
                fontSize: 12.0,
                color: const Color(0xff141414).withOpacity(0.84)),
      ),
    );
  }
}
