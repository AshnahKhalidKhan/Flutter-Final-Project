import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegistrationsList extends StatelessWidget 
{
  const RegistrationsList({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        title: const Padding(padding: EdgeInsets.all(10.0), child: Text('Registrations')),
        actions: 
        [
          Padding
          (
            padding: const EdgeInsets.all(10.0),
            child: IconButton
            (
              onPressed: () 
              {
              },
              alignment: Alignment.center,
              // padding: const EdgeInsets.all(10.0),
              iconSize: 30.0,
              icon: Icon(Icons.add_rounded)
            ),
          ),
        ],
      ),
      body: Padding
      (
        padding: EdgeInsets.all(10.0),
        child: ListView.builder
        (
          itemCount: 10,
          itemBuilder: (context, i)
          {
            return Padding
            (
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ListTile
              (
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                tileColor: Colors.yellow,
                style: ListTileStyle.list,
                title: Text('30characterslongnameofperso...'),
                subtitle: Text('40characterslongemailofperson323436...'),
                trailing: Icon(Icons.expand_more),
                onTap: () 
                {
                  showModalBottomSheet<void>
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
                            tileColor: Colors.blue,
                            subtitle: Padding
                            (
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Column
                              (
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: 
                                [
                                  Row
                                  (
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: 
                                    [
                                      // Icon(Icons.delete, size: 30.0),
                                      // SizedBox(width: 30.0),
                                      // Icon(Icons.edit, size: 30.0)
                                      IconButton
                                      (
                                        padding: EdgeInsets.all(20.0),
                                        onPressed: () {print('Button');}, icon: Icon(Icons.delete, size: 30.0),
                                      ),
                                      IconButton
                                      (
                                        padding: EdgeInsets.only(top: 20.0, bottom: 20.0, left: 20.0),
                                        onPressed: () {print('edit Button');}, icon: Icon(Icons.edit, size: 30.0),
                                      )
                                    ],
                                  ),
                                  Row
                                  (
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: 
                                    [
                                      Icon(Icons.person),
                                      SizedBox(width: 10.0),
                                      Text('30characterslongnameofperso...'),
                                    ],
                                  ),
                                  Row
                                  (
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: 
                                    [
                                      Icon(Icons.email),
                                      SizedBox(width: 10.0),
                                      Text('40characterslongemailofpersonnnnnn...'),
                                    ],
                                  ),
                                  Row
                                  (
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: 
                                    [
                                      Icon(CupertinoIcons.creditcard),
                                      SizedBox(width: 10.0),
                                      Text('42501-2868274-6')
                                    ],
                                  ),
                                  Row
                                  (
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: 
                                    [
                                      Icon(Icons.call_rounded),
                                      SizedBox(width: 10.0),
                                      Text('40characterslongemailofpersonnnnnn...'),
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
                },
              ),
            );
          }
        ),
      )
    );
  }
}