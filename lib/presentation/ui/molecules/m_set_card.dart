import 'package:flutter/material.dart' hide Title, Chip;
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/presentation/ui/atoms/a_text.dart';
import 'package:collectify/presentation/ui/atoms/a_chip.dart';

class SetCard extends StatelessWidget {
  const SetCard({
    super.key,
    required this.set,
    required this.onTap,
    this.onEdit,
    this.onDelete,
  });
  final LegoSet set;
  final VoidCallback onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey[50]!],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 0,
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header con icono y menú
                Row(
                  children: [
                    // Icono LEGO con gradiente
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).colorScheme.primary,
                            Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.extension,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Título y número
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Title(set.name, color: Colors.grey[800]),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Subtitle(
                              '#${set.setNumber}',
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Menú de opciones
                    if (onEdit != null || onDelete != null)
                      DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: PopupMenuButton<String>(
                          icon: Icon(Icons.more_vert, color: Colors.grey[600]),
                          onSelected: (value) {
                            switch (value) {
                              case 'edit':
                                onEdit?.call();
                                break;
                              case 'delete':
                                onDelete?.call();
                                break;
                            }
                          },
                          itemBuilder: (context) => [
                            if (onEdit != null)
                              const PopupMenuItem(
                                value: 'edit',
                                child: Row(
                                  children: [
                                    Icon(Icons.edit, color: Colors.blue),
                                    SizedBox(width: 12),
                                    Text('Editar'),
                                  ],
                                ),
                              ),
                            if (onDelete != null)
                              const PopupMenuItem(
                                value: 'delete',
                                child: Row(
                                  children: [
                                    Icon(Icons.delete, color: Colors.red),
                                    SizedBox(width: 12),
                                    Text(
                                      'Eliminar',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                // Chips de información
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      label: set.theme,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.secondaryContainer,
                      textColor: Theme.of(
                        context,
                      ).colorScheme.onSecondaryContainer,
                    ),
                    Chip(
                      label: '${set.pieces} piezas',
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.tertiaryContainer,
                      textColor: Theme.of(
                        context,
                      ).colorScheme.onTertiaryContainer,
                    ),
                    Chip(
                      label: _formatDate(set.acquiredAt),
                      backgroundColor: Colors.grey[100],
                      textColor: Colors.grey[700],
                    ),
                  ],
                ),
                // Notas si existen
                if (set.notes.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.blue[200]!, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.note, color: Colors.blue[600], size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Body(set.notes, color: Colors.blue[800]),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                // Indicador de acción
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Body(
                            'Ver detalles',
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 12,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Hoy';
    } else if (difference.inDays == 1) {
      return 'Ayer';
    } else if (difference.inDays < 7) {
      return 'Hace ${difference.inDays} días';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
