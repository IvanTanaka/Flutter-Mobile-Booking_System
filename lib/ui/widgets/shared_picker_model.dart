import 'dart:math';

import 'package:flutter/material.dart';
import 'package:member_apps/core/services/helper.dart';
import 'package:member_apps/ui/widgets/library/date_picker/date_model.dart';

class SharedPickerModel extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  SharedPickerModel(
      {DateTime currentTime, TimeOfDay storeMin, TimeOfDay storeMax})
      : super() {
    this.currentTime = currentTime ?? DateTime.now();
    this.storeMinTime = storeMin;
    this.storeMaxTime = storeMax;
    this.setLeftIndex(0);
    this.setMiddleIndex(this.currentTime.hour);
    this.setRightIndex(this.currentTime.minute);
  }

  bool isAtSameDay(DateTime day1, DateTime day2) {
    return day1 != null &&
        day2 != null &&
        day1.difference(day2).inDays == 0 &&
        day1.day == day2.day;
  }

  @override
  String leftStringAtIndex(int index) {
    DateTime time = DateTime.now().add(Duration(days: index));
    if (DateTime.now() != null &&
        time.isBefore(DateTime.now()) &&
        !isAtSameDay(DateTime.now(), time)) {
      return null;
    }
    return Helper.formatDate(time, format: "EE, dd MMM yyyy");
  }

  @override
  String middleStringAtIndex(int index) {
    if (currentLeftIndex() == 0) {
      if (index >= DateTime.now().hour) {
        if (index >= storeMinTime.hour && index < storeMaxTime.hour) {
          return this.digits(index, 2);
        }
      }
    } else {
      if (index >= storeMinTime.hour && index < storeMaxTime.hour) {
        return this.digits(index, 2);
      }
    }
    return null;
  }

  @override
  String rightStringAtIndex(int index) {
    if (currentLeftIndex() == 0) {
      if (this.currentMiddleIndex() == storeMinTime.hour) {
        if (index >= storeMinTime.minute && index < 60) {
          return this.digits(index, 2);
        } else if (index <= storeMinTime.minute) {
          return null;
        }
      } else if (this.currentMiddleIndex() == storeMaxTime.hour) {
        if (index >= 0 && index < storeMaxTime.minute) {
          return this.digits(index, 2);
        } else if (index >= storeMaxTime.minute) {
          return null;
        }
      } else if (this.currentMiddleIndex() == DateTime.now().hour) {
        if (index >= DateTime.now().minute && index < 60) {
          return this.digits(index, 2);
        }
      } else if (index >= 0 && index < 60) {
        return this.digits(index, 2);
      }
    } else if (index >= 0 && index < 60) {
      if (this.currentMiddleIndex() == storeMinTime.hour) {
        if (index >= storeMinTime.minute && index < 60) {
          return this.digits(index, 2);
        } else if (index <= storeMinTime.minute) {
          return null;
        }
      } else if (this.currentMiddleIndex() == storeMaxTime.hour) {
        if (index >= 0 && index < storeMaxTime.minute) {
          return this.digits(index, 2);
        } else if (index >= storeMaxTime.minute) {
          return null;
        }
      } else if (index >= 0 && index < 60) {
        return this.digits(index, 2);
      }
    }

    return null;
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [2, 1, 1];
  }

  @override
  DateTime finalTime() {
    DateTime day = DateTime.now().add(Duration(days: this.currentLeftIndex()));
    return currentTime.isUtc
        ? DateTime.utc(day.year, day.month, day.day, this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(day.year, day.month, day.day, this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}
