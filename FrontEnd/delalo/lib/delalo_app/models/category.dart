//category model
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Category extends Equatable {
  const Category(
      {this.id,
      required this.name,
      this.image,
      required this.numOfProviders,
      required this.description});
  final String name;
  final String? id;
  final String? image;
  final int numOfProviders;
  final String description;


  List<Object?> get props => [name,id, image, numOfProviders, description];
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        name:json['name'],
        id: json['_id'],
        image: json['image'],
        numOfProviders: json['numOfProviders'],
        description: json['description']);
  }
  @override
  String toString() =>
      'Category {id: $id , image: $image, numOfProviders: $numOfProviders, description: $description}';
}
