import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/data_project_model.dart';
import '../../utils/color_app.dart';
import '../../utils/form_validators.dart';
import '../providers/card_notifier_provider.dart';
import '../routes/path_routes.dart';
import '../templates/base_template.dart';
import '../widgets/dropdown_field_widget.dart';
import '../widgets/modal_widget.dart';
import '../widgets/text_field_widget.dart';

class FormScreen extends ConsumerStatefulWidget {
  final bool isEdit;

  const FormScreen({super.key, required this.isEdit});

  @override
  ConsumerState<FormScreen> createState() => _CardFormScreenState();
}

class _CardFormScreenState extends ConsumerState<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleCtrl;
  late TextEditingController _descCtrl;
  late TextEditingController _urlCtrl;
  String? _selectedCategory;
  String urlImage = 'https://picsum.photos/200';
  final List<String> _categories = ['Profesional', 'Aficionado', 'Estudiante'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.isEdit) {
        ref.read(selectedCardProvider.notifier).state = null;
      }
    });

    final selectedCard = widget.isEdit ? ref.read(selectedCardProvider) : null;

    _titleCtrl = TextEditingController(text: selectedCard?.title ?? '');
    _descCtrl = TextEditingController(text: selectedCard?.description ?? '');
    _urlCtrl = TextEditingController(text: selectedCard?.urlImage ?? urlImage);
    _selectedCategory = selectedCard?.category;
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _urlCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      titleAppar: widget.isEdit ? 'Editar Tarjeta' : 'Nueva Tarjeta',
      showLeadingBtnAppar: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _formListField(),
        ),
      ),
    );
  }

  Form _formListField() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: ListView(
        children: [
          _titleCard(),
          const SizedBox(height: 12),
          _descriptionCard(),
          const SizedBox(height: 12),
          _urlImage(),
          const SizedBox(height: 24),
          _dropDownFiel(),
          const SizedBox(
            height: 24,
          ),
          _buttonForm(),
        ],
      ),
    );
  }

  TextFieldWidget _titleCard() {
    return TextFieldWidget(
      controller: _titleCtrl,
      label: 'Título',
      validator: (value) => FormValidators.combined(
        value: value,
        fieldName: 'El título',
        minLength: 3,
      ),
      maxLength: 100,
    );
  }

  TextFieldWidget _descriptionCard() {
    return TextFieldWidget(
      controller: _descCtrl,
      label: 'Descripción',
      maxLines: 4,
      validator: (value) => FormValidators.combined(
        value: value,
        fieldName: 'La descripción',
        minLength: 3,
      ),
      maxLength: 500,
    );
  }

  TextFieldWidget _urlImage() {
    return TextFieldWidget(
      controller: _urlCtrl,
      enabled: false,
      label: 'URL de imagen',
    );
  }

  DropdownFieldWidget<String> _dropDownFiel() {
    return DropdownFieldWidget<String>(
      label: 'Categoría',
      value: _selectedCategory,
      items: _categories
          .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
      },
      validator: (value) =>
          value == null || value.isEmpty ? 'La categoría es obligatoria' : null,
    );
  }

  ElevatedButton _buttonForm() {
    return ElevatedButton(
      onPressed: _saveForm,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      child: Text(widget.isEdit ? 'Actualizar' : 'Guardar'),
    );
  }

  Future<void> _saveForm() async {
    if (!_formKey.currentState!.validate()) return;

    final selectedCard = ref.read(selectedCardProvider);
    final newCard = CardData(
      id: selectedCard?.id ?? const Uuid().v4(),
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      urlImage: _urlCtrl.text.trim(),
      category: _selectedCategory!.trim(),
    );

    final notifier = ref.read(cardProvider.notifier);

    if (widget.isEdit) {
      ModalWidget.showConfirmation(
        context: context,
        title: 'Actualizar tarjeta',
        content: '¿Deseas guardar los cambios realizados?',
        confirmText: 'Actualizar',
        iconColor: AppColors.warning,
        onConfirm: () async {
          await notifier.updateCard(newCard);
          if (!mounted) return;

          ModalWidget.showSuccess(
            context: context,
            content: 'La tarjeta se actualizó correctamente.',
            onClose: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppPathsRoutes.home,
                (route) => false,
              );
            },
          );
        },
      );
    } else {
      await notifier.addCard(newCard);
      if (!mounted) return;

      ModalWidget.showSuccess(
        context: context,
        content: 'La tarjeta se guardó correctamente.',
        onClose: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppPathsRoutes.home,
            (route) => false,
          );
        },
      );
    }
  }
}
