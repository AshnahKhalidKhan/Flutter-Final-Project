import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationBloc.dart';
import 'package:flutter_final_project/Blocs/AuthenticationEvents.dart';
import 'package:flutter_final_project/Blocs/AuthenticationStates.dart';
import 'package:flutter_final_project/Blocs/GDSCCampusesBloc.dart';
import 'package:flutter_final_project/Blocs/GDSCCampusesEvents.dart';
import 'package:flutter_final_project/Blocs/GDSCCampusesStates.dart';
import 'package:flutter_final_project/Models/GDSCCampusModel.dart';

class GDSCCampusesList extends StatefulWidget 
{
  const GDSCCampusesList({super.key});

  @override
  State<GDSCCampusesList> createState() => _GDSCCampusesListState();
}

class _GDSCCampusesListState extends State<GDSCCampusesList> 
{

  @override
  void initState() 
  {
    BlocProvider.of<GDSCCampusesBloc>(context).add(ReadAllGDSCCampusesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      backgroundColor: Colors.white,
      appBar: AppBar
      (
        backgroundColor: Theme.of(context).colorScheme.primary,
        leading: Builder
        (
          builder: (BuildContext context) 
          {
            return IconButton
            (
              icon: Icon(Icons.menu_rounded),
              color: Colors.white,
              onPressed: () 
              {
                Scaffold.of(context).openDrawer();
              },
            );
          }
        ),
        title: const Text
        (
          'Campuses', 
          style: TextStyle
          (
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30.0,
          ),
        ),
      ),
      drawer: Drawer
      (
        backgroundColor: Colors.white,
        child: ListView
        (
          padding: EdgeInsets.all(0.0),
          children: 
          [
            DrawerHeader
            (
              child: SizedBox(width: 20.0),
              decoration: BoxDecoration
              (
                image: DecorationImage
                (
                  image: AssetImage
                  (
                    'lib/Assets/Google_Pocket_App_Logo_-_Edited-removebg-preview.png'
                  ),
                  fit: BoxFit.fitHeight,
                ),
                // gradient: LinearGradient(colors: [GoogleBlue, GoogleGreen, GoogleRed, GoogleYellow].toList())
              ),
            ),
            BlocConsumer<AuthenticationBloc, AuthenticationState>
            (
              builder: (context, state)
              {
                return ListTile
                (
                  // shape: RoundedRectangleBorder
                  // (
                  //   side: BorderSide
                  //   (
                  //     color: Theme.of(context).colorScheme.primary,
                  //     width: 2.0,
                  //   ),
                  //   borderRadius: BorderRadius.circular(0.0)
                  // ),
                  // tileColor: Colors.white,
                  leading: Icon
                  (
                    Icons.logout_rounded,
                    color: Theme.of(context).colorScheme.primary,
                    size: 30.0
                  ),
                  title: Text
                  (
                    'Sign Out',
                    style: TextStyle
                    (
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap:() 
                  {
                    BlocProvider.of<AuthenticationBloc>(context).add
                    (
                      AuthenticationSignOutEvent()
                    );
                  },
                );
              },
              listener: (context, state) 
              {
                if (state is AuthenticationInitialState) 
                {
                  Navigator.pushNamedAndRemoveUntil
                  (
                    context,
                    '/LoginSignUp',
                    (route) => false,
                  );
                }
                else if (state is AuthenticationErrorState) 
                {
                  final signOutErrorSnackBarMessage = SnackBar
                  (
                    content: Text
                    (
                      state.error,
                      style: TextStyle
                      (
                        color: Colors.white,
                        fontSize: 20.0
                      ),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(signOutErrorSnackBarMessage);
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large
      (
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: GDSCCampusAddButton()
      ),
      body: Padding
      (
        padding: EdgeInsets.all(10.0),
        child: BlocBuilder<GDSCCampusesBloc, GDSCCampusesState>
        (
          builder: (context, state)
          {
            if (state is GDSCCampusesLoadingState)
            {
              return Center(child: CircularProgressIndicator());
            }
            else if (state is GDSCCampusesErrorState)
            {
              return Center(child: Text(state.error));
            }
            else if (state is GDSCCampusesSuccessOrLoadedState)
            {
              return StreamBuilder<List<GDSCCampus>>
              (
                stream: state.campus,
                builder: (context, snapshot)
                {
                  if (snapshot.hasError) 
                  {
                    return Text('Error: ${snapshot.error}');
                  } 
                  else if (snapshot.hasData)
                  {
                    List<GDSCCampus>? campuses = snapshot.data;
                    return ListView.builder
                    (
                      itemCount: campuses!.length,
                      itemBuilder: (context, i)
                      {
                        return GDSCCampusListTile(context, campuses![i]);
                      }
                    );
                  }
                  else
                  {
                    return Center(child: CircularProgressIndicator());
                  }
                }
              );
            }
            else
            {
              return Center(child: Text('Unable to load campuses list at the moment. Please try later.'));
            }
          }
        ),
      )
    );
  }

  Padding GDSCCampusListTile(BuildContext context, GDSCCampus campus) 
  {
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
        title: Text
        (
          campus.campusName,
          style: TextStyle
          (
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
        ),
        subtitle: Column
        (
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: 
          [
            CampusInfoField(icon: Icons.school_rounded, text: campus.campusName),
            SizedBox(height: 10.0),
            CampusInfoField(icon: Icons.email, text: campus.email),
            SizedBox(height: 10.0),
            CampusInfoField(icon: Icons.location_pin, text: campus.location),
            SizedBox(height: 10.0),
            CampusInfoField(icon: Icons.star_rounded, text: campus.lead.isEmpty ? 'No Lead assigned' : campus.lead),
          ],
        ),
        trailing: Icon
        (
          Icons.expand_more,
          size: 40.0,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () 
        {
          GDSCCampusTileBottomSheet(context, campus);
        },
      ),
    );
  }

  Future<void> GDSCCampusTileBottomSheet(BuildContext context, GDSCCampus campus) 
  {
    return showModalBottomSheet<void>
    (
      context: context, 
      isScrollControlled: true,
      builder: (BuildContext context)
      {
        return SizedBox
        (
          width: double.infinity,
          child: Padding
          (
            padding: EdgeInsets.all(10.0),
            child: ListTile
            (
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              tileColor: Colors.white,
              subtitle: Padding
              (
                padding: EdgeInsets.only(top: 20.0),
                child: Column
                (
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: 
                  [
                    GDSCCampusInfoField(icon: Icons.school_rounded, text: campus.campusName),
                    SizedBox(height: 10.0),
                    GDSCCampusInfoField(icon: Icons.email, text: campus.email),
                    SizedBox(height: 10.0),
                    GDSCCampusInfoField(icon: Icons.location_pin, text: campus.location),
                    SizedBox(height: 10.0),
                    GDSCCampusInfoField(icon: Icons.star_rounded, text: campus.lead.isEmpty ? 'No Lead assigned' : campus.lead),
                    SizedBox(height: 20.0),
                    Row
                    (
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: 
                      [
                        GDSCCampusDeleteButton(campus: campus),
                        GDSCCampusEditButton(campus: campus)
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}

class GDSCCampusAddButton extends StatelessWidget 
{
  const GDSCCampusAddButton
  (
    {
      super.key
    }
  );

  @override
  Widget build(BuildContext context) 
  {
    return IconButton
    (
      style: ButtonStyle
      (
        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
        iconColor: MaterialStatePropertyAll(Colors.white),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon
      (
        Icons.add, 
        size: 40.0
      ),
      onPressed: () async 
      {
        return showDialog<void>
        (
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) 
          {
            final TextEditingController campusName = TextEditingController();
            final TextEditingController campusEmail = TextEditingController();
            final TextEditingController campusLead = TextEditingController();
            final TextEditingController campusLocation = TextEditingController();

            return AlertDialog
            (
              title: const Text('Add Campus'),
              content: Column
              (
                mainAxisSize: MainAxisSize.min,
                children: 
                [
                  TextField
                  (
                    controller: campusName,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.school_rounded),
                      labelText: 'Name',
                    ),
                    onChanged: (value)
                    {

                    },
                  ),
                  TextField
                  (
                    controller: campusEmail,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Email',
                    ),
                    onChanged: (value)
                    {
                      //
                    },
                  ),
                  TextField
                  (
                    controller: campusLocation,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.location_pin),
                      labelText: 'Location',
                    ),
                    onChanged: (value)
                    {
                      //
                    },
                  ),
                  // TextField
                  // (
                  //   controller: campusLead,
                  //   decoration: InputDecoration
                  //   (
                  //     prefixIcon: Icon(Icons.star_rounded),
                  //     labelText: 'Lead',
                  //   ),
                  //   onChanged: (value)
                  //   {
                  //     //
                  //   },
                  // ),
                ],
              ),
              actions: <Widget>
              [
                TextButton
                (
                  child: const Text('Cancel'),
                  onPressed: () 
                  {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
                TextButton
                (
                  child: const Text('Save'),
                  onPressed: () 
                  {
                    BlocProvider.of<GDSCCampusesBloc>(context).add
                    (
                      CreateGDSCCampusEvent
                      (
                        campusName.text, campusEmail.text, campusLocation.text
                      )
                    );
                    Navigator.pop(context, 'Save');
                    final updateGDSCCampusSnackBarMessage = SnackBar
                    (
                      content: Text
                      (
                        'GDSCCampus added.',
                        style: TextStyle
                        (
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(updateGDSCCampusSnackBarMessage);
                  },
                ),
              ],
            );
          },
        );
      }, 
    );
  }
}

class GDSCCampusEditButton extends StatefulWidget 
{
  final GDSCCampus campus;

  const GDSCCampusEditButton
  (
    {
      super.key,
      required this.campus
    }
  );

  @override
  State<GDSCCampusEditButton> createState() => _GDSCCampusEditButtonState();
}

class _GDSCCampusEditButtonState extends State<GDSCCampusEditButton> 
{
  @override
  Widget build(BuildContext context) 
  {
    GDSCCampus updatedCampus = GDSCCampus
    (
      campusId: widget.campus.campusId, 
      campusName: widget.campus.campusName, 
      email: widget.campus.email, 
      location: widget.campus.location, 
      lead: widget.campus.lead
    );
    return IconButton
    (
      style: ButtonStyle
      (
        backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.primary),
        iconColor: MaterialStatePropertyAll(Colors.white),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon
      (
        Icons.edit, 
        size: 30.0
      ),
      onPressed: () async 
      {
        return showDialog<void>
        (
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) 
          {
            final TextEditingController campusName = TextEditingController(text: widget.campus.campusName);
            final TextEditingController campusEmail = TextEditingController(text: widget.campus.email);
            final TextEditingController campusLead = TextEditingController(text: widget.campus.lead);
            final TextEditingController campusLocation = TextEditingController(text: widget.campus.location);

            return AlertDialog
            (
              title: const Text('Edit Campus'),
              content: Column
              (
                mainAxisSize: MainAxisSize.min,
                children: 
                [
                  TextField
                  (
                    controller: campusName,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.school_rounded),
                      labelText: 'Name',
                    ),
                    onChanged: (value)
                    {
                      updatedCampus = updatedCampus.copyWith(campusName: campusName.text);
                    },
                  ),
                  TextField
                  (
                    controller: campusEmail,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.email_rounded),
                      labelText: 'Email',
                    ),
                    onChanged: (value)
                    {
                      updatedCampus = updatedCampus.copyWith(email: campusEmail.text);
                    },
                  ),
                  TextField
                  (
                    controller: campusLocation,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.location_pin),
                      labelText: widget.campus.campusId,//'Location',
                    ),
                    onChanged: (value)
                    {
                      updatedCampus = updatedCampus.copyWith(location: campusLocation.text);
                    },
                  ),
                  TextField
                  (
                    controller: campusLead,
                    decoration: InputDecoration
                    (
                      prefixIcon: Icon(Icons.star_rounded),
                      labelText: 'Lead',
                    ),
                    onChanged: (value)
                    {
                      setState(() 
                      {
                        updatedCampus = updatedCampus.copyWith(lead: campusLead.text);
                        print(updatedCampus.toString());
                      });
                    },
                  ),
                ],
              ),
              actions: <Widget>
              [
                TextButton
                (
                  child: const Text('Cancel'),
                  onPressed: () 
                  {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
                TextButton
                (
                  child: const Text('Save'),
                  onPressed: () 
                  {
                    BlocProvider.of<GDSCCampusesBloc>(context).add
                    (
                      UpdateGDSCCampusEvent
                      (
                        updatedCampus
                      )
                    );
                    Navigator.pop(context, 'Save');
                    Navigator.pop(context, 'BottomSheet');
                    final updateGDSCCampusSnackBarMessage = SnackBar
                    (
                      content: Text
                      (
                        'GDSCCampus information updated.',
                        style: TextStyle
                        (
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(updateGDSCCampusSnackBarMessage);
                  },
                ),
              ],
            );
          },
        );
      }, 
    );
  }
}

class GDSCCampusDeleteButton extends StatelessWidget 
{
  GDSCCampusDeleteButton
  (
    {
      super.key,
      required this.campus
    }
  );

  final GDSCCampus campus;

  @override
  Widget build(BuildContext context) 
  {
    return IconButton
    (
      style: const ButtonStyle
      (
        iconColor: MaterialStatePropertyAll(Colors.grey),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon
      (
        Icons.delete, 
        size: 30.0
      ),
      onPressed: () async 
      {
        return showDialog<void>
        (
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) 
          {
            return AlertDialog
            (
              title: const Text('Delete campus?'),
              actions: <Widget>
              [
                TextButton
                (
                  child: const Text('Cancel'),
                  onPressed: () 
                  {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
                TextButton
                (
                  child: const Text('OK'),
                  onPressed: () 
                  {
                    BlocProvider.of<GDSCCampusesBloc>(context).add
                    (
                      DeleteGDSCCampusEvent
                      (
                        campus.campusId,
                      )
                    );
                    Navigator.pop(context, 'OK');
                    Navigator.pop(context, 'BottomSheet');
                    final deleteGDSCCampusSnackBarMessage = SnackBar
                    (
                      content: Text
                      (
                        'GDSCCampus deleted.',
                        style: TextStyle
                        (
                          color: Colors.white,
                          fontSize: 20.0
                        ),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(deleteGDSCCampusSnackBarMessage);
                  },
                ),
              ],
            );
          },
        );
      }, 
    );
  }
}

class GDSCCampusInfoField extends StatelessWidget 
{  
  const GDSCCampusInfoField
  (
    {
      super.key,
      required this.icon,
      required this.text,
    }
  );

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) 
  {
    return Row
    (
      mainAxisAlignment: MainAxisAlignment.start,
      children: 
      [
        Icon
        (
          icon,
          size: 40.0,
          color: Theme.of(context).colorScheme.primary
        ),
        SizedBox(width: 10.0),
        Expanded
        (
          child: Text
          (
            text,
            style: TextStyle
            (
              fontSize: 20.0,
              // color: Colors.black
            ),
          )
        )
      ],
    );
  }
}

class CampusInfoField extends StatelessWidget 
{  
  const CampusInfoField
  (
    {
      super.key,
      required this.icon,
      required this.text,
    }
  );

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) 
  {
    return Row
    (
      mainAxisAlignment: MainAxisAlignment.start,
      children: 
      [
        Icon
        (
          icon,
          size: 20.0,
          color: Theme.of(context).colorScheme.primary
        ),
        SizedBox(width: 10.0),
        Expanded
        (
          child: Text
          (
            text,
            style: TextStyle
            (
              fontSize: 15.0,
              // color: Colors.black
            ),
          )
        )
      ],
    );
  }
}