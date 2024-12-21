import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/services/taxon_service.dart';
import 'package:flutter/material.dart';

class TaxonModelProvider extends ChangeNotifier {
  final TaxonService service = TaxonService.instance;

  List<TaxonModel> taxons = [];

  Future<void> load() async {
    await service.loadTaxon();
    await getTaxon();
    notifyListeners();
  }

  Future<void> getTaxon() async {
    taxons = await service.getAllTaxons() ?? [];
    print(taxons);
    notifyListeners();
  }

  



}
