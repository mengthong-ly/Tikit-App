import 'package:event_with_thong/database/taxonomies_database.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/services/base_service.dart';
import 'package:logger/web.dart';

class TaxonService extends BaseService {
  TaxonService._privateConstructor();
  static final TaxonService _instance = TaxonService._privateConstructor();
  static TaxonService get instance => _instance;
  final TaxonDatabase taxonData = TaxonDatabase.instance;

  Future<void> loadTaxon() async {
    try {
      if (await checkBox('taxon')) {
        final myBox = await getBox<TaxonModel>('taxon');
        taxonData.taxons = myBox.values.toList();
        Logger().d('-------------------Hive--------------------------');
      } else {
        final myBox = await getBox<TaxonModel>('taxon');
        await myBox.putAll(taxonData.taxons.asMap());
        Logger().d('---------------------------------------------');
      }
    } catch (e) {
      Logger().d('laodTaxon: $e');
    }
  }

  Future<List<TaxonModel>?> getAllTaxons() async {
    try {
      final myBox = await getBox<TaxonModel>('taxon');
      taxonData.taxons = myBox.values.toList();
      return taxonData.taxons;
    } catch (e) {
      Logger().d('getAllTaxon: $e');
      return null;
    }
  }

  TaxonModel? getTaxonById(String id) {
    try {
      return taxonData.taxons.firstWhere((taxon) => taxon.id == id);
    } catch (e) {
      Logger().d('getTaxonById: $e');
      return null;
    }
  }

  TaxonModel? getTaxonByVendorId(String vendorId) {
    try {
      return taxonData.taxons.firstWhere((taxon) => taxon.vendorId == vendorId);
    } catch (e) {
      Logger().d('getTaxonByVendorId: $e');
      return null;
    }
  }

  Future<bool> addTaxon(TaxonModel taxon) async {
    taxonData.taxons.add(taxon);
    try {
      final myBox = await getBox<TaxonModel>('taxon');
      await myBox.put(int.parse(taxon.id), taxon);
      await loadTaxon();
      return true;
    } catch (e) {
      Logger().d('addTaxon: $e');
      return false;
    }
  }

  Future<bool> removeTaxonById(String id) async {
    final index = taxonData.taxons.indexWhere((taxon) => taxon.id == id);
    if (index == -1) return false;
    try {
      final myBox = await getBox<TaxonModel>('taxon');
      await myBox.deleteAt(index);
      await loadTaxon();
      return true;
    } catch (e) {
      Logger().d('removeTaxonById: $e');
      return false;
    }
  }

  Future<bool> removeTaxonByVendorId(String id) async {
    if (taxonData.taxons.indexWhere((model) => model.id == id) == -1) {
      return false;
    }
    try {
      taxonData.taxons.removeWhere((taxon) => taxon.vendorId == id);
      final myBox = await getBox<TaxonModel>('taxon');
      await myBox.putAll(taxonData.taxons.asMap());
      await loadTaxon();
      return true;
    } catch (e) {
      Logger().d('removeTaxonById: $e');
      return false;
    }
  }

  Future<bool> updateTaxon(TaxonModel taxon) async {
    final index = taxonData.taxons.indexWhere((model) => model.id == taxon.id);
    if (index == -1) {
      return false;
    }
    try {
      final myBox = await getBox<TaxonModel>('taxon');
      await myBox.put(index, taxon);
      await loadTaxon();
      return true;
    } catch (e) {
      Logger().d('updateTaxon: $e');
      return false;
    }
  }


  // void connectProductWithTaxon(TaxonModel taxon, ProductModel model) async {
  //   try {
  //     await productTaxonService.addProductTaxon(taxon, model);
  //     Logger().d('Successfully added product taxon');
  //   } catch (e) {
  //     Logger().d('add product taxon error: $e');
  //   }
  // }
}
