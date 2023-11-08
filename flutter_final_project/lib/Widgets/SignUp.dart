/*

- Show no cross or tick initially when signing in screen loads first time (null in place of RedCroossIcon and )
- Visibility password on/off 
- Password requirements meeting state
- Whatsaoo Icon
-Instagarm icon
- LinkedIn Icon
- Toggle GDSC Lead or GDSC Member mode

*/


import 'package:flutter/material.dart';

class SignUp extends StatefulWidget 
{
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

enum SampleGDSCCampusName { GDSCCampusNameOne, GDSCCampusNameTwo, GDSCCampusNameThree }
// SampleGDSCCampusName

class _SignUpState extends State<SignUp> 
{
  final TextEditingController campusController = TextEditingController();
  SampleGDSCCampusName? selectedCampus;

  Icon GreenCheckIcon = Icon
  (
    Icons.check_circle_rounded,
    color: Colors.green,
  );

  Icon RedCrossIcon = Icon
  (
    Icons.cancel_rounded,
    color: Colors.red,
  );

  // SampleGDSCCampusName? selectedMenu;

  bool leadOrMemberMode = true;
  bool firstTimeScreenLoad = true;

  final TextEditingController fullNameText = TextEditingController();
  final TextEditingController emailText = TextEditingController();
  final TextEditingController passwordText = TextEditingController();
  final TextEditingController confirmPasswordText = TextEditingController();
  final TextEditingController whatsAppNumberText = TextEditingController();
  final TextEditingController facebookLinkText = TextEditingController();
  final TextEditingController instagramLinkText = TextEditingController();
  final TextEditingController linkedInLinkText = TextEditingController();

  bool fullNameCorrect = false;
  bool emailCorrect = false;
  bool passwordMinimum8Characters = false;
  bool passwordHasOneUppercaseAlphabet = false;
  bool passwordHasOneDigit = false;
  bool passwordHasOneSpecialCharacter = false;
  bool confirmPasswordAndPasswordMatch = false;
  bool whatsAppNumberCorrect = false;
  bool facebookLinkCorrect = false;
  bool instagramLinkCorrect = false;
  bool linkedInLinkCorrect = false;
  bool allInputFieldsCorrect = false;

  bool passwordInvisible = true;


  @override
  Widget build(BuildContext context) 
  {
    final List<DropdownMenuEntry<SampleGDSCCampusName>> campusEntries = <DropdownMenuEntry<SampleGDSCCampusName>>[];
    for (final SampleGDSCCampusName campus in SampleGDSCCampusName.values)
    {
      campusEntries.add(DropdownMenuEntry<SampleGDSCCampusName>(value: campus, label: campus.name));
    }

    return Scaffold
    (
      body: Padding
      (
        padding: EdgeInsets.all(30.0),
        child: SingleChildScrollView
        (
          child: Column
          (
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: 
            [
              Image.asset
              (
                'lib/Assets/Google_Pocket_App_Logo_-_Edited-removebg-preview.png',
                width: 150,
                height: 150,
              ),







              // RadioMenuButton
              // (
              //   value: Invalid, 
              //   groupValue: groupValue, 
              //   onChanged: onChanged, 
              //   child: child
              // ),
              Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: 
                [
                  Container
                  (
                    // height: 30.0,
                    child: Text('GDSC Lead'),
                    color: leadOrMemberMode ? Colors.white : Colors.orange,
                  ),
                  Switch
                  (
                    value: leadOrMemberMode, 
                    onChanged: (bool LeadOrMember) 
                    {
                      setState(() 
                      {
                        leadOrMemberMode = !leadOrMemberMode;
                      });
                    }
                  ),
                  Container
                  (
                    child: Text('GDSC Member'),
                    color: leadOrMemberMode ? Colors.blue : Colors.white,
                  ),
                ],
              ),



              DropdownMenu<SampleGDSCCampusName>
              (
                width: MediaQuery.sizeOf(context).width - 60.0, //Crazy maths here, Ash!!
                controller: campusController,
                enableFilter: true,
                leadingIcon: const Icon(Icons.school_rounded),
                label: const Text('GDSC Campus Name'),
                dropdownMenuEntries: campusEntries,
                inputDecorationTheme: const InputDecorationTheme
                (
                  // filled: true,
                  // contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                ),
                onSelected: (SampleGDSCCampusName? campus) 
                {
                  setState(() 
                  {
                    firstTimeScreenLoad = false;
                    selectedCampus = campus;
                  });
                },
              ),



              // PopupMenuButton<SampleGDSCCampusName>
              // (
              //   child: TextField
              //   (
              //     readOnly: true,
              //     decoration: InputDecoration
              //     (
              //       labelText: 'GDSC Campus Name',
              //       helperText: 'Select from menu',
              //       suffixIcon: Icon(Icons.arrow_drop_down_circle),
              //     ),
              //   ),
              //   initialValue: null,
              //   // Callback that sets the selected popup menu item.
              //   onSelected: (SampleGDSCCampusName item) 
              //   {
              //     setState(() 
              //     {
              //       selectedMenu = item;
              //     });
              //   },
              //   itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleGDSCCampusName>>
              //   [
              //     const PopupMenuItem<SampleGDSCCampusName>
              //     (
              //       value: SampleGDSCCampusName.GDSCCampusNameOne,
              //       child: Text('GDSCCampusName 1'),
              //     ),
              //     const PopupMenuItem<SampleGDSCCampusName>
              //     (
              //       value: SampleGDSCCampusName.GDSCCampusNameTwo,
              //       child: Text('GDSCCampusName 2'),
              //     ),
              //     const PopupMenuItem<SampleGDSCCampusName>
              //     (
              //       value: SampleGDSCCampusName.GDSCCampusNameThree,
              //       child: Text('GDSCCampusName 3'),
              //     ),
              //   ],
              // ),

          

              // TextField
              // (
              //   readOnly: true,
              //   decoration: InputDecoration
              //   (
              //     labelText: 'GDSC Campus Name',
              //     helperText: 'Select from menu',
              //   ),
              //   onTap: () 
              //   {
              //     PopupMenuButton<SampleGDSCCampusName>
              //     (
              //       initialValue: selectedMenu,
              //       // Callback that sets the selected popup menu item.
              //       onSelected: (SampleGDSCCampusName item) 
              //       {
              //         setState(() 
              //         {
              //           selectedMenu = item;
              //         });
              //       },
              //       itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleGDSCCampusName>>
              //       [
              //         const PopupMenuItem<SampleGDSCCampusName>
              //         (
              //           value: SampleGDSCCampusName.GDSCCampusNameOne,
              //           child: Text('GDSCCampusName 1'),
              //         ),
              //         const PopupMenuItem<SampleGDSCCampusName>
              //         (
              //           value: SampleGDSCCampusName.GDSCCampusNameTwo,
              //           child: Text('GDSCCampusName 2'),
              //         ),
              //         const PopupMenuItem<SampleGDSCCampusName>
              //         (
              //           value: SampleGDSCCampusName.GDSCCampusNameThree,
              //           child: Text('GDSCCampusName 3'),
              //         ),
              //       ],
              //     );
              //   }
              // ),


              // TextField
              // (
              //   readOnly: true,
              //   decoration: InputDecoration
              //   (
              //     labelText: 'GDSC Campus Name',
              //     helperText: 'Select from menu',
              //     suffix: PopupMenuButton<SampleGDSCCampusName>
              //     (
              //       icon: Icon(Icons.arrow_drop_down_circle),
              //       initialValue: null,
              //       // Callback that sets the selected popup menu item.
              //       onSelected: (SampleGDSCCampusName item) 
              //       {
              //         setState(() 
              //         {
              //           selectedMenu = item;
              //         });
              //       },
              //       itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleGDSCCampusName>>
              //       [
              //         const PopupMenuItem<SampleGDSCCampusName>
              //         (
              //           value: SampleGDSCCampusName.GDSCCampusNameOne,
              //           child: Text('GDSCCampusName 1'),
              //         ),
              //         const PopupMenuItem<SampleGDSCCampusName>
              //         (
              //           value: SampleGDSCCampusName.GDSCCampusNameTwo,
              //           child: Text('GDSCCampusName 2'),
              //         ),
              //         const PopupMenuItem<SampleGDSCCampusName>
              //         (
              //           value: SampleGDSCCampusName.GDSCCampusNameThree,
              //           child: Text('GDSCCampusName 3'),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

              // PopupMenuButton<SampleGDSCCampusName>
              // (
              //   child: TextField
              //   (
              //     readOnly: true,
              //     decoration: InputDecoration
              //     (
              //       labelText: 'GDSC Campus Name',
              //       helperText: 'Select from menu',
              //       suffixIcon: Icon(Icons.arrow_drop_down_circle),
              //     ),
              //   ),
              //   initialValue: null,
              //   // Callback that sets the selected popup menu item.
              //   onSelected: (SampleGDSCCampusName item) 
              //   {
              //     setState(() 
              //     {
              //       selectedMenu = item;
              //     });
              //   },
              //   itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleGDSCCampusName>>
              //   [
              //     const PopupMenuItem<SampleGDSCCampusName>
              //     (
              //       value: SampleGDSCCampusName.GDSCCampusNameOne,
              //       child: Text('GDSCCampusName 1'),
              //     ),
              //     const PopupMenuItem<SampleGDSCCampusName>
              //     (
              //       value: SampleGDSCCampusName.GDSCCampusNameTwo,
              //       child: Text('GDSCCampusName 2'),
              //     ),
              //     const PopupMenuItem<SampleGDSCCampusName>
              //     (
              //       value: SampleGDSCCampusName.GDSCCampusNameThree,
              //       child: Text('GDSCCampusName 3'),
              //     ),
              //   ],
              // ),


              
              TextField
              (
                controller: fullNameText,
                decoration: InputDecoration
                (
                  prefixIcon: Icon(Icons.person_2_rounded),
                  labelText: 'Full Name',
                  helperText: fullNameCorrect ? null : 'Each word must be capitalized',
                  suffixIcon: firstTimeScreenLoad ? null : (fullNameCorrect ? GreenCheckIcon : RedCrossIcon),
                ),
              ),
              TextField
              (
                controller: emailText,
                decoration: InputDecoration
                (
                  prefixIcon: Icon(Icons.email_rounded),
                  labelText: 'Email',
                  helperText: emailCorrect ? null : 'Email must be valid',
                  suffixIcon: RedCrossIcon,
                ),
              ),
              TextField
              (
                controller: passwordText,
                obscureText: passwordInvisible,
                decoration: InputDecoration
                (
                  prefixIcon: Icon(Icons.key_rounded),
                  labelText: 'Password',
                  suffixIcon: GestureDetector
                  (
                    child: passwordInvisible ? Icon(Icons.visibility_off_rounded) : Icon(Icons.visibility_rounded),
                    onTap: () 
                    {
                      setState(() 
                      {
                        passwordInvisible = !passwordInvisible;
                      });
                    }
                  ),
                  error: Column
                  (
                    children: firstTimeScreenLoad ? <Widget>[] :
                    [
                      Row
                      (
                        children:
                        [
                          passwordMinimum8Characters ? GreenCheckIcon : RedCrossIcon,
                          SizedBox(width: 5.0),
                          Text('Minimum 8 characters'),
                        ],
                      ),
                      Row
                      (
                        children: 
                        [
                          passwordHasOneUppercaseAlphabet ? GreenCheckIcon : RedCrossIcon,
                          SizedBox(width: 5.0),
                          Text('Has one uppercase alphabet (A-Z)'),
                        ],
                      ),
                      Row
                      (
                        children: 
                        [
                          
                          passwordHasOneDigit ? GreenCheckIcon : RedCrossIcon,
                          SizedBox(width: 5.0),
                          Text('Has one digit (0-9)'),
                        ],
                      ),
                      Row
                      (
                        children: 
                        [
                          passwordHasOneSpecialCharacter ? GreenCheckIcon : RedCrossIcon,
                          SizedBox(width: 5.0),
                          Text('Has one special character (!, @, #...)'),
                        ],
                      ),
                    ].toList(),
                  ),
                ),
              ),
              TextField
              (
                controller: confirmPasswordText,
                obscureText: true,
                decoration: InputDecoration
                (
                  prefixIcon: Icon(Icons.key_rounded),
                  labelText: 'Confirm Password',
                  helperText: confirmPasswordAndPasswordMatch.toString(),
                  suffixIcon: confirmPasswordAndPasswordMatch ? GreenCheckIcon : RedCrossIcon,
                ),
                onChanged: (value) 
                {
                  if (confirmPasswordText == passwordText)
                  {
                    setState(() 
                    {
                      confirmPasswordAndPasswordMatch = true;
                    });
                  }
                  else
                  {
                    setState(() 
                    {
                      confirmPasswordAndPasswordMatch = false;
                    });
                  }
                },
              ),
              TextField
              (
                controller: whatsAppNumberText,
                obscureText: true,
                decoration: InputDecoration
                (
                  prefixIcon: Icon(Icons.call_rounded),
                  labelText: 'WhatsApp Number',
                  helperText: 'e.g. +923022932933',
                  suffixIcon: whatsAppNumberCorrect ? GreenCheckIcon : RedCrossIcon,
                ),
              ),
              TextField
              (
                controller: facebookLinkText,
                obscureText: true,
                decoration: InputDecoration
                (
                  prefixIcon: Icon(Icons.facebook_rounded),
                  labelText: 'Facebook Profile Link',
                  helperText: 'e.g. https://www.facebook.com/marium.s13/',
                  suffixIcon: facebookLinkCorrect ? GreenCheckIcon : RedCrossIcon,
                ),
              ),
              TextField
              (
                controller: instagramLinkText,
                obscureText: true,
                decoration: InputDecoration
                (
                  prefixIcon: Icon(Icons.linked_camera_outlined),
                  labelText: 'Instagram Profile Link',
                  helperText: 'e.g. https://www.instagram.com/gdsc.iba/',
                  suffixIcon: instagramLinkCorrect ? GreenCheckIcon : RedCrossIcon,
                ),
              ),
              TextField
              (
                controller: linkedInLinkText,
                obscureText: true,
                decoration: InputDecoration
                (
                  prefixIcon: Icon(Icons.book_rounded),
                  labelText: 'LinkedIn Profile Link',
                  helperText: 'e.g. https://www.linkedin.com/in/msarim/',
                  suffixIcon: linkedInLinkCorrect ? GreenCheckIcon : RedCrossIcon,
                ),
              ),
              ElevatedButton
              (
                child: Text('Sign Up'),
                style: ButtonStyle
                (
                  fixedSize: MaterialStateProperty.all(const Size(double.maxFinite, 50.0)),
                ),
                onPressed: () {}, 
              ),
            ],
          ),
        ),
      ),
    );
  }
}