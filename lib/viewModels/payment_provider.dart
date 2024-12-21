import 'package:event_with_thong/database/taxonomies_database.dart';
import 'package:event_with_thong/models/payment.dart';
import 'package:event_with_thong/services/payment_service.dart';
import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentService service = PaymentService.instance;
  PaymentDatabase paymentData = PaymentDatabase.instance;

  Future<void> load() async {
    await service.loadAllPayment();
    notifyListeners();
  }

  List<PaymentModel> getAllPayment() {
    return paymentData.payments;
  }
}
