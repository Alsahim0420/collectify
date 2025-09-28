import 'package:flutter/material.dart';

class AGap extends StatelessWidget {
  const AGap({super.key, this.width, this.height});
  const AGap.large({super.key}) : width = 24, height = 24;

  const AGap.small({super.key}) : width = 8, height = 8;
  const AGap.medium({super.key}) : width = 16, height = 16;
  const AGap.xl({super.key}) : width = 32, height = 32;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) => SizedBox(width: width, height: height);
}
