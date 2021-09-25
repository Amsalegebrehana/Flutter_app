import 'package:delalo/delalo_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'order_jobs.dart';
import 'user.dart';

@immutable
class OrderDetails extends Equatable {
  const OrderDetails({this.order, this.provider, this.user});

  final Order? order;
  final User? provider;
  final User? user;
  // final Review? review;

  @override
  List<Object?> get props => [order, provider, user];

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    print("factory...main");
    return OrderDetails(
        // review: Review.fromJson(json['Review']),
        provider: User.fromJson(json['Provider']),
        user: User.fromJson(json['User']),
        order: Order.fromJson(json['Order']));
  }
}