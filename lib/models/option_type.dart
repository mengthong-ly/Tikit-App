
import 'package:hive/hive.dart';

part 'option_type.g.dart';

@HiveType(typeId: 8)
class OptionTypeModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String type;
  @HiveField(2)
  final String description;

  OptionTypeModel({
    required this.id,
    required this.type,
    required this.description,
  });
  
}
