import 'package:json_annotation/json_annotation.dart';

part 'stool_entry.g.dart';

@JsonSerializable()
class StoolEntry {
  final String id;
  final DateTime timestamp;
  final int bristolScale;
  final String color;
  final String hydrationLevel;
  final String aiTip;
  final int healthScore;

  StoolEntry({
    required this.id,
    required this.timestamp,
    required this.bristolScale,
    required this.color,
    required this.hydrationLevel,
    required this.aiTip,
    required this.healthScore,
  });

  factory StoolEntry.fromJson(Map<String, dynamic> json) => _$StoolEntryFromJson(json);
  Map<String, dynamic> toJson() => _$StoolEntryToJson(this);
}
