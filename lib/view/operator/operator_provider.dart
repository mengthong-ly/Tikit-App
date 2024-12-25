import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/services/taxon_service.dart';
import 'package:event_with_thong/view/operator/operator_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OperatorProvider extends ChangeNotifier {
  OperatorService service = OperatorService.instance;
  late TaxonModel tempTaxon;
  TaxonService taxonService = TaxonService.instance;


  Future<String?> _getSavedImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getString('taxon1')!;
    return null;
  }
}
