import 'package:flutter/material.dart';

class BottomSheetIconTextInfo extends StatelessWidget 
{
  final IconData icon;
  final String info;

  const BottomSheetIconTextInfo({super.key, required this.icon, required this.info});

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
        const SizedBox(width: 10.0),
        Expanded
        (
          child: Text
          (
            info,
            style: const TextStyle
            (
              fontSize: 20.0,
            ),
          )
        )
      ],
    );
  }
}