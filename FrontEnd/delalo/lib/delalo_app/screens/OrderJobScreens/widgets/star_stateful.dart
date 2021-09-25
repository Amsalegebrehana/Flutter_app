import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StarStateful extends StatefulWidget {
  final Color starColor;
  final int count;

  const StarStateful({
    required this.starColor,
    required this.count,
  });

  @override
  _StarStatefulState createState() {
    return _StarStatefulState();
  }
}

class _StarStatefulState extends State<StarStateful> {
  late Color starColor;
  late int count;
  bool selected = false;

  @override
  void initState() {
    starColor = widget.starColor;
    count = widget.count;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (selected) {
                count--;
              } else {
                count++;
              }

              selected = !selected;
            });
          },
          child: Icon(
            selected ? Icons.star : Icons.star_outline,
            color: starColor,
          ),
        ),
        Text("$count"),
      ],
    );
  }
}
