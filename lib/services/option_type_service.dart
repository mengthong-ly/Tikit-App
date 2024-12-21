import 'package:event_with_thong/database/taxonomies_database.dart';
import 'package:event_with_thong/models/option_type.dart';
import 'package:hive/hive.dart';
import 'package:logger/web.dart';

class OptiontypeService {
  OptiontypeService._privateInstance();
  static final OptiontypeService _instance =
      OptiontypeService._privateInstance();
  static OptiontypeService get instance => _instance;

  Future<bool> _checkBox<T>(String boxName) async {
    return Hive.boxExists(boxName);
  }

  Future<Box<T>> _getBox<T>(String boxName) async {
    return Hive.isBoxOpen(boxName)
        ? Hive.box<T>(boxName)
        : await Hive.openBox<T>(boxName);
  }

  OptionTypeDatabase optionTypeData = OptionTypeDatabase.instance;

  Future<void> load() async {
    try {
      if (await _checkBox<OptionTypeModel>('optionType')) {
        final myBox = await _getBox<OptionTypeModel>('optionType');
        optionTypeData.options = myBox.values.toList();
        Logger().d(optionTypeData.options.length);
        // await myBox.clear();
        // await myBox.deleteFromDisk();
        // await myBox.close();
      } else {
        final myBox = await _getBox<OptionTypeModel>('optionType');
        await myBox.putAll(optionTypeData.options.asMap());
        Logger().d('load option type from File: ');
      }
    } catch (e) {
      Logger().d(
        "Error loading option: $e",
      );
    }
  }

  void getOptionTypeById(String id) {
    try {
      optionTypeData.options.firstWhere((option) => option.id == id);
    } catch (e) {
      Logger().d('error getOptiontypeById: $e');
    }
  }
}
