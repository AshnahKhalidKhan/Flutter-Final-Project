import 'package:flutter/material.dart';

class ListTileIconTextInfo extends StatelessWidget 
{
  final IconData icon;
  final String info;

  const ListTileIconTextInfo({super.key, required this.icon, required this.info});

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
        const SizedBox(width: 10.0),
        Expanded
        (
          child: Text
          (
            info,
            style: const TextStyle
            (
              fontSize: 15.0,
            ),
          )
        )
      ],
    );
  }
}