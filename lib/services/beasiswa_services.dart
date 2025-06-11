import 'dart:convert';

import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/models/reg_model.dart';
import 'package:http/http.dart' as http;

class BeasiswaServices {
  String baseUrl = 'http://192.168.1.15:8000/api';

  Future<List<BeasiswaModel>> getBeasiswa() async {
    var url = Uri.parse('$baseUrl/scholars');
    var headers = {'Content-Type': 'application/json'};

    var response = await http.get(url, headers: headers);

    print(response.body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data']['data'];

      List<BeasiswaModel> beasiswaList =
          (data as List).map((item) => BeasiswaModel.fromJson(item)).toList();
      return beasiswaList;
    } else {
      throw Exception('Failed to load beasiswa: ${response.body}');
    }
  }

  Future<bool> applyForBeasiswa({
    required String token,
    required int scholarshipId,
    required String
    description, // Ini akan berisi gabungan alasan, no. telp, dan prestasi
  }) async {
    // Sesuaikan dengan endpoint di routes/api.php Anda, misal: '/regs' atau '/registrations'
    // Berdasarkan RegController, methodnya bernama 'details', jadi kita asumsikan routenya '/details'
    var url = Uri.parse('$baseUrl/details');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    // Struktur body disesuaikan dengan yang diharapkan RegController
    var body = jsonEncode({
      'description': description,
      'status':
          'pending', // Sesuai validasi di controller: 'pending', 'accepted', 'rejected'
      'details': [
        {'beasiswa_id': scholarshipId},
      ],
    });

    print('Apply Request Body: $body');
    var response = await http.post(url, headers: headers, body: body);
    print('Apply Response: ${response.body}');

    if (response.statusCode == 200) {
      return true;
    } else {
      // Tangani error validasi dari Laravel (status code 422)
      if (response.statusCode == 422) {
        var errorData = jsonDecode(response.body)['errors'];
        throw Exception('Gagal melakukan pendaftaran: $errorData');
      }
      throw Exception('Gagal melakukan pendaftaran: ${response.body}');
    }
  }

  // --- TAMBAHKAN FUNGSI INI ---
  Future<List<RegModel>> getRegistrations(String token) async {
    // Sesuaikan dengan endpoint di routes/api.php Anda, biasanya '/regs'
    var url = Uri.parse('$baseUrl/reg');
    var headers = {'Content-Type': 'application/json', 'Authorization': token};

    var response = await http.get(url, headers: headers);
    print('Get Registrations Response: ${response.body}');

    if (response.statusCode == 200) {
      // API Laravel dengan paginate() mengembalikan struktur { data: [...] }
      var data = jsonDecode(response.body)['data']['data'];
      List<RegModel> registrations =
          (data as List).map((reg) => RegModel.fromJson(reg)).toList();
      return registrations;
    } else {
      throw Exception('Gagal memuat beasiswa terdaftar');
    }
  }
}
