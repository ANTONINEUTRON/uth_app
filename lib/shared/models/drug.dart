import 'package:json_annotation/json_annotation.dart';

part 'drug.g.dart';

@JsonSerializable()
class Drug{
  String? drugName;
  DateTime expiryDate = DateTime.now();
  DateTime manufacturingDate = DateTime.now();
  String? batchNumber;
  String? dosage;
  String? storingCondition;

  Drug({
    required this.drugName,
    required this.expiryDate,
    required this.manufacturingDate,
    required this.batchNumber,
    required this.dosage,
    required this.storingCondition
  });

  Map<String, dynamic> toJson() => _$DrugToJson(this);
}