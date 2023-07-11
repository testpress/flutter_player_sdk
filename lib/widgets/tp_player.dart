import 'package:flutter/material.dart';

class TPPlayer extends StatelessWidget {
  const TPPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Player Widget",
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
    );
  }
}