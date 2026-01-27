import 'package:flutter/material.dart';

class Chip extends StatelessWidget {
  const Chip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.backgroundColor,
    this.textColor,
  });
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color:
              backgroundColor ??
              (isSelected ? colorScheme.primary : colorScheme.surface),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? colorScheme.primary : colorScheme.outline,
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color:
                textColor ??
                (isSelected ? colorScheme.onPrimary : colorScheme.onSurface),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
