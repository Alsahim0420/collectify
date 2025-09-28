import 'package:flutter/material.dart' hide TextField;
import 'package:collectify/presentation/ui/atoms/a_text_field.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    this.initialValue,
    this.onChanged,
    this.onSubmitted,
    this.onClear,
  });
  final String? initialValue;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return FieldText(
      label: 'Buscar en tu colección',
      hint: 'Escribe el nombre o categoría...',
      initialValue: initialValue,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      prefixIcon: const Icon(Icons.search),
      suffixIcon: (initialValue?.isNotEmpty ?? false)
          ? IconButton(icon: const Icon(Icons.clear), onPressed: onClear)
          : null,
    );
  }
}
