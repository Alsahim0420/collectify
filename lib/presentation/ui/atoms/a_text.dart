import 'package:flutter/material.dart';

class Title extends StatelessWidget {
  const Title(this.text, {super.key, this.color, this.textAlign});
  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
    textAlign: textAlign,
  );
}

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
