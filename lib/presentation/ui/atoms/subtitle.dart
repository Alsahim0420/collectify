import 'package:flutter/material.dart';

class Subtitle extends StatelessWidget {
  const Subtitle(this.text, {super.key, this.color, this.textAlign});
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
    textAlign: textAlign,
  );
}
