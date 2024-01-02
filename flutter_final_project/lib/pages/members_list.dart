import 'package:flutter/material.dart';

class GDSCLeadsApproval extends StatefulWidget 
{
  const GDSCLeadsApproval({super.key});

  @override
  State<GDSCLeadsApproval> createState() => _GDSCLeadsApprovalState();
}

class _GDSCLeadsApprovalState extends State<GDSCLeadsApproval> 
{
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        leading: Icon(Icons.arrow_back_rounded),
        title: Text("Pending Requests")
      ),
      body: Padding
      (
        padding: EdgeInsets.all(5.0),
        child: Column
        (
          children: 
          [
            ElevatedButton
            (
              onPressed: () {},
              child: Text("Approved Leads")
            ),
            ListTile
            (
              title: Text("Member Name"),
              subtitle: Text("Name of GDSC Campus"),
              trailing: Row
              (
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: 
                [
                  IconButton
                  (
                    onPressed: () 
                    {
                      
                    },
                    icon: Icon
                    (
                      Icons.check_circle_rounded,
                      color: Colors.green,
                    ),
                  ),
                  IconButton
                  (
                    onPressed: () {},
                    icon: Icon
                    (
                      Icons.cancel_rounded,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}