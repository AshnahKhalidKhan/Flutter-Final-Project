import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_final_project/blocs/campuses_list/campuses_list_bloc.dart';
import 'package:flutter_final_project/blocs/campuses_list/campuses_list_events.dart';
import 'package:flutter_final_project/blocs/campuses_list/campuses_list_states.dart';
import 'package:flutter_final_project/models/campus_model.dart';
import 'package:flutter_final_project/reusable_widgets_constants/app_bar.dart';
import 'package:flutter_final_project/reusable_widgets_constants/bottom_sheet_icon_text_info.dart';
import 'package:flutter_final_project/reusable_widgets_constants/circle_progress_indicator.dart';
import 'package:flutter_final_project/reusable_widgets_constants/drawer.dart';
import 'package:flutter_final_project/reusable_widgets_constants/list_tile_icon_text_info.dart';
import 'package:flutter_final_project/reusable_widgets_constants/snack_bar.dart';

class CampusesList extends StatefulWidget {
  const CampusesList({super.key});

  @override
  State<CampusesList> createState() => _CampusesListState();
}

class _CampusesListState extends State<CampusesList> {
  @override
  void initState() {
    BlocProvider.of<CampusesBloc>(context).add(ReadAllCampusesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const MyAppBar(pagename: 'Campuses'),
        drawer: const MyDrawer(),
        floatingActionButton: FloatingActionButton.large(
            onPressed: () {},
            shape: CircleBorder(),
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: CampusAddButton()),
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: BlocBuilder<CampusesBloc, CampusesState>(
              builder: (context, state) {
            if (state is CampusesLoadingState) {
              return const MyCircularProgressIndicator();
            } else if (state is CampusesErrorState) {
              return Center(child: Text(state.error));
            } else if (state is CampusesLoadedState) {
              return StreamBuilder<List<Campus>>(
                  stream: state.campus,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      List<Campus>? campuses = snapshot.data;
                      return ListView.builder(
                          itemCount: campuses!.length,
                          itemBuilder: (context, i) {
                            return CampusListTile(context, campuses![i]);
                          });
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  });
            } else {
              return Center(
                  child: Text(
                      'Unable to load campuses list at the moment. Please try later.'));
            }
          }),
        ));
  }

  Padding CampusListTile(BuildContext context, Campus campus) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 2.0),
            borderRadius: BorderRadius.circular(20.0)),
        tileColor: Colors.white,
        style: ListTileStyle.list,
        title: Text(
          campus.campusName,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListTileIconTextInfo(
                icon: Icons.school_rounded, info: campus.campusName),
            SizedBox(height: 10.0),
            ListTileIconTextInfo(icon: Icons.email, info: campus.email),
            SizedBox(height: 10.0),
            ListTileIconTextInfo(
                icon: Icons.location_pin, info: campus.location),
            SizedBox(height: 10.0),
            ListTileIconTextInfo(
                icon: Icons.star_rounded,
                info: campus.lead!.isEmpty ? 'No Lead assigned' : campus.lead!),
          ],
        ),
        trailing: Icon(
          Icons.expand_more,
          size: 40.0,
          color: Theme.of(context).colorScheme.primary,
        ),
        onTap: () {
          CampusTileBottomSheet(context, campus);
        },
      ),
    );
  }

  Future<void> CampusTileBottomSheet(BuildContext context, Campus campus) {
    return showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                tileColor: Colors.white,
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BottomSheetIconTextInfo(
                          icon: Icons.school_rounded, info: campus.campusName),
                      SizedBox(height: 10.0),
                      BottomSheetIconTextInfo(
                          icon: Icons.email, info: campus.email),
                      SizedBox(height: 10.0),
                      BottomSheetIconTextInfo(
                          icon: Icons.location_pin, info: campus.location),
                      SizedBox(height: 10.0),
                      BottomSheetIconTextInfo(
                          icon: Icons.star_rounded,
                          info: campus.lead!.isEmpty
                              ? 'No Lead assigned'
                              : campus.lead!),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CampusDeleteButton(campus: campus),
                          CampusEditButton(campus: campus)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class CampusAddButton extends StatelessWidget {
  const CampusAddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CampusesBloc, CampusesState>(
      builder: (context, state) {
        if (state is CampusesLoadedState) {
          return IconButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary),
              iconColor: MaterialStatePropertyAll(Colors.white),
            ),
            padding: EdgeInsets.all(20.0),
            icon: Icon(Icons.add, size: 40.0),
            onPressed: () async {
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  final TextEditingController campusName =
                      TextEditingController();
                  final TextEditingController campusEmail =
                      TextEditingController();
                  final TextEditingController campusLead =
                      TextEditingController();
                  final TextEditingController campusLocation =
                      TextEditingController();

                  return AlertDialog(
                    title: const Text('Add Campus'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: campusName,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.school_rounded),
                            labelText: 'Name',
                          ),
                          onChanged: (value) {},
                        ),
                        TextField(
                          controller: campusEmail,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            labelText: 'Email',
                          ),
                          onChanged: (value) {
                            //
                          },
                        ),
                        TextField(
                          controller: campusLocation,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_pin),
                            labelText: 'Location',
                          ),
                          onChanged: (value) {
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
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                        },
                      ),
                      TextButton(
                          child: const Text('Save'),
                          onPressed: () {
                            BlocProvider.of<CampusesBloc>(context).add(
                                CreateCampusEvent(campusName.text,
                                    campusEmail.text, campusLocation.text));
                                    Navigator.pop(context, 'Save');
                            
                          }),
                    ],
                  );
                },
              );
            },
          );
        } else {
          return MyCircularProgressIndicator();
        }
      },
      listener: (context, state) {
        if (state is CampusesErrorState) {
          final errorAddingCampusSnackBarMessage = MySnackBar(state.error);
          ScaffoldMessenger.of(context)
              .showSnackBar(errorAddingCampusSnackBarMessage);
        } else if (state is CampusAddedState) {
          
          final addedCampusSnackBarMessage = MySnackBar('Campus added.');
          ScaffoldMessenger.of(context)
              .showSnackBar(addedCampusSnackBarMessage);
          BlocProvider.of<CampusesBloc>(context).add(ReadAllCampusesEvent());
        }
      },
    );
  }
}

class CampusEditButton extends StatefulWidget {
  final Campus campus;

  const CampusEditButton({super.key, required this.campus});

  @override
  State<CampusEditButton> createState() => _CampusEditButtonState();
}

class _CampusEditButtonState extends State<CampusEditButton> {
  @override
  Widget build(BuildContext context) {
    Campus updatedCampus = Campus(
        campusId: widget.campus.campusId,
        campusName: widget.campus.campusName,
        email: widget.campus.email,
        location: widget.campus.location,
        lead: widget.campus.lead);
    return BlocConsumer<CampusesBloc, CampusesState>(
      builder: (context, state) {
        if (state is CampusesLoadedState) {
          return IconButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(
                  Theme.of(context).colorScheme.primary),
              iconColor: MaterialStatePropertyAll(Colors.white),
            ),
            padding: EdgeInsets.all(20.0),
            icon: Icon(Icons.edit, size: 30.0),
            onPressed: () async {
              return showDialog<void>(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  final TextEditingController campusName =
                      TextEditingController(text: widget.campus.campusName);
                  final TextEditingController campusEmail =
                      TextEditingController(text: widget.campus.email);
                  final TextEditingController campusLead =
                      TextEditingController(text: widget.campus.lead);
                  final TextEditingController campusLocation =
                      TextEditingController(text: widget.campus.location);

                  return AlertDialog(
                    title: const Text('Edit Campus'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: campusName,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.school_rounded),
                            labelText: 'Name',
                          ),
                          onChanged: (value) {
                            updatedCampus = updatedCampus.copyWith(
                                campusName: campusName.text);
                          },
                        ),
                        TextField(
                          controller: campusEmail,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_rounded),
                            labelText: 'Email',
                          ),
                          onChanged: (value) {
                            updatedCampus =
                                updatedCampus.copyWith(email: campusEmail.text);
                          },
                        ),
                        TextField(
                          controller: campusLocation,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_pin),
                            labelText: 'Location',
                          ),
                          onChanged: (value) {
                            updatedCampus = updatedCampus.copyWith(
                                location: campusLocation.text);
                          },
                        ),
                        TextField(
                          controller: campusLead,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.star_rounded),
                            labelText: 'Lead',
                          ),
                          onChanged: (value) {
                            setState(() {
                              updatedCampus =
                                  updatedCampus.copyWith(lead: campusLead.text);
                              print(updatedCampus.toString());
                            });
                          },
                        ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context, 'Cancel');
                        },
                      ),
                      TextButton(
                        child: const Text('Save'),
                        onPressed: () {
                          BlocProvider.of<CampusesBloc>(context)
                              .add(UpdateCampusEvent(updatedCampus));
                              Navigator.pop(context, 'Save');
          Navigator.pop(context, 'BottomSheet');
                        },
                      ),
                    ],
                  );
                },
              );
            },
          );
        } else {
          return MyCircularProgressIndicator();
        }
      },
      listener: (context, state) {
        if (state is CampusesErrorState) {
          final errorUpdatingCampusSnackBarMessage = MySnackBar(state.error);
          ScaffoldMessenger.of(context)
              .showSnackBar(errorUpdatingCampusSnackBarMessage);
        } else if (state is CampusUpdatedState) {
          
          final updatedCampusSnackBarMessage =
              MySnackBar('Campus information updated.');
          ScaffoldMessenger.of(context)
              .showSnackBar(updatedCampusSnackBarMessage);
          BlocProvider.of<CampusesBloc>(context).add(ReadAllCampusesEvent());
        }
      },
    );
  }
}

class CampusDeleteButton extends StatelessWidget {
  CampusDeleteButton({super.key, required this.campus});

  final Campus campus;

  @override
  Widget build(BuildContext context) {
return BlocConsumer<CampusesBloc, CampusesState>(
      builder: (context, state) {
        if (state is CampusesLoadedState) {
         return IconButton(
      style: const ButtonStyle(
        iconColor: MaterialStatePropertyAll(Colors.grey),
      ),
      padding: EdgeInsets.all(20.0),
      icon: Icon(Icons.delete, size: 30.0),
      onPressed: () async {
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Delete campus?'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    BlocProvider.of<CampusesBloc>(context)
                        .add(DeleteCampusEvent(
                      campus.campusId,
                    ));      
               Navigator.pop(context, 'OK');
          Navigator.pop(context, 'BottomSheet');              
                  },
                ),
              ],
            );
          },
        );
      },
    );
        } else {
          return MyCircularProgressIndicator();
        }
      },
      listener: (context, state) {
        if (state is CampusesErrorState) {
          final errorUpdatingCampusSnackBarMessage = MySnackBar(state.error);
          ScaffoldMessenger.of(context)
              .showSnackBar(errorUpdatingCampusSnackBarMessage);
        } else if (state is CampusDeletedState) {
          final deleteCampusSnackBarMessage =
              MySnackBar('Campus deleted.');
                    ScaffoldMessenger.of(context)
                        .showSnackBar(deleteCampusSnackBarMessage);
        }
          BlocProvider.of<CampusesBloc>(context).add(ReadAllCampusesEvent());
      },
    );
  }
}
