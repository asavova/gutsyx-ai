// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stool_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoolEntry _$StoolEntryFromJson(Map<String, dynamic> json) => StoolEntry(
      id: json['id'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      bristolScale: (json['bristolScale'] as num).toInt(),
      color: json['color'] as String,
      hydrationLevel: json['hydrationLevel'] as String,
      aiTip: json['aiTip'] as String,
      healthScore: (json['healthScore'] as num).toInt(),
    );

Map<String, dynamic> _$StoolEntryToJson(StoolEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'timestamp': instance.timestamp.toIso8601String(),
      'bristolScale': instance.bristolScale,
      'color': instance.color,
      'hydrationLevel': instance.hydrationLevel,
      'aiTip': instance.aiTip,
      'healthScore': instance.healthScore,
    };
