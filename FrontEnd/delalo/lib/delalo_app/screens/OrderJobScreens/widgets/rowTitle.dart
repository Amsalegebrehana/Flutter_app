import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowTitle extends StatelessWidget {
  const RowTitle({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}
