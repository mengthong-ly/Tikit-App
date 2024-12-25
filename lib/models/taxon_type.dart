import 'package:hive/hive.dart';
part 'taxon_type.g.dart';

@HiveType(typeId: 15)
enum TaxonType {
  @HiveField(0)
  sport,
  @HiveField(1)
  education,
  @HiveField(2)
  nationalEvent,
  @HiveField(3)
  conference,
  @HiveField(4)
  workshop,
  @HiveField(5)
  exhibition,
  @HiveField(6)
  book,
  @HiveField(7)
  podcast,
  @HiveField(8)
  concert,
  @HiveField(9)
  fun,
  @HiveField(10)
  game,
  @HiveField(11)
  other,
  @HiveField(12)
  charity;
}

extension TaaxonTypeExtension on TaxonType {
  String get typeString {
    switch (this) {
      case TaxonType.sport:
        return 'Sport';
      case TaxonType.education:
        return 'Education';
      case TaxonType.nationalEvent:
        return 'National Event';
      case TaxonType.conference:
        return 'Conference';
      case TaxonType.workshop:
        return 'Workshop';
      case TaxonType.exhibition:
        return 'Exhibition';
      case TaxonType.book:
        return 'Book';
      case TaxonType.podcast:
        return 'Podcast';
      case TaxonType.concert:
        return 'Concert';
      case TaxonType.game:
        return 'Game';
      case TaxonType.fun:
        return 'Fun';
      case TaxonType.other:
        return 'Other';
        case TaxonType.charity:
        return 'Charity';
        
    }
  }
}
