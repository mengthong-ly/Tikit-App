import 'package:event_with_thong/database/database.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/models/taxon_type.dart';
import 'package:event_with_thong/services/base_service.dart';
import 'package:logger/web.dart';

class TaxonService extends BaseService {
  TaxonService._privateConstructor();
  static final TaxonService _instance = TaxonService._privateConstructor();
  static TaxonService get instance => _instance;
  final TaxonDatabase taxonData = TaxonDatabase.instance;
  // ClassificationService classificationService = ClassificationService.instance;

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
      return myBox.values.toList();
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
      await myBox.add(taxon);
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

  Future<List<TaxonModel>> getFeatureTaxon() async {
    final myBox = await getBox<TaxonModel>('taxon');
    return myBox.values.toList().where(
      (taxon) {
        return taxon.isFeatured == true;
      },
    ).toList();
  }

  List<TaxonModel> getTaxonByFilterByType(TaxonType taxonType) {
    return taxonData.taxons.toList().where(
      (taxon) {
        return taxon.taxonType == taxonType;
      },
    ).toList();
  }
}
