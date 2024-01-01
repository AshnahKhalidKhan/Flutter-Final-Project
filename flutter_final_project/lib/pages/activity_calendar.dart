import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityCalendar extends StatefulWidget 
{
  const ActivityCalendar({super.key});

  @override
  State<ActivityCalendar> createState() => _ActivityCalendarState();
}

class _ActivityCalendarState extends State<ActivityCalendar> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      appBar: AppBar
      (
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Icon
        (
          Icons.calendar_month_rounded,
          color: Colors.white,
          size: 30.0
        ),
        title: const Text
        (
          'Activity Calendar', 
          style: TextStyle
          (
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
      body: Padding
      (
        padding: EdgeInsets.all(10.0),
        child: ListView.builder
        (
          itemCount: 365,
          itemBuilder: (context, index) 
          {
            final currentDate = DateTime.now();
            final date = currentDate.add(Duration(days: index));
            final formattedDate = DateFormat('EEEE, MMMM d, y').format(date);
            return Padding
            (
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ListTile
              (
                shape: RoundedRectangleBorder
                (
                  side: BorderSide
                  (
                    color: Theme.of(context).colorScheme.primary,
                    width: 2.0
                  ),
                  borderRadius: BorderRadius.circular(20.0)
                ),
                tileColor: Colors.white,
                style: ListTileStyle.list,
                subtitle: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: 
                  [
                    Column
                    (
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: 
                      [
                        Text
                        (
                          DateFormat('d MMM').format(date),
                          style: TextStyle
                          (
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        // Text
                        // (
                        //   DateFormat('yy').format(date),
                        //   style: TextStyle
                        //   (
                    
                        //   ),
                        // ),
                        Text(DateFormat('E').format(date)),
                      ],
                    ),
                    Column
                    (
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: 
                      [
                        index % 3 == 0 ? Text('No events to show') : Text('Web Development Bootcamp'),
                        index % 4 == 0 ? Text('Cybersecurity workshop') : SizedBox(height: 0.0, width: 0.0,),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      )
    );
  }
}