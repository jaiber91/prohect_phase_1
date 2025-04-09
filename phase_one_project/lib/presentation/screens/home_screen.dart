import 'package:flutter/material.dart';
import '../../models/data_project_model.dart';
import '../../services/card_data_service.dart';
import '../templates/base_template.dart';
import '../widgets/card_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CardDataService _cardDataService = CardDataService();

  @override
  Widget build(BuildContext context) {
    return BaseTemplate(
      titleAppar: 'Home screen page',
      showLeadingBtnAppar: false,
      body: _builderListCard(),
    );
  }

  FutureBuilder _builderListCard() {
    return FutureBuilder<List<CardData>>(
      future: _cardDataService.loadJsonCardData(),
      builder: (context, snapshot) {
        return _switchSnapshot(snapshot);
      },
    );
  }

  Widget _switchSnapshot(AsyncSnapshot<List<CardData>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    }

    if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    }

    if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return const Center(child: Text('No hay datos disponibles.'));
    }

    return _listCard(snapshot.data!);
  }

  ListView _listCard(List<CardData> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CardWidget(item: items[index]),
        );
      },
    );
  }
}
