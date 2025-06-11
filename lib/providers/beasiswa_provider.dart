import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/services/beasiswa_services.dart';
import 'package:flutter/widgets.dart';

class BeasiswaProvider with ChangeNotifier {
  List<BeasiswaModel> _beasiswa = [];

  List<BeasiswaModel> get beasiswa => _beasiswa;

  set beasiswa(List<BeasiswaModel> beasiswa) {
    _beasiswa = beasiswa;
    notifyListeners();
  }

  Future<void> getBeasiswa() async {
    try {
      List<BeasiswaModel> beasiswa = await BeasiswaServices().getBeasiswa();
      _beasiswa = beasiswa;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<bool> applyForBeasiswa({
    required String token,
    required int scholarshipId,
    required String description, // Hanya butuh satu field deskripsi
  }) async {
    try {
      await BeasiswaServices().applyForBeasiswa(
        token: token,
        scholarshipId: scholarshipId,
        description: description,
      );
      return true;
    } catch (e) {
      print('Error applying for scholarship: $e');
      return false;
    }
  }
}
