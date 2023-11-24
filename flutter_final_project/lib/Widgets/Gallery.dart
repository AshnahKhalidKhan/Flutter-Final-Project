import 'package:flutter/material.dart';

class Gallery extends StatefulWidget 
{
  const Gallery({super.key});

  @override
  State<Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<Gallery> 
{
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
            onPressed: () {},
            icon: Icon(Icons.camera_alt_rounded)
          )
        ],
        
      ),
      body: Padding
      (
        padding: EdgeInsets.all(10.0),
        child: GridView.builder
        (
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
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