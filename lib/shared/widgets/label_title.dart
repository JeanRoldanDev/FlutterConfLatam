import 'package:flutter/material.dart';

class LabelTitle extends StatelessWidget {
  const LabelTitle(
    this.text, {
    this.subText = '',
    super.key,
  });

  final String subText;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            subText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w100,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
