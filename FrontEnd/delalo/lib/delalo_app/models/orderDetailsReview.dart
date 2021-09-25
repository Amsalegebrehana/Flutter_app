import 'package:delalo/delalo_app/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'order_jobs.dart';
import 'user.dart';

@immutable
class OrderDetailsReview extends Equatable {
  const OrderDetailsReview({this.order, this.provider, this.user, this.review});

  final Order? order;
  final User? provider;
  final User? user;
  final Review? review;

  @override
  List<Object?> get props => [order, provider, user];

  factory OrderDetailsReview.fromJson(Map<String, dynamic> json) {
    print("factory...main");
    return OrderDetailsReview(
        review: Review.fromJson(json['Review']),
        provider: User.fromJson(json['Provider']),
        user: User.fromJson(json['User']),
        order: Order.fromJson(json['Order']));
  }
}
