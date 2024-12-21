import 'package:hive/hive.dart';

class BaseService {
  Future<bool> checkBox(String boxName) async {
    return Hive.boxExists(boxName);
  }

  Future<Box<T>> getBox<T>(String boxName) async {
    return Hive.isBoxOpen(boxName)
        ? Hive.box<T>(boxName)
        : await Hive.openBox<T>(boxName);
  }
}
