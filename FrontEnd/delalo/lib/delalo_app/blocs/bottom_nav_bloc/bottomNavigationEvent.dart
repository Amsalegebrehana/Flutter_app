
import 'package:flutter/material.dart';

@immutable
abstract class BottomNavigationEvent {}

class BottomHomePageEvent extends BottomNavigationEvent {}

class BottomCategoryPageEvent extends BottomNavigationEvent {}

class BottomOrdersPageEvent extends BottomNavigationEvent{}

class BottomJobsPageEvent extends BottomNavigationEvent{}

class BottomAccountPageEvent extends BottomNavigationEvent{}