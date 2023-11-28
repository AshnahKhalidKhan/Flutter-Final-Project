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
          // IconButton
          // (
          //   icon: Icon(Icons.add_a_photo),
          //   onPressed: ()
          //   {
          //     showModalBottomSheet<void>
          //     (
          //       constraints: BoxConstraints
          //       (
          //         maxHeight: MediaQuery.of(context).size.height,
          //         // minHeight: MediaQuery.of(context).size.height,
          //       ),
          //       isScrollControlled: true,
          //       context: context,
          //       builder: (BuildContext context)
          //       {
          //         return SizedBox
          //         (
          //           width: double.infinity,
          //           child: Wrap
          //           (
          //             children: 
          //             [
          //               Row
          //               (
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: 
          //                 [
          //                   Padding
          //                   (
          //                     padding: EdgeInsets.all(30.0),
          //                     child: Column
          //                     (
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: 
          //                       [
          //                         IconButton.outlined
          //                         (
          //                           icon: Icon(Icons.upload_rounded, size: 30.0),
          //                           padding: EdgeInsets.all(20.0),
          //                           onPressed: () {}
          //                         ),
          //                         SizedBox(height: 10.0),
          //                         Text('Upload file')
          //                       ],
          //                     ),
          //                   ),
          //                   // SizedBox(width: 30.0),
          //                   Padding
          //                   (
          //                     padding: EdgeInsets.all(30.0),
          //                     child: Column
          //                     (
          //                       crossAxisAlignment: CrossAxisAlignment.center,
          //                       children: 
          //                       [
          //                         IconButton.outlined
          //                         (
          //                           icon: Icon(Icons.camera_alt_rounded, size: 30.0),
          //                           padding: EdgeInsets.all(20.0),
          //                           onPressed: () {}
          //                         ),
          //                         SizedBox(height: 10.0),
          //                         Text('Camera')
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             ]
          //           ),
          //         );
          //       },
          //     );
          //   },
          // ),
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
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
              child: Image.asset
              (
                'lib/Assets/Google Pocket App Logo.jpg',
                fit: BoxFit.contain,
              ),
            );
          }
        ),
      ),
      floatingActionButton: FloatingActionButton.large
      (
        onPressed: () {},
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        child: IconButton
        (
          icon: Icon(Icons.add_a_photo),
          padding: EdgeInsets.all(30.0),
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
                          Padding
                          (
                            padding: EdgeInsets.all(30.0),
                            child: Column
                            (
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: 
                              [
                                IconButton.outlined
                                (
                                  icon: Icon(Icons.upload_rounded, size: 30.0),
                                  padding: EdgeInsets.all(20.0),
                                  onPressed: () {}
                                ),
                                SizedBox(height: 10.0),
                                Text('Upload file')
                              ],
                            ),
                          ),
                          // SizedBox(width: 30.0),
                          Padding
                          (
                            padding: EdgeInsets.all(30.0),
                            child: Column
                            (
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: 
                              [
                                IconButton.outlined
                                (
                                  icon: Icon(Icons.camera_alt_rounded, size: 30.0),
                                  padding: EdgeInsets.all(20.0),
                                  onPressed: () {}
                                ),
                                SizedBox(height: 10.0),
                                Text('Camera')
                              ],
                            ),
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
      ),
    );
  }
}