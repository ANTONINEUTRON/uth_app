// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drug.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drug _$DrugFromJson(Map<String, dynamic> json) => Drug(
      drugName: json['drugName'] as String?,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      manufacturingDate: DateTime.parse(json['manufacturingDate'] as String),
      batchNumber: json['batchNumber'] as String?,
      dosage: json['dosage'] as String?,
      storingCondition: json['storingCondition'] as String?,
    );

Map<String, dynamic> _$DrugToJson(Drug instance) => <String, dynamic>{
      'drugName': instance.drugName,
      'expiryDate': instance.expiryDate.toIso8601String(),
      'manufacturingDate': instance.manufacturingDate.toIso8601String(),
      'batchNumber': instance.batchNumber,
      'dosage': instance.dosage,
      'storingCondition': instance.storingCondition,
    };
