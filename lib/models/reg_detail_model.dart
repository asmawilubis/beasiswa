import 'package:beasiswa/models/beasiswa_model.dart';

class RegDetailModel {
  final int id;
  final BeasiswaModel beasiswa;

  RegDetailModel({required this.id, required this.beasiswa});

  // Factory constructor untuk membuat instance RegDetailModel dari JSON
  factory RegDetailModel.fromJson(Map<String, dynamic> json) {
    return RegDetailModel(
      id: json['id'],
      beasiswa: BeasiswaModel.fromJson(json['beasiswa']),
    );
  }
}
