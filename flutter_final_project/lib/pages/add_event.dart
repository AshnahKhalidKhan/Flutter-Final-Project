import 'package:flutter/material.dart';
import 'package:flutter_final_project/reusable_widgets_constants/app_bar.dart';
import 'package:flutter_final_project/reusable_widgets_constants/app_bar_back_button.dart';

class AddEvent extends StatefulWidget 
{
  const AddEvent({super.key});

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> 
{
  @override
  Widget build(BuildContext context) 
  {
    return const Scaffold
    (
      backgroundColor: Colors.white,
      appBar: MyBackButtonAppBar(pagename: 'Add Event'),
      body: Padding
      (
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView
        (
          child: Column
          (
            children: 
            [
              TextField
              (
                
              )
            ]
          )
        )
      ),
    );
  }
}