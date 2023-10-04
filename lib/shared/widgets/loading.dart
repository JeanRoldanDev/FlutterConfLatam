import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 35,
        height: 35,
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          backgroundColor: Colors.red,
          color: Colors.grey,
        ),
      ),
    );
  }
}
