import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/data_project_model.dart';
import '../providers/card_notifier_provider.dart';
import '../routes/path_routes.dart';

class CardWidget extends ConsumerWidget {
  final CardData item;

  const CardWidget({super.key, required this.item});

  void _handleTap(BuildContext context, WidgetRef ref) {
    ref.read(cardProvider.notifier).selectCard(item.id);

    Navigator.pushNamed(
      context,
      AppPathsRoutes.details,
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: _inkWell(context, ref),
    );
  }

  InkWell _inkWell(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _handleTap(context, ref),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            _clipRRectImage(),
            const SizedBox(width: 12),
            _expandedText(),
          ],
        ),
      ),
    );
  }

  ClipRRect _clipRRectImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        item.urlImage,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
  }

  Expanded _expandedText() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
