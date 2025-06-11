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
}
