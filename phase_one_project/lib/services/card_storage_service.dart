import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/data_project_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardStorageService {
  static final CardStorageService _instance = CardStorageService._internal();
  factory CardStorageService() => _instance;
  CardStorageService._internal();

  final List<CardData> _cards = [];
  final String _prefsKey = 'cards_data';

  List<CardData> get cards => _cards;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_prefsKey);

    if (data != null) {
      final decoded = jsonDecode(data) as List;
      _cards.clear();
      _cards.addAll(decoded.map((e) => CardData.fromJson(e)));
    } else {
      await _loadInitialData();
    }
  }

  Future<void> _loadInitialData() async {
    final jsonString =
        await rootBundle.loadString('lib/assets/data/data_project.json');
    final decoded = jsonDecode(jsonString) as List;
    _cards.addAll(decoded.map((e) => CardData.fromJson(e)));
    await _saveToPrefs();
  }

  Future<void> addCard(CardData card) async {
    _cards.add(card);
    await _saveToPrefs();
  }

  Future<void> updateCardById(String id, CardData card) async {
    final index = _cards.indexWhere((c) => c.id == id);
    if (index != -1) {
      _cards[index] = card;
      await _saveToPrefs();
    }
  }

  Future<void> deleteCardById(String id) async {
    _cards.removeWhere((c) => c.id == id);
    await _saveToPrefs();
  }

  Future<void> _saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_cards.map((e) => e.toJson()).toList());
    await prefs.setString(_prefsKey, jsonString);
  }
}
