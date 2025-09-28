import 'package:flutter/material.dart';

class ANumberField extends StatelessWidget {
  const ANumberField({
    super.key,
    required this.label,
    this.hint,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.min,
    this.max,
  });
  final String label;
  final String? hint;
  final int? initialValue;
  final String? Function(int?)? validator;
  final void Function(int?)? onChanged;
  final void Function(int?)? onSubmitted;
  final int? min;
  final int? max;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue?.toString(),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Este campo es obligatorio';
        }
        final number = int.tryParse(value);
        if (number == null) {
          return 'Ingresa un número válido';
        }
        if (min != null && number < min!) {
          return 'El valor debe ser mayor o igual a $min';
        }
        if (max != null && number > max!) {
          return 'El valor debe ser menor o igual a $max';
        }
        return validator?.call(number);
      },
      onChanged: (value) {
        final number = int.tryParse(value);
        onChanged?.call(number);
      },
      onFieldSubmitted: (value) {
        final number = int.tryParse(value);
        onSubmitted?.call(number);
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }
}
