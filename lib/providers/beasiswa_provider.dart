import 'package:beasiswa/models/beasiswa_model.dart';
import 'package:beasiswa/services/beasiswa_services.dart';
import 'package:flutter/widgets.dart';
import 'package:beasiswa/models/reg_model.dart';

class BeasiswaProvider with ChangeNotifier {
  List<BeasiswaModel> _beasiswa = [];

  List<BeasiswaModel> get beasiswa => _beasiswa;

  List<RegModel> _registrations = [];
  List<RegModel> get registrations => _registrations;

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
      await getRegistrations(token);
      return true;
    } catch (e) {
      print('Error applying for scholarship: $e');
      return false;
    }
  }

  Future<void> getRegistrations(String token) async {
    try {
      List<RegModel> registrationsData = await BeasiswaServices()
          .getRegistrations(token);
      _registrations = registrationsData;
      notifyListeners();
    } catch (e) {
      print('Gagal mendapatkan data pendaftaran: $e');
      rethrow;
    }
  }

  bool isRegistered(int beasiswaId) {
    // Gunakan 'any' untuk mengecek apakah ada elemen yang memenuhi kondisi
    return _registrations.any(
      (reg) => reg.details.any((detail) => detail.beasiswa?.id == beasiswaId),
    );
  }
}
