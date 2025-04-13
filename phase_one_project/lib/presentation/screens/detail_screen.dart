import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/data_project_model.dart';
import '../../utils/color_app.dart';
import '../providers/card_notifier_provider.dart';
import '../routes/path_routes.dart';
import '../templates/base_template.dart';
import '../widgets/modal_widget.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCard = ref.watch(selectedCardProvider);

    if (selectedCard == null || selectedCard.id.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Card no encontrada')),
      );
    }

    return BaseTemplate(
      titleAppar: selectedCard.title,
      showLeadingBtnAppar: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardImage(selectedCard),
              _buildCardDescription(selectedCard),
              _buildCardCategory(selectedCard),
              _actionsButtons(ref, context, selectedCard),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardImage(CardData card) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          card.urlImage,
          fit: BoxFit.cover,
          width: double.infinity,
          height: 200,
          errorBuilder: (context, error, stackTrace) {
            return const Text('No se pudo cargar la imagen');
          },
        ),
      ),
    );
  }

  Padding _buildCardDescription(CardData card) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(card.description),
    );
  }

  Padding _buildCardCategory(CardData card) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Column(
          children: [
            Text(
              'Categoría',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(card.category),
          ],
        ));
  }

  Row _actionsButtons(WidgetRef ref, BuildContext context, CardData card) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildDeleteButton(ref, context, card),
        _editButton(context, card)
      ],
    );
  }

  ElevatedButton _buildDeleteButton(
      WidgetRef ref, BuildContext context, CardData card) {
    return ElevatedButton.icon(
      onPressed: () => _handleDeletePressed(ref, context, card),
      icon: Icon(Icons.delete, color: AppColors.white),
      label: const Text('Eliminar'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.error,
        foregroundColor: AppColors.white,
      ),
    );
  }

  void _handleDeletePressed(
      WidgetRef ref, BuildContext context, CardData card) {
    final navigator = Navigator.of(context);

    ModalWidget.showConfirmation(
      context: context,
      title: 'Eliminar tarjeta',
      content: 'Estás a punto de eliminar esta tarjeta. ¿Deseas continuar?',
      confirmText: 'Eliminar',
      iconColor: AppColors.error,
      onConfirm: () async {
        await ref.read(cardProvider.notifier).deleteCard(card.id);

        if (!context.mounted) return;

        ModalWidget.showSuccess(
          context: context,
          content: 'La tarjeta se eliminó correctamente.',
          onClose: () => navigator.pop(),
        );
      },
    );
  }

  ElevatedButton _editButton(BuildContext context, CardData card) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushNamed(
          context,
          AppPathsRoutes.form,
          arguments: true,
        );
      },
      label: const Text('Editar'),
      icon: Icon(
        Icons.edit,
        color: AppColors.white,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
    );
  }
}
