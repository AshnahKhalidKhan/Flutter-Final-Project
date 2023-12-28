import 'package:flutter/material.dart';

class GDSCMembersPendingRequest extends StatefulWidget 
{
  const GDSCMembersPendingRequest({super.key});

  @override
  State<GDSCMembersPendingRequest> createState() => _GDSCMembersPendingRequestState();
}

class _GDSCMembersPendingRequestState extends State<GDSCMembersPendingRequest> 
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
        centerTitle: true,
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
              'Your GDSC Lead needs to approve your sign up request before you can access your GDSC\'s account. Please return once your request has been approved.',
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