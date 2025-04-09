import 'package:flutter/material.dart';
import '../../models/data_project_model.dart';
import '../routes/path_routes.dart';

class CardWidget extends StatelessWidget {
  final CardData item;

  const CardWidget({super.key, required this.item});

  void _handleTap(BuildContext context) {
    Navigator.pushNamed(
      context,
      AppPathsRoutes.details,
      arguments: item.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: _inkWell(context),
    );
  }

  InkWell _inkWell(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => _handleTap(context),
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
