import 'package:flutter/material.dart';

class UserMenu extends StatelessWidget {
  const UserMenu({super.key, required this.title, this.value});
  final String? value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title,
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis),
        ),
        Expanded(
          child: Text(value ?? " ",
              style: Theme.of(context).textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis),
        )
      ],
    );
  }
}
