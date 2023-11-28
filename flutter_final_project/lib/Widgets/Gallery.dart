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
                  maxHeight: MediaQuery.of(context).size.height,
                  // minHeight: MediaQuery.of(context).size.height,
                ),
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context)
                {
                  return SizedBox
                  (
                    width: double.infinity,
                    child: Wrap
                    (
                      children: 
                      [
                        Row
                        (
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: 
                          [
                            Column
                            (
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: 
                              [
                                IconButton
                                (
                                  icon: Icon(Icons.file_upload_rounded),
                                  onPressed: () {}
                                ),
                                Text('Upload file')
                              ],
                            ),
                            SizedBox(width: 30.0),
                            Column
                            (
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: 
                              [
                                IconButton
                                (
                                  icon: Icon(Icons.camera_alt_rounded),
                                  style: ButtonStyle
                                  (
                                    shape: MaterialStateOutlinedBorder(),
                                  ),
                                  onPressed: () {}
                                ),
                                Text('Camera'),
                              ],
                            ),
                          ],
                        ),
                      ]
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