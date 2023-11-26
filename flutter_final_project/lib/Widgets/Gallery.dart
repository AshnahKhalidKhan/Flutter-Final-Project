import 'package:flutter/material.dart';

class Gallery extends StatefulWidget 
{
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> 
{
  int NumberOfTiles = 2;

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar
      (
        leading: BackButton(),
        title: Text('Gallery'),
        actions: 
        [
          IconButton
          (
            onPressed: () 
            {
              setState(() 
              {
                if (NumberOfTiles == 2)
                {
                  NumberOfTiles = 4;
                }
                else if (NumberOfTiles == 4)
                {
                  NumberOfTiles = 2;
                }
              });
            },
            icon: Icon(Icons.grid_view_rounded)
          ),
          IconButton
          (
            icon: Icon(Icons.add_a_photo),
            onPressed: ()
            {
              showModalBottomSheet<void>
              (
                constraints: BoxConstraints
                (
                  // maxHeight: MediaQuery.of(context).size.height,
                ),
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context)
                {
                  return SizedBox
                  (
                    width: double.maxFinite,
                    child: Row
                    (
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: 
                      [
                        Column
                        IconButton
                        (
                          padding: EdgeInsets.all(30.0),
                          icon: Icon(Icons.upload_file_rounded),
                          onPressed: () {}
                        ),
                        IconButton
                        (
                          padding: EdgeInsets.all(30.0),
                          icon: Icon(Icons.camera_alt_rounded),
                          onPressed: () {}
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
        
      ),
      body: Padding
      (
        padding: EdgeInsets.all(10.0),
        child: GridView.builder
        (
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: NumberOfTiles),
          itemCount: 20,
          itemBuilder: (context, i)
          {
            return Card
            (
              color: Colors.grey,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              child: Column
              (
                children: 
                [
                  Image.asset('lib/Assets/Google Pocket App Logo.jpg')
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}