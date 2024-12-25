import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/models/taxon_type.dart';
import 'package:event_with_thong/services/classification_service.dart';
import 'package:event_with_thong/services/taxon_service.dart';
import 'package:flutter/material.dart';

class TaxonModelProvider extends ChangeNotifier {
  final TaxonService service = TaxonService.instance;
  final ClassificationService classificationService =
      ClassificationService.instance;
  List<TaxonModel> _featureTaxons = [];
  final List<TaxonModel> _wishTaxons = [];

  List<TaxonModel> get featureTaxons => _featureTaxons;
  List<TaxonModel> get wishTaxons => _wishTaxons;

  Future<void> load() async {
    await service.loadTaxon();
    await getAllTaxon();
    await getAllFeaturedTaxon();
    notifyListeners();
  }

  Future<List<TaxonModel>> getAllTaxon() async {
    return await service.getAllTaxons() ?? [];
  }

  Future<void> getAllFeaturedTaxon() async {
    _featureTaxons = await service.getFeatureTaxon();
  }

  List<TaxonModel> getFilteredTaxon(TaxonType type) {
    return service.getTaxonByFilterByType(type);
  }

  Future<void> contructTaxonModel(String name, String description,
      String vendorId, TaxonType type, bool isFeature) async {
    String id = (service.taxonData.taxons.length + 1).toString();
    final TaxonModel tempTaxon = TaxonModel(
        id: id,
        name: name,
        slug: name,
        description: description,
        vendorId: vendorId,
        image: '',
        taxonType: type,
        isFeatured: isFeature);

    await service.addTaxon(tempTaxon);
  }

  Future<void> removeTaxonById(String id) async {
    await service.removeTaxonById(id);
    await classificationService.removeProductTaxonByTaxonId(id);
  }
}
