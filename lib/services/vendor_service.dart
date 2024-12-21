import 'package:event_with_thong/database/taxonomies_database.dart';
import 'package:event_with_thong/models/vendor.dart';
import 'package:event_with_thong/services/base_service.dart';
import 'package:logger/web.dart';

class VendorService extends BaseService {
  VendorService._privateInstance();
  static final VendorService _instance = VendorService._privateInstance();
  static VendorService get instance => _instance;
  final VendorDatabase vendorData = VendorDatabase.instance;

  int get autoGenerateId => vendorData.vendors.length + 1;

  Future<void> load() async {
    try {
      if (await checkBox('vendor')) {
        final mybox = await getBox<VendorModel>('vendor');
        vendorData.vendors = mybox.values.toList();
      } else {
        final mybox = await getBox<VendorModel>('vendor');
        await mybox.putAll(vendorData.vendors.asMap());
      }
    } catch (e) {
      Logger().d('vendor load: $e');
    }
  }

  Future<void> createVendor(VendorModel newVendor) async {
    try {
      final mybox = await getBox<VendorModel>('vendor');
      await mybox.put(autoGenerateId, newVendor);
      await load();
    } catch (e) {
      Logger().d('create fails: $e');
    }
  }

  Future<void> updateVendor(VendorModel updatedVendor) async {
    try {
      final mybox = await getBox<VendorModel>('vendor');
      final index = mybox.values.toList().indexWhere((vendor) {
        return vendor.id == updatedVendor.id;
      });

      await mybox.put(index, updatedVendor);
      await load();
    } catch (e) {
      Logger().d('update fails: $e');
    }
  }
  Future<void> removeVendor(VendorModel updatedVendor) async {
    try {
      final mybox = await getBox<VendorModel>('vendor');
      final index = mybox.values.toList().indexWhere((vendor) {
        return vendor.id == updatedVendor.id;
      });

      await mybox.deleteAt(index);
      await load();
    } catch (e) {
      Logger().d('update fails: $e');
    }
  }
}
