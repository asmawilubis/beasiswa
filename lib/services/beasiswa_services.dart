import 'dart:convert';

import 'package:beasiswa/models/category_model.dart';
import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/models/reg_model.dart';
import 'package:http/http.dart' as http;

class BeasiswaServices {
  String baseUrl = 'http://192.168.1.15:8000/api';

  Future<List<BeasiswaModel>> getBeasiswa({int? categoryId}) async {
    var url = Uri.parse('$baseUrl/scholars');
    if (categoryId != null) {
      url = url.replace(
        queryParameters: {'categories_id': categoryId.toString()},
      );
    }
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['data'];
      return (data as List)
          .map((item) => BeasiswaModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Gagal memuat beasiswa: ${response.body}');
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    var url = Uri.parse('$baseUrl/categories');
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return (data as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Gagal memuat kategori');
    }
  }

  Future<bool> applyForBeasiswa({
    required String token,
    required int scholarshipId,
    required String description,
  }) async {
    var url = Uri.parse('$baseUrl/details');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var body = jsonEncode({
      'description': description,
      'status': 'pending',
      'details': [
        {'beasiswa_id': scholarshipId},
      ],
    });
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal melakukan pendaftaran: ${response.body}');
    }
  }

  Future<List<RegModel>> getRegistrations(String token) async {
    var url = Uri.parse('$baseUrl/regs');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['data'];
      return (data as List).map((reg) => RegModel.fromJson(reg)).toList();
    } else {
      throw Exception('Gagal memuat beasiswa terdaftar');
    }
  }

  Future<List<RegModel>> getAllRegistrations(String token) async {
    var url = Uri.parse('$baseUrl/admin/registrations');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['data'];
      return (data as List).map((reg) => RegModel.fromJson(reg)).toList();
    } else {
      throw Exception('Gagal memuat semua pendaftaran');
    }
  }

  Future<void> updateRegistrationStatus({
    required String token,
    required int regId,
    required String status,
  }) async {
    var url = Uri.parse('$baseUrl/admin/registrations/$regId/status');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var body = jsonEncode({'status': status});
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode != 200) {
      throw Exception('Gagal mengubah status pendaftaran');
    }
  }

  Future<CategoryModel> createCategory({
    required String token,
    required String name,
  }) async {
    var url = Uri.parse('$baseUrl/admin/categories');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var body = jsonEncode({'name': name});

    var response = await http.post(url, headers: headers, body: body);
    print('Admin Create Category Response: ${response.body}');
    print('Admin Create Category Status Code: ${response.statusCode}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      return CategoryModel.fromJson(jsonDecode(response.body)['data']);
    } else if (response.statusCode == 422) {
      var errorData = jsonDecode(response.body)['errors'];
      var firstError = errorData.entries.first.value[0];
      throw Exception('Gagal: $firstError');
    } else {
      throw Exception('Gagal membuat kategori. Status: ${response.statusCode}');
    }
  }

  Future<CategoryModel> updateCategory({
    required String token,
    required int id,
    required String name,
  }) async {
    var url = Uri.parse('$baseUrl/admin/categories/$id');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var body = jsonEncode({'name': name});
    var response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      return CategoryModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      throw Exception('Gagal memperbarui kategori: ${response.body}');
    }
  }

  Future<void> deleteCategory({required String token, required int id}) async {
    var url = Uri.parse('$baseUrl/admin/categories/$id');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var response = await http.delete(url, headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Gagal menghapus kategori: ${response.body}');
    }
  }

  Future<List<CategoryModel>> getAdminCategories(String token) async {
    var url = Uri.parse('$baseUrl/admin/categories');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};
    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // Endpoint admin/categories mengembalikan data di dalam key 'data'
      var data = jsonDecode(response.body)['data'];
      return (data as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Gagal memuat kategori dari admin endpoint');
    }
  }
}
