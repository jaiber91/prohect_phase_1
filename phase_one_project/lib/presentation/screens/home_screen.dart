import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/card_notifier_provider.dart';
import '../templates/base_template.dart';
import '../widgets/card_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cardAsync = ref.watch(cardProvider);

    return BaseTemplate(
      titleAppar: 'Home screen page',
      showLeadingBtnAppar: false,
      body: cardAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (cards) {
          if (cards.isEmpty) {
            return const Center(child: Text('No hay datos disponibles.'));
          }

          return ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CardWidget(item: cards[index]),
              );
            },
          );
        },
      ),
    );
  }
}
