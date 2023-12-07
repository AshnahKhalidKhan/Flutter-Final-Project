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
    );
  }
}