import 'package:event_with_thong/models/vendor.dart';
import 'package:event_with_thong/services/vendor_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class VendorProvider extends ChangeNotifier {
  final VendorService service = VendorService.instance;

  Future<List<VendorModel>> getAllVender() async {
    try {
      await service.load();
      return service.vendorData.vendors;
    } catch (e) {
      Logger().d('get all vendor success');
      return [];
    }
  }

  Future<void> updateVendor(VendorModel updatedVendor) async {
    await service.updateVendor(updatedVendor);
  }

  Future<void> addVendor(VendorModel newVendor) async {
    await service.createVendor(newVendor);
  }

  Future<void> onRemove(VendorModel vendor) async {
    await service.removeVendor(vendor);
  }

  String getVendorImageById(String id) {
    return service.vendorData.vendors.firstWhere(
      (vendor) =>  vendor.id == id
    ).profile; 
  }
}
