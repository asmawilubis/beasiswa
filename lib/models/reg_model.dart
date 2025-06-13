import 'package:beasiswa/models/reg_detail_model.dart';
import 'package:beasiswa/models/user_model.dart';

class RegModel {
  final int id;
  String status;
  final String description;
  final List<RegDetailModel> details;
  final UserModel? user;

  RegModel({
    required this.id,
    required this.status,
    required this.details,
    required this.description,
    this.user,
  });

  // Factory constructor untuk membuat instance RegModel dari JSON
  factory RegModel.fromJson(Map<String, dynamic> json) {
    // Memastikan 'details' tidak null dan merupakan sebuah list
    var detailsList = json['details'] as List? ?? [];
    return RegModel(
      id: json['id'],
      status: json['status'],
      description: json['description'] ?? '',
      // Mengubah setiap item di list details menjadi objek RegDetailModel
      details:
          detailsList.map((detail) => RegDetailModel.fromJson(detail)).toList(),
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}
