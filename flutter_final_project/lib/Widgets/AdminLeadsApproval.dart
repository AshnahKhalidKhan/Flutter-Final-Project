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
        title: Text("Pending Requests")
      ),
      body: Padding
      (
        padding: EdgeInsets.all(30.0),
        child: Column
        (
          children: 
          [
            ElevatedButton
            (
              onPressed: () {},
              child: Text("Approved Leads")
            ),
          ],
        ),
      ),
    );
  }
}