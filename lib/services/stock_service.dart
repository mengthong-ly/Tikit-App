import 'package:event_with_thong/database/database.dart';
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

  Future<void> editStock(StockModel updatedStock) async {
    try {
      final mybox = await getBox<StockModel>('stock');
      int stockIndex =
          mybox.values.toList().indexWhere((stock) => stock.id == updatedStock.id);
      await mybox.put(stockIndex, updatedStock);
      await loadStock();
      Logger().d('edit stock success');
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

  void decreaseStock(String variantId, int quantity) async {
    try {
      final mybox = await getBox<StockModel>('stock');
      final int index = mybox.values.toList().indexWhere(
        (stock) {
          return stock.variantId == variantId;
        },
      );

      stockData.stockDatabase[index].decreaseStock(quantity);
      await mybox.putAll(stockData.stockDatabase.asMap());
      await loadStock();
    } catch (e) {
      Logger().d('decrease Fail');
    }
  }

  void increaseStock(String variantId, int quantity) async {
    try {
      final mybox = await getBox<StockModel>('stock');
      final int index = mybox.values.toList().indexWhere(
        (stock) {
          return stock.variantId == variantId;
        },
      );
      stockData.stockDatabase[index].increaseStock(quantity);
      await mybox.putAll(stockData.stockDatabase.asMap());
      await loadStock();
    } catch (e) {}
  }
}
