import 'dart:ui';
import 'package:equatable/equatable.dart';

abstract class ThemeColorState extends Equatable
{
  const ThemeColorState();
  List<Object> get props => [];
}

class ThemeColorChangedState extends ThemeColorState 
{
  final Color color;
  
  const ThemeColorChangedState(this.color);

  @override
  List<Object> get props => [color];
}