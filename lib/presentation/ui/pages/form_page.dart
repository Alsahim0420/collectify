import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collectify/domain/entities/lego_set.dart';
import 'package:collectify/presentation/state/collection/collection_bloc.dart';
import 'package:collectify/presentation/state/collection/collection_event.dart';
import 'package:collectify/presentation/ui/molecules/lego_theme_selector.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, this.existingSet});
  final LegoSet? existingSet;

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameCtrl;
  late TextEditingController _setNumberCtrl;
  String? _selectedTheme;
  late TextEditingController _piecesCtrl;
  late TextEditingController _notesCtrl;
  final TextEditingController _themeSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameCtrl = TextEditingController(text: widget.existingSet?.name ?? '');
    _setNumberCtrl = TextEditingController(
      text: widget.existingSet?.setNumber.toString() ?? '',
    );
    _selectedTheme = widget.existingSet?.theme;
    _piecesCtrl = TextEditingController(
      text: widget.existingSet?.pieces.toString() ?? '',
    );
    _notesCtrl = TextEditingController(text: widget.existingSet?.notes ?? '');
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _setNumberCtrl.dispose();
    _piecesCtrl.dispose();
    _notesCtrl.dispose();
    _themeSearchController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    // Usar una colección por defecto para LEGO
    const defaultCollectionId = 'lego-default';

    if (widget.existingSet == null) {
      context.read<CollectionBloc>().add(
        AddItemEvent(
          _nameCtrl.text,
          int.tryParse(_setNumberCtrl.text) ?? 0,
          _selectedTheme ?? '',
          int.tryParse(_piecesCtrl.text) ?? 0,
          _notesCtrl.text,
          defaultCollectionId,
        ),
      );
    } else {
      context.read<CollectionBloc>().add(
        UpdateItemEvent(
          widget.existingSet!.id,
          _nameCtrl.text,
          int.tryParse(_setNumberCtrl.text) ?? 0,
          _selectedTheme ?? '',
          int.tryParse(_piecesCtrl.text) ?? 0,
          _notesCtrl.text,
          defaultCollectionId,
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          widget.existingSet == null ? 'Agregar Set LEGO' : 'Editar Set LEGO',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(context),
              const SizedBox(height: 32),
              _buildFormFields(context),
              const SizedBox(height: 32),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.primaryContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(
            context,
          ).colorScheme.primaryContainer.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.extension,
              color: Theme.of(context).colorScheme.onPrimary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.existingSet == null
                      ? 'Nuevo Set LEGO'
                      : 'Editar Set LEGO',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.existingSet == null
                      ? 'Completa la información de tu nuevo set'
                      : 'Modifica los datos del set',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormFields(BuildContext context) {
    return Column(
      children: [
        _buildTextField(
          context,
          controller: _nameCtrl,
          label: 'Nombre del Set',
          hint: 'Ej: Millennium Falcon',
          icon: Icons.title,
          validator: (v) =>
              v == null || v.isEmpty ? 'El nombre es requerido' : null,
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                context,
                controller: _setNumberCtrl,
                label: 'Número de Set',
                hint: 'Ej: 75192',
                icon: Icons.numbers,
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildTextField(
                context,
                controller: _piecesCtrl,
                label: 'Piezas',
                hint: 'Ej: 7541',
                icon: Icons.extension,
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _buildThemeDropdown(context),
        const SizedBox(height: 20),
        _buildTextField(
          context,
          controller: _notesCtrl,
          label: 'Notas (opcional)',
          hint: 'Detalles adicionales sobre este set...',
          icon: Icons.note,
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
      ),
    );
  }

  Widget _buildThemeDropdown(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return InkWell(
      onTap: () => _showThemeSearchDialog(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Tema',
          hintText: _selectedTheme ?? 'Selecciona un tema LEGO',
          prefixIcon: const Icon(Icons.category),
          suffixIcon: const Icon(Icons.arrow_drop_down),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 2,
            ),
          ),
          filled: true,
          fillColor: colorScheme.surface,
        ),
        child: Text(
          _selectedTheme ?? '',
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }

  void _showThemeSearchDialog(BuildContext context) {
    _themeSearchController.clear();
    List<String> filteredThemes = List.from(LegoThemeSelector.legoThemes);
    String searchText = '';

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Buscar Tema LEGO'),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _themeSearchController,
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Buscar tema...',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: searchText.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _themeSearchController.clear();
                                  setDialogState(() {
                                    searchText = '';
                                    filteredThemes =
                                        List.from(LegoThemeSelector.legoThemes);
                                  });
                                },
                              )
                            : null,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        setDialogState(() {
                          searchText = value;
                          final searchQuery = value.toLowerCase();
                          filteredThemes = LegoThemeSelector.legoThemes
                              .where((theme) => theme
                                  .toLowerCase()
                                  .contains(searchQuery))
                              .toList();
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    Flexible(
                      child: SizedBox(
                        height: 300,
                        child: filteredThemes.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search_off,
                                      size: 48,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'No se encontraron temas',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurfaceVariant,
                                          ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: filteredThemes.length,
                                itemBuilder: (context, index) {
                                  final themeName = filteredThemes[index];
                                  final isSelected =
                                      _selectedTheme == themeName;
                                  return ListTile(
                                    title: Text(themeName),
                                    selected: isSelected,
                                    selectedTileColor: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    leading: isSelected
                                        ? Icon(
                                            Icons.check_circle,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          )
                                        : const Icon(Icons.circle_outlined),
                                    onTap: () {
                                      setState(() {
                                        _selectedTheme = themeName;
                                      });
                                      _themeSearchController.clear();
                                      Navigator.pop(dialogContext);
                                    },
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _themeSearchController.clear();
                    Navigator.pop(dialogContext);
                  },
                  child: const Text('Cancelar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
            label: const Text('Cancelar'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _save,
            icon: const Icon(Icons.save),
            label: Text(widget.existingSet == null ? 'Agregar' : 'Actualizar'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
