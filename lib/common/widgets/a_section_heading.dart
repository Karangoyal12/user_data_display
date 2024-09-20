import 'package:flutter/material.dart';

class ASectionHeading extends StatelessWidget {
  const ASectionHeading({super.key, required this.title, this.textColor});

  final String title;
  final Color? textColor;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }
}
