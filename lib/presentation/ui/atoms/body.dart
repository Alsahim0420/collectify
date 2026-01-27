import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body(this.text, {super.key, this.color, this.textAlign});
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
    textAlign: textAlign,
  );
}
