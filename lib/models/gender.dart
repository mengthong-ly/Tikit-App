import 'package:hive/hive.dart';

part 'gender.g.dart';

@HiveType(typeId: 3) // Assign a unique typeId
enum Gender {
  @HiveField(0)
  male('male'),

  @HiveField(1)
  female('female'),

  @HiveField(2)
  other('other');

  final String label;
  const Gender(this.label);
}
