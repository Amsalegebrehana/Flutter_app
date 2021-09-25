//review model
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Review extends Equatable {
  Review(
      {required this.rating,
      this.comment,
      required this.order_id,
      required this.id});
  final String id;
  final int rating;
  final String? comment;
  final String order_id;

  @override
  List<Object?> get props => [id, rating, order_id, comment];

  factory Review.fromJson(Map<String, dynamic> json) {
    print('factory....review');

    return Review(
        id: json['_id'],
        rating: json['rating'],
        comment: json['comment'],
        order_id: json['order_id']);
  }
  @override
  String toString() => 'Review {rating: $rating, order_id: $order_id}';
}
