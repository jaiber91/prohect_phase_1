import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/data_project_model.dart';
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

  Widget _buildCardDescription(CardData card) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(card.description),
    );
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

  Widget _buildDeleteButton(
      WidgetRef ref, BuildContext context, CardData card) {
    return ElevatedButton(
      onPressed: () {
        final navigator = Navigator.of(context);

        ModalWidget.showConfirmation(
          context: context,
          title: 'Eliminar tarjeta',
          content: 'Estás a punto de eliminar esta tarjeta. ¿Deseas continuar?',
          confirmText: 'Eliminar',
          iconColor: Colors.red,
          onConfirm: () async {
            await ref.read(cardProvider.notifier).deleteCard(card.id);

            if (!context.mounted) return;

            ModalWidget.showSuccess(
              context: context,
              content: 'La tarjeta se eliminó correctamente.',
              onClose: () {
                navigator.pop();
              },
            );
          },
        );
      },
      child: const Text('Eliminar'),
    );
  }

  ElevatedButton _editButton(BuildContext context, CardData card) {
    return ElevatedButton(
      onPressed: () {
        debugPrint('edit ${card.id}');
        Navigator.pushNamed(
          context,
          AppPathsRoutes.form,
          arguments: true,
        );
      },
      child: const Text('Editar'),
    );
  }
}
