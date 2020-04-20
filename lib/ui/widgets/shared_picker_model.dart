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
    this.currentTime = currentTime ?? DateTime.now().add(Duration(minutes: 30));
    this.storeMinTime = storeMin;
    this.storeMaxTime = storeMax;
    this.setLeftIndex(this.currentTime
        .add(Duration(minutes: 30))
        .hour >= storeMax.hour && this.currentTime
        .add(Duration(minutes: 30))
        .minute >= storeMax.minute ? this
        .currentTime
        .difference(DateTime.now().add(Duration(days: 1)))
        .inDays : this
        .currentTime
        .difference(DateTime.now().add(Duration(minutes: 30)))
        .inDays);
    this.setMiddleIndex(this.currentTime.hour <= this.storeMinTime.hour
        ? this.storeMinTime.hour
        : isAtSameDay(
        this.currentTime.add(Duration(minutes: 30)), DateTime.now()) &&
        this.currentTime
            .add(Duration(minutes: 30))
            .hour > this.storeMaxTime.hour ? this.storeMinTime : this
        .currentTime.hour);
    this.setRightIndex(this.currentTime.minute);
  }

  bool isAtSameDay(DateTime day1, DateTime day2) {
    return day1 != null &&
        day2 != null &&
        day1
            .difference(day2)
            .inDays == 0 &&
        day1.day == day2.day;
  }

  @override
  void setLeftIndex(int index) {
    // TODO: implement setLeftIndex
    super.setLeftIndex(index);
  }

  @override
  void setMiddleIndex(int index) {
    // TODO: implement setMiddleIndex
    super.setMiddleIndex(index);
    if (index == storeMax().hour) {
      if (this.currentRightIndex() != null) {
        if ((this.currentRightIndex() > storeMax().minute)) {
          super.setRightIndex(storeMax().minute);
        }
      }
    } else if (super.currentMiddleIndex() == DateTime
        .now()
        .hour &&
        DateTime
            .now()
            .minute + 30 < 60) {
      super.setRightIndex(DateTime
          .now()
          .minute + 30);
//    } else if (super.currentMiddleIndex() == DateTime
//        .now()
//        .hour + 1 &&
//        DateTime
//            .now()
//            .minute + 30 >= 60) {
//      super.setRightIndex(DateTime
//          .now()
//          .minute - 30);
    } else {
      super.setRightIndex(currentRightIndex());
    }
  }

  @override
  void setRightIndex(int index) {
    // TODO: implement setMiddleIndex
    super.setRightIndex(index);
  }

  @override
  String leftStringAtIndex(int index) {
    DateTime time = DateTime.now().add(Duration(days: index));
    if (DateTime.now() != null &&
        time.isBefore(DateTime.now()) &&
        !isAtSameDay(DateTime.now(), time)) {
      return null;
    } else if (isAtSameDay(DateTime.now(), time) && (time
        .add(Duration(minutes: 30))
        .hour >
        storeMax().hour ||
        (time
            .add(Duration(minutes: 30))
            .hour == time.hour &&
            time
                .add(Duration(minutes: 30))
                .minute <
                storeMax().minute))) {
      return null;
    } else {
//      if(isAtSameDay(time.add(Duration(minutes: 30)),DateTime.now().add(Duration(days: 1)))){
//        return null;
//      }
      return Helper.formatDate(time, format: "EE, dd MMM yyyy");
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (currentLeftIndex() == 0) {
      if (index >= DateTime
          .now()
          .hour) {
        if (index >= storeMinTime.hour && index <= storeMaxTime.hour) {
          if (index == DateTime
              .now()
              .hour &&
              (DateTime
                  .now()
                  .minute + 30) >= 60) {
            return null;
          } else {
            return this.digits(index, 2);
          }
        }
      }
    } else {
      if (index >= storeMinTime.hour && index <= storeMaxTime.hour) {
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
          if(index>=0){
            return this.digits(index, 2);
          }
        } else if (index <= storeMinTime.minute) {
          return null;
        }
      } else if (this.currentMiddleIndex() == storeMaxTime.hour) {
        if (index >= 0 && index <= storeMaxTime.minute) {
          if(index>=0){
            return this.digits(index, 2);
          }
        } else if (index >= storeMaxTime.minute) {
          return null;
        }
      } else if (this.currentMiddleIndex() == DateTime
          .now()
          .hour) {
        if (index >= DateTime
            .now()
            .minute + 30 && index < 60) {
          if(index>=0){
            return this.digits(index, 2);
          }
        }
      } else if (this.currentMiddleIndex() == DateTime
          .now()
          .hour + 1) {
        if (index <= (DateTime
            .now()
            .minute + 30) - 60) {
          return null;
        } else {
          if(index>=0){
            return this.digits(index, 2);
          }
        }
      } else if (index >= 0 && index < 60) {
        if(index>=0){
          return this.digits(index, 2);
        }
      }
    } else if (index >= 0 && index < 60) {
      if (this.currentMiddleIndex() == storeMinTime.hour) {
        if (index >= storeMinTime.minute && index < 60) {
          if(index>=0){
            return this.digits(index, 2);
          }
        } else if (index <= storeMinTime.minute) {
          return null;
        }
      } else if (this.currentMiddleIndex() == storeMaxTime.hour) {
        if (index >= 0 && index <= storeMaxTime.minute) {
          if(index>=0){
            return this.digits(index, 2);
          }
        } else if (index >= storeMaxTime.minute) {
          return null;
        }
      } else if (index >= 0 && index < 60) {
        if(index>=0){
          return this.digits(index, 2);
        }
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
    print(this.currentRightIndex());
    DateTime day = DateTime.now().add(Duration(days: this.currentLeftIndex()));
    return currentTime.isUtc
        ? DateTime.utc(day.year, day.month, day.day, this.currentMiddleIndex(),
        this.currentRightIndex())
        : DateTime(day.year, day.month, day.day, this.currentMiddleIndex(),
        this.currentRightIndex());
  }
}
