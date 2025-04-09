import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/data_project_model.dart';
import '../providers/card_notifier_provider.dart';
import '../templates/base_template.dart';
import '../widgets/modal_widget.dart';

class DetailScreen extends ConsumerStatefulWidget {
  final String idCardSelect;

  const DetailScreen({super.key, required this.idCardSelect});

  @override
  ConsumerState<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final asyncCards = ref.watch(cardProvider);

    return asyncCards.when(
      data: (cards) => _buildData(cards),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildData(List<CardData> cards) {
    final card = cards.firstWhere(
      (c) => c.id == widget.idCardSelect,
      orElse: () => CardData(
        id: '',
        title: 'No encontrado',
        description: '',
        urlImage: '',
      ),
    );

    if (card.id.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Card no encontrada')),
      );
    }

    return _buildCardDetail(card);
  }

  Widget _buildCardDetail(CardData card) {
    return BaseTemplate(
      titleAppar: card.title,
      showLeadingBtnAppar: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardImage(card),
              _buildCardDescription(card),
              _actionsButtons(card),
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

  Row _actionsButtons(CardData card) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [_buildDeleteButton(card), _editButton(card)],
    );
  }

  Widget _buildDeleteButton(CardData card) {
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

            if (!mounted) return;

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

  ElevatedButton _editButton(CardData card) {
    return ElevatedButton(
      onPressed: () {
        debugPrint('edit ${card.id}');
      },
      child: const Text('Editar'),
    );
  }
}
