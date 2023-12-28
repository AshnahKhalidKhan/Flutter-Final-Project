import 'package:flutter/material.dart';

class GDSCLeadPendingRequest extends StatefulWidget 
{
  const GDSCLeadPendingRequest({super.key});

  @override
  State<GDSCLeadPendingRequest> createState() => _GDSCLeadPendingRequestState();
}

class _GDSCLeadPendingRequestState extends State<GDSCLeadPendingRequest> 
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
        leading: BackButton
        (
          color: Colors.white,
        ),
        title: const Text
        (
          'Pending Approval', 
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
        padding: EdgeInsets.all(20.0),
        child: Column
        (
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
          [
            Spacer(),
            Image.asset
            (
              'lib/Assets/Pending_Approval.png',
              fit: BoxFit.fitWidth,
            ),
            SizedBox(height: 30.0),
            Text
            (
              'Your GDSC Lead request needs to be approved by an Admin before you can access your GDSC Lead privelleges. Please return once your request has been approved.',
              style: TextStyle
              (
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            ElevatedButton.icon
            (
              style: ButtonStyle
              (
                backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
                padding: MaterialStatePropertyAll(EdgeInsets.all(20.0)),
                minimumSize: MaterialStatePropertyAll(Size.fromHeight(50)),
              ),
              onPressed: () {}, 
              icon: const Icon
              (
                Icons.logout_rounded,
                color: Colors.white,
                size: 30.0
              ), 
              label: const Text
              (
                'Sign Out',
                style: TextStyle
                (
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
              )
            )
          ],
        ),
      )
    );
  }
}