import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../models/data_project_model.dart';
import '../providers/card_notifier_provider.dart';
import '../routes/path_routes.dart';
import '../templates/base_template.dart';
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
    _urlCtrl = TextEditingController(text: selectedCard?.urlImage ?? '');
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
          _buttonForm(),
        ],
      ),
    );
  }

  TextFieldWidget _titleCard() {
    return TextFieldWidget(
      controller: _titleCtrl,
      label: 'Título',
      validator: (value) =>
          value == null || value.isEmpty ? 'El título es obligatorio' : null,
    );
  }

  TextFieldWidget _descriptionCard() {
    return TextFieldWidget(
      controller: _descCtrl,
      label: 'Descripción',
      maxLines: 3,
      validator: (value) => value == null || value.isEmpty
          ? 'La descripción es obligatoria'
          : null,
    );
  }

  TextFieldWidget _urlImage() {
    return TextFieldWidget(
      controller: _urlCtrl,
      label: 'URL de imagen',
      validator: (value) =>
          value == null || value.isEmpty ? 'La URL es obligatoria' : null,
    );
  }

  ElevatedButton _buttonForm() {
    return ElevatedButton(
      onPressed: _saveForm,
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
    );

    final notifier = ref.read(cardProvider.notifier);

    if (widget.isEdit) {
      ModalWidget.showConfirmation(
        context: context,
        title: 'Actualizar tarjeta',
        content: '¿Deseas guardar los cambios realizados?',
        confirmText: 'Actualizar',
        iconColor: Colors.blue,
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
