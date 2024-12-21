import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/services/taxon_service.dart';
import 'package:event_with_thong/view/operator/operator_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OperatorProvider extends ChangeNotifier {
  OperatorService service = OperatorService.instance;
  late TaxonModel tempTaxon;
  TaxonService taxonService = TaxonService.instance;

  Future<void> contructTaxonModel(
      String name, String description, String vendorId) async {
    String id = (service.taxonDatabase.taxons.length + 1).toString();
    tempTaxon = TaxonModel(
        id: id,
        name: name,
        slug: name,
        description: description,
        vendorId: vendorId,
        image: 'GetFromSharedPreferences');

    await taxonService.addTaxon(tempTaxon);
  }

  Future<String?> _getSavedImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('taxon1')!;
    return null;
  }
}
