import 'package:event_with_thong/database/database.dart';
import 'package:event_with_thong/models/taxon.dart';

class OperatorService {
  OperatorService._privateInstance();
  static final OperatorService _instance = OperatorService._privateInstance();
  static OperatorService get instance => _instance;

  UserDatabase userDatabase = UserDatabase.instance;
  VendorDatabase vendorDatabase = VendorDatabase.instance;
  TaxonDatabase taxonDatabase = TaxonDatabase.instance;
  StockDatabase stockDatabase = StockDatabase.instance;
  OrderDatabase orderDatabase = OrderDatabase.instance;
  ProductDatabase productDatabase = ProductDatabase.instance;
  PaymentDatabase paymentDatabase = PaymentDatabase.instance;
  OptionTypeDatabase optionTypeDatabase = OptionTypeDatabase.instance;

  List<TaxonModel> getAllEvents() {
  
    
  
  
  
    return taxonDatabase.taxons;
  }

}
