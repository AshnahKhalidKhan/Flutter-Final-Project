import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/theme_color_picker/ThemeColorEvents.dart';
import 'package:flutter_final_project/blocs/theme_color_picker/ThemeColorStates.dart';
import 'package:flutter_final_project/main.dart';

class ThemeColorBloc extends Bloc<ThemeColorEvent, ThemeColorState> 
{
  ThemeColorBloc() : super(ThemeColorChangedState(GoogleRed))
  {
    on<ChangeThemeColorEvent>((event, emit) async 
    {
      emit(ThemeColorChangedState(event.color));
    });
  }
}