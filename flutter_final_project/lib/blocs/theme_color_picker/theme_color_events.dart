import 'dart:ui';
import 'package:equatable/equatable.dart';

abstract class ThemeColorEvent extends Equatable
{
  const ThemeColorEvent();
  List<Object> get props => [];
}

class ChangeThemeColorEvent extends ThemeColorEvent 
{
  final Color color;
  
  const ChangeThemeColorEvent(this.color);

  @override
  List<Object> get props => [color];
}