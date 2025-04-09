import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/data_project_model.dart';
import '../../services/card_storage_service.dart';

final cardProvider = AsyncNotifierProvider<CardNotifier, List<CardData>>(() {
  return CardNotifier();
});

class CardNotifier extends AsyncNotifier<List<CardData>> {
  @override
  Future<List<CardData>> build() async {
    await CardStorageService().init();
    return CardStorageService().cards;
  }

  Future<void> deleteCard(String id) async {
    await CardStorageService().deleteCardById(id);
    state = AsyncValue.data([...CardStorageService().cards]);
  }

  Future<void> updateCard(CardData updatedCard) async {
    await CardStorageService().updateCardById(updatedCard.id, updatedCard);
    state = AsyncValue.data([...CardStorageService().cards]);
  }

  Future<void> addCard(CardData card) async {
    await CardStorageService().addCard(card);
    state = AsyncValue.data([...CardStorageService().cards]);
  }
}
