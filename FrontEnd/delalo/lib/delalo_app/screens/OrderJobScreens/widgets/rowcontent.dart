import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowContent extends StatelessWidget {
  const RowContent({Key? key, this.content}) : super(key: key);

  final String? content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        (() {
          if (content != null) {
            return content!;
          }

          return '-';
        })(),
        style: TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}
