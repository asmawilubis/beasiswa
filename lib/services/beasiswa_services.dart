import 'dart:convert';

import 'package:beasiswa/models/beasiswa_model.dart';
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
}
