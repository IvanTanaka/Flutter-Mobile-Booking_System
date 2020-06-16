import 'package:flutter/material.dart';
import 'package:member_apps/core/constants/order_status.dart';
import 'package:member_apps/core/enumerations/order_food_type.dart';
import 'package:member_apps/core/models/branch_model.dart';
import 'package:member_apps/core/models/cashier_model.dart';
import 'package:member_apps/core/models/order_detail_model.dart';
import 'package:member_apps/core/models/rate_model.dart';
import 'package:member_apps/core/services/helper.dart';
import 'package:member_apps/ui/shared_colors.dart';

class OrderModel {
  OrderModel(
      {this.id,
      this.customerId,
      this.branchId,
      this.cashierId,
      this.franchiseId,
      this.status,
      this.total,
      this.peopleCount,
      this.reserveTime,
      this.createdAt,
      this.updatedAt,
      this.orderDetails,
      this.branch,
      this.cashier,
      this.rate});

  String id;
  String customerId;
  String branchId;
  String cashierId;
  String franchiseId;
  String status;

  String get statusStr{
    switch (status){
      case OrderStatus.ACCEPTED:
        return "Accepted";
      case OrderStatus.CANCELED:
        return "Canceled";
      case OrderStatus.DENIED:
        return "Canceled";
      case OrderStatus.NO_RESPONSE:
        return "Canceled";
      case OrderStatus.FINISHED:
        return "Finished";
      case OrderStatus.WAITING:
        return "Waiting";
      default:
        return "";
    }
  }

  Color get statusColor{
    switch (status) {
      case OrderStatus.CANCELED:
      case OrderStatus.DENIED:
      case OrderStatus.NO_RESPONSE:
        return SharedColors.statusFailed;
      case OrderStatus.FINISHED:
        return SharedColors.statusSuccess;
      case OrderStatus.ACCEPTED:
      case OrderStatus.WAITING:
        return SharedColors.statusWaiting;
      default:
        return SharedColors.txtColor;
    }
  }
  int total;
  String get formattedTotal{
    return Helper.doubleToMoneyFormat(total.toDouble());
  }
  int peopleCount;
  OrderFoodType get orderType{
    if(peopleCount>0){
      return OrderFoodType.dineIn;
    }
    return OrderFoodType.takeAway;
  }
  String get orderTypeStr{
    switch(orderType){
      case OrderFoodType.dineIn:
        return "Dine In";
        break;
      case OrderFoodType.takeAway:
        return "Take Away";
        break;
      default:
//        TODO Handle data error
        return "Take Away";
    }
  }
  DateTime reserveTime;
  DateTime createdAt;
  DateTime updatedAt;
  List<OrderDetailModel> orderDetails;
  BranchModel branch;
  CashierModel cashier;
  RateModel rate;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
      id: json["id"] == null ? null : json["id"],
      customerId: json["customer_id"] == null ? null : json["customer_id"],
      branchId: json["branch_id"] == null ? null : json["branch_id"],
      cashierId: json["cashier_id"],
      franchiseId: json["franchise_id"] == null ? null : json["franchise_id"],
      status: json["status"] == null ? null : json["status"],
      total: json["total"] == null ? null : json["total"],
      peopleCount: json["people_count"] == null ? null : json["people_count"],
      reserveTime: json["reserve_time"] == null
          ? null
          : DateTime.parse(json["reserve_time"]),
      createdAt: json["created_at"] == null
          ? null
          : DateTime.parse(json["created_at"]),
      updatedAt: json["updated_at"] == null
          ? null
          : DateTime.parse(json["updated_at"]),
      orderDetails: json["order_details"] == null
          ? null
          : List<OrderDetailModel>.from(
              json["order_details"].map((x) => OrderDetailModel.fromJson(x))),
      branch:
          json["branch"] == null ? null : BranchModel.fromJson(json["branch"]),
      cashier: json["cashier"] == null ? null : CashierModel.fromJson(json["cashier"]),
      rate: json["rate"] == null ? null : RateModel.fromJson(json["rate"])
  );
}
