import 'package:event_with_thong/database/taxonomies_database.dart';
import 'package:event_with_thong/models/stock.dart';
import 'package:event_with_thong/services/base_service.dart';
import 'package:logger/logger.dart';

class StockService extends BaseService {
  StockService._privateInstance();
  static final StockService _instance = StockService._privateInstance();
  static StockService instance = _instance;

  final StockDatabase stockData = StockDatabase.instance;

  Future<void> loadStock() async {
    try {
      if (await checkBox('stock')) {
        final mybox = await getBox<StockModel>('stock');
        // await mybox.clear();
        // await mybox.deleteFromDisk();
        // await mybox.close();
        stockData.stockDatabase = mybox.values.toList();
      } else {
        final mybox = await getBox<StockModel>('stock');
        await mybox.putAll(stockData.stockDatabase.asMap());
      }
    } catch (e) {
      Logger().d('load stock fail');
    }
  }

  Future<void> addStock(StockModel stock) async {
    try {
      final mybox = await getBox<StockModel>('stock');
      await mybox.add(stock);
      await loadStock();
    } catch (e) {
      Logger().d('add stock fail');
    }
  }

  Future<void> editStock(StockModel stock) async {
    try {
      final mybox = await getBox<StockModel>('stock');
      // await mybox.add(stock);
      int stockIndex =
          mybox.values.toList().indexWhere((stock) => stock.id == stock.id);
      await mybox.put(stockIndex, stock);
      await loadStock();
      
    } catch (e) {
      Logger().d('edit stock fail');
    }
  }

  Future<List<StockModel>> getAllStock() async {
    try {
      if (await checkBox('stock')) {
        final mybox = await getBox<StockModel>('stock');
        return mybox.values.toList();
      }
    } catch (e) {
      Logger().d('getAllStock fail: $e');
    }
    return [];
  }

  StockModel? getStockByVariantId(String variantId) {
    try {
      return stockData.stockDatabase.firstWhere(
        (stock) {
          return stock.variantId == variantId;
        },
      );
    } catch (e) {
      Logger().d('get stock by id fail: $e');
      return null;
    }
  }
}
