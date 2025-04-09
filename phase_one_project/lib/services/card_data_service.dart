import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/data_project_model.dart';

class CardDataService {
  Future<List<CardData>> loadJsonCardData() async {
    final String response =
        await rootBundle.loadString('lib/assets/data/data_project.json');
    final List<dynamic> data = json.decode(response);

    return data.map((json) => CardData.fromJson(json)).toList();
  }
}
