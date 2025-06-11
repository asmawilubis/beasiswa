import 'package:beasiswa/models/reg_detail_model.dart';

class RegModel {
  final int id;
  final String status;
  final List<RegDetailModel> details;

  RegModel({required this.id, required this.status, required this.details});

  // Factory constructor untuk membuat instance RegModel dari JSON
  factory RegModel.fromJson(Map<String, dynamic> json) {
    // Memastikan 'details' tidak null dan merupakan sebuah list
    var detailsList = json['details'] as List? ?? [];
    return RegModel(
      id: json['id'],
      status: json['status'],
      // Mengubah setiap item di list details menjadi objek RegDetailModel
      details:
          detailsList.map((detail) => RegDetailModel.fromJson(detail)).toList(),
    );
  }
}
