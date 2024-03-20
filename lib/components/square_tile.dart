import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final String txt;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            imagePath,
            height: 30,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            txt,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
