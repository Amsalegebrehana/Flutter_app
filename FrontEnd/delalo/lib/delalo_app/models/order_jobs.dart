import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Order extends Equatable {
  final String id;
  final String? status;
  final String? progress;
  final String? order_created_date;
  final String? order_completed_date;
  final bool? is_completed;
  final double? start_time;
  final double? saved_time;
  final int? unique_code;
  final String seeker_id;
  final String provider_id;
  final double? final_payment;

  Order({
    required this.id,
    this.progress,
    this.final_payment,
    this.status,
    this.is_completed,
    this.order_created_date,
    this.order_completed_date,
    this.start_time,
    this.saved_time,
    this.unique_code,
    required this.seeker_id,
    required this.provider_id,
  });

  @override
  List<Object?> get props => [
        id,
        status,
        progress,
        order_created_date,
        order_completed_date,
        start_time,
        saved_time,
        unique_code,
        seeker_id,
        provider_id,
        final_payment
      ];

  factory Order.fromJson(Map<String, dynamic> json) {
    print("factory...order");

    return Order(
        id: json['_id'],
        status: json['status'],
        progress: json['progress'],
        order_created_date: json['order_created_date'],
        order_completed_date: json['order_completed_date'],
        is_completed: json['is_completed'],
        start_time: json['start_time']?.toDouble(),
        saved_time: json['saved_time']?.toDouble(),
        unique_code: json['unique_code'],
        seeker_id: json['seeker_id'],
        provider_id: json['provider_id'],
        final_payment: json['final_payment']?.toDouble());
  }
  @override
  String toString() =>
      'Order { id: $id, status: $status, seekerID: $seeker_id, providerID: $provider_id }';
}
