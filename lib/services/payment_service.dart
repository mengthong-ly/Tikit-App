import 'package:event_with_thong/database/database.dart';
import 'package:event_with_thong/models/payment.dart';
import 'package:event_with_thong/services/base_service.dart';
import 'package:logger/web.dart';

class PaymentService extends BaseService {
  PaymentService._privateInstance();
  static final PaymentService _instance = PaymentService._privateInstance();
  static PaymentService get instance => _instance;

  PaymentDatabase paymentData = PaymentDatabase.instance;

  Future<void> loadAllPayment() async {
    try {
      if (await checkBox('payment')) {
        final mybox = await getBox<PaymentModel>('payment');
        paymentData.payments = mybox.values.toList();
      } else {
        final mybox = await getBox<PaymentModel>('payment');
        await mybox.putAll(paymentData.payments.asMap());
      }
    } catch (e) {
      Logger().d('Load payment fail: $e ');
    }
  }

  Future<void> addPayment(PaymentModel payment) async {
    try {
      if (await checkBox('payment')) {
        final mybox = await getBox<PaymentModel>('payment');
        await mybox.add(payment);
        await loadAllPayment();
        Logger().d("payment add success");
      }
    } catch (e) {
      Logger().d('Add payment fail: $e ');
    }
  }

  List<PaymentModel> filtherPaymentByUserId(String userId) {
    List<PaymentModel> tempList = [];
    try {
      tempList = paymentData.payments
          .where((payment) => payment.userId == userId)
          .toList();
      Logger().d('user');
    } catch (e) {
      Logger().d('filther fail: $e');
    }
    return tempList;
  }

  PaymentModel? getPaymentByOrderId(String orderId) {
    PaymentModel? tempModel;
    try {
      tempModel = paymentData.payments
          .firstWhere((payment) => payment.orderId == orderId);
      Logger().d('get success');
    } catch (e) {
      Logger().d('filther fail: $e');
      tempModel = null;
    }
    return tempModel;
  }

  PaymentModel? getPaymentById(String paymentId) {
    PaymentModel? tempModel;
    try {
      tempModel = paymentData.payments
          .firstWhere((payment) => payment.orderId == paymentId);
      Logger().d('get success');
    } catch (e) {
      Logger().d('filther fail: $e');
      tempModel = null;
    }
    return tempModel;
  }

  // PaymentModel? fetchAllPaymentById(String paymentId) {
  //   PaymentModel? tempModel;
  //   try {
  //     tempModel = paymentData.payments
  //         .firstWhere((payment) => payment.orderId == paymentId);
  //     Logger().d('get success');
  //   } catch (e) {
  //     Logger().d('filther fail: $e');
  //     tempModel = null;
  //   }
  //   return tempModel;
  // }
}
